import SwiftUI
import Combine
import PhotosUI
import CoreTransferable
import UniformTypeIdentifiers
import AVKit
import CoreImage
import CoreImage.CIFilterBuiltins

// Copy the picker-owned file before its temporary URL expires.
struct ImportedMovie: Transferable {
    let url: URL
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let folder = FileManager.default.temporaryDirectory
                .appendingPathComponent("VideoMoodImports", isDirectory: true)
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let ext = received.file.pathExtension.isEmpty ? "mov" : received.file.pathExtension
            let copy = folder.appendingPathComponent(UUID().uuidString).appendingPathExtension(ext)
            try FileManager.default.copyItem(at: received.file, to: copy)
            return ImportedMovie(url: copy)
        }
    }
}

enum VideoMood: String, CaseIterable, Identifiable, Sendable {
    case original = "Original"
    case sunshine = "Sunshine"
    case monochrome = "Dreamy B&W"
    var id: String { rawValue }
    var caption: String {
        switch self {
        case .original: return "Keep the moment as it is."
        case .sunshine: return "Turn an everyday walk into a warm memory."
        case .monochrome: return "Slow down and notice light and shadow."
        }
    }
}

enum MovieError: LocalizedError {
    case unreadable, tooLong, cannotExport, composition
    var errorDescription: String? {
        switch self {
        case .unreadable: return "This video could not be read. Try a short video recorded on your iPhone."
        case .tooLong: return "Please choose a video between 1 and 60 seconds for this class prototype."
        case .cannotExport: return "This video could not be exported as MP4. Try another video."
        case .composition: return "The video effect could not be prepared."
        }
    }
}

@MainActor
final class MovieModel: ObservableObject {
    @Published var sourcePlayer: AVPlayer?
    @Published var resultPlayer: AVPlayer?
    @Published var busy = false
    @Published var status = "Choose a short video to begin."
    @Published var error: String?
    @Published var outputURL: URL?
    @Published var renderedLabel = ""
    private var sourceURL: URL?
    @Published private var exporter: AVAssetExportSession?
    private var importTask: Task<Void, Never>?
    private var exportTask: Task<Void, Never>?

    init() {
        // Only remove this app's disposable files, never the user's library.
        for name in ["VideoMoodImports", "VideoMoodExports"] {
            let folder = FileManager.default.temporaryDirectory.appendingPathComponent(name)
            try? FileManager.default.removeItem(at: folder)
        }
    }

    func load(_ selection: PhotosPickerItem) {
        guard !busy else { return }
        busy = true
        error = nil
        status = "Importing video…"
        sourcePlayer?.pause()
        resultPlayer?.pause()
        importTask = Task {
            var copiedURL: URL?
            do {
                guard let movie = try await selection.loadTransferable(type: ImportedMovie.self) else {
                    throw MovieError.unreadable
                }
                copiedURL = movie.url
                let asset = AVURLAsset(url: movie.url)
                let duration = try await asset.load(.duration).seconds
                let tracks = try await asset.loadTracks(withMediaType: .video)
                guard !tracks.isEmpty else { throw MovieError.unreadable }
                guard duration.isFinite, duration >= 1, duration <= 60 else { throw MovieError.tooLong }
                clearResult()
                sourcePlayer?.replaceCurrentItem(with: nil)
                if let old = sourceURL { try? FileManager.default.removeItem(at: old) }
                sourceURL = movie.url
                sourcePlayer = AVPlayer(url: movie.url)
                status = "Video ready. Choose a mood, then create your video."
            } catch {
                if let copiedURL { try? FileManager.default.removeItem(at: copiedURL) }
                self.error = error.localizedDescription
                status = sourceURL == nil ? "Choose another video to try again." : "Your previous video is still available."
            }
            busy = false
        }
    }

    func clearResult() {
        resultPlayer?.pause()
        resultPlayer?.replaceCurrentItem(with: nil)
        resultPlayer = nil
        // Keep generated files until a later app launch so an open share sheet
        // can finish reading them. Files are temporary, not a saved journal.
        outputURL = nil
        renderedLabel = ""
    }

    func render(mood: VideoMood, strength: Double) {
        guard !busy, let sourceURL else { return }
        busy = true
        error = nil
        clearResult()
        sourcePlayer?.pause()
        status = "Creating video… Keep the app open."
        exportTask = Task {
            var destination: URL?
            do {
                let asset = AVURLAsset(url: sourceURL)
                // The asynchronous factory supports iOS 16; newer SDKs may
                // show a deprecation warning in favor of the iOS 26 API.
                let composition: AVVideoComposition = try await withCheckedThrowingContinuation { continuation in
                    AVVideoComposition.videoComposition(with: asset, applyingCIFiltersWithHandler: { request in
                        let input = request.sourceImage
                        let result: CIImage
                        switch mood {
                        case .original:
                            result = input
                        case .sunshine:
                            let filter = CIFilter.sepiaTone()
                            filter.inputImage = input
                            filter.intensity = Float(strength)
                            result = filter.outputImage ?? input
                        case .monochrome:
                            let filter = CIFilter.colorControls()
                            filter.inputImage = input
                            filter.saturation = Float(1 - strength)
                            filter.contrast = Float(1 + 0.15 * strength)
                            result = filter.outputImage ?? input
                        }
                        request.finish(with: result.cropped(to: input.extent), context: nil)
                    }, completionHandler: { composition, error in
                        if let composition { continuation.resume(returning: composition) }
                        else { continuation.resume(throwing: error ?? MovieError.composition) }
                    })
                }
                guard let session = AVAssetExportSession(asset: asset, presetName: AVAssetExportPreset1280x720),
                      session.supportedFileTypes.contains(.mp4) else { throw MovieError.cannotExport }
                let folder = FileManager.default.temporaryDirectory
                    .appendingPathComponent("VideoMoodExports", isDirectory: true)
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                let url = folder.appendingPathComponent("VideoMood-\(UUID().uuidString).mp4")
                destination = url
                session.outputURL = url
                session.outputFileType = .mp4
                session.videoComposition = composition
                session.shouldOptimizeForNetworkUse = true
                exporter = session
                // This compatibility API exports the actual filtered frames.
                // Source audio is retained by the asset export when supported.
                await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
                    session.exportAsynchronously { continuation.resume() }
                }
                guard session.status == .completed else {
                    if session.status == .cancelled { throw CancellationError() }
                    throw session.error ?? MovieError.cannotExport
                }
                outputURL = url
                resultPlayer = AVPlayer(url: url)
                renderedLabel = mood == .original ? mood.rawValue : "\(mood.rawValue) · \(Int(strength * 100))%"
                status = "Ready! Play the result, then share or save it to Files."
            } catch is CancellationError {
                if let destination { try? FileManager.default.removeItem(at: destination) }
                status = "Export canceled. You can try again."
            } catch {
                if let destination { try? FileManager.default.removeItem(at: destination) }
                self.error = error.localizedDescription
                status = "Export failed. Try another mood or video."
            }
            exporter = nil
            busy = false
        }
    }

    func cancelExport() { exporter?.cancelExport() }
    var canCancelExport: Bool { exporter != nil }
    func pausePlayback() {
        sourcePlayer?.pause()
        resultPlayer?.pause()
    }
}

struct ContentView: View {
    @StateObject private var model = MovieModel()
    @State private var selection: PhotosPickerItem?
    @State private var mood: VideoMood = .sunshine
    @State private var strength = 0.45
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("One moment. A different feeling.")
                        .font(.largeTitle.bold())
                    Text("Make a tiny color story from your everyday walk.")
                        .foregroundStyle(.secondary)
                    PhotosPicker(selection: $selection, matching: .videos) {
                        Label(model.sourcePlayer == nil ? "Choose a video" : "Choose another video",
                              systemImage: "video.badge.plus")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(model.busy)
                    Text("Use a 1–60 second clip. Your original stays unchanged.")
                        .font(.footnote).foregroundStyle(.secondary)
                    if let player = model.sourcePlayer {
                        Text("Original").font(.headline)
                        VideoPlayer(player: player).frame(height: 240).clipShape(RoundedRectangle(cornerRadius: 16))
                        VStack(alignment: .leading, spacing: 12) {
                            Picker("Mood", selection: $mood) {
                                ForEach(VideoMood.allCases) { Text($0.rawValue).tag($0) }
                            }
                            Text(mood.caption).font(.callout).foregroundStyle(.secondary)
                            if mood != .original {
                                Text("Effect strength: \(Int(strength * 100))%")
                                Slider(value: $strength, in: 0...1, step: 0.05)
                                    .accessibilityLabel("Effect strength")
                            }
                            Button {
                                model.render(mood: mood, strength: strength)
                            } label: {
                                Label("Create mood video", systemImage: "wand.and.stars")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .disabled(model.busy)
                    }
                    if model.busy {
                        ProgressView()
                        if model.canCancelExport {
                            Button("Cancel export", role: .cancel) { model.cancelExport() }
                        }
                    }
                    Text(model.status).font(.callout)
                        .accessibilityLabel("Status: \(model.status)")
                    if let error = model.error {
                        Text(error).foregroundStyle(.red)
                    }
                    if let url = model.outputURL, let player = model.resultPlayer {
                        Divider()
                        Text("Your result · \(model.renderedLabel)").font(.headline)
                        VideoPlayer(player: player).frame(height: 240).clipShape(RoundedRectangle(cornerRadius: 16))
                        ShareLink(item: url) {
                            Label("Share / Save video", systemImage: "square.and.arrow.up")
                        }
                        .buttonStyle(.borderedProminent)
                        Text("This shares a processed MP4. Save to Files to keep it; the in-app result is temporary.")
                            .font(.footnote).foregroundStyle(.secondary)
                    }
                }
                .padding(24)
            }
            .background(Color.orange.opacity(0.04))
            .navigationTitle("Video Mood")
            .onChange(of: selection) { item in
                if let item {
                    model.load(item)
                    selection = nil // Allow selecting the same clip again after an error.
                }
            }
            .onChange(of: mood) { _ in model.clearResult() }
            .onChange(of: strength) { _ in model.clearResult() }
            .onChange(of: scenePhase) { phase in
                if phase != .active { model.pausePlayback() }
            }
        }
    }
}

