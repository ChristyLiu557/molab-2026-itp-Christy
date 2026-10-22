import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import ImageIO
import UIKit

// 一张导入的照片；id 让 SwiftUI 能用 sheet(item:) 打开编辑页。
struct SelectedPhoto: Identifiable {
    let id = UUID()
    let image: UIImage
}

enum Mood: String, CaseIterable, Identifiable {
    case original = "Original"
    case warm = "Warm"
    case mono = "B&W"
    var id: String { rawValue }
    var caption: String {
        switch self {
        case .original: return "Keep the moment as it is."
        case .warm: return "A little sunshine for your memory."
        case .mono: return "Let light and shadows tell the story."
        }
    }
}

struct PhotoOutput {
    let image: UIImage
    let file: URL
}

enum PhotoError: LocalizedError {
    case unreadable, exportFailed
    var errorDescription: String? {
        switch self {
        case .unreadable: return "This photo could not be loaded. Please try another image."
        case .exportFailed: return "The edited photo could not be exported. Please try again."
        }
    }
}

// actor 在主界面之外串行处理图片，避免调色过程卡住界面。
actor PhotoProcessor {
    static let shared = PhotoProcessor()
    private let context = CIContext()

    func importPhoto(_ data: Data) throws -> UIImage {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            throw PhotoError.unreadable
        }
        // 长边最多 2048 像素，同时修正手机照片的旋转方向。
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: 2048
        ]
        guard let image = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) else {
            throw PhotoError.unreadable
        }
        return UIImage(cgImage: image)
    }

    func render(_ image: UIImage, mood: Mood, folder: URL) throws -> PhotoOutput {
        guard let cgImage = image.cgImage else { throw PhotoError.unreadable }
        let input = CIImage(cgImage: cgImage)
        let output: CIImage
        switch mood {
        case .original:
            output = input
        case .warm:
            let filter = CIFilter.sepiaTone()
            filter.inputImage = input
            filter.intensity = 0.45
            guard let result = filter.outputImage else { throw PhotoError.exportFailed }
            output = result
        case .mono:
            let filter = CIFilter.photoEffectMono()
            filter.inputImage = input
            guard let result = filter.outputImage else { throw PhotoError.exportFailed }
            output = result
        }
        guard let rendered = context.createCGImage(output, from: input.extent) else {
            throw PhotoError.exportFailed
        }
        let preview = UIImage(cgImage: rendered)
        guard let data = preview.jpegData(compressionQuality: 0.9) else {
            throw PhotoError.exportFailed
        }
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        // 每种效果一个 JPEG；分享的是实际调色后的文件。
        let filename = mood == .mono ? "PhotoMood-BW.jpg" : "PhotoMood-\(mood.rawValue).jpg"
        let url = folder.appendingPathComponent(filename)
        try data.write(to: url, options: .atomic)
        return PhotoOutput(image: preview, file: url)
    }
}

struct ContentView: View {
    @State private var selection: PhotosPickerItem?
    @State private var photo: SelectedPhoto?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Image(systemName: "camera.filters")
                    .font(.system(size: 76))
                    .foregroundStyle(.purple)
                    .accessibilityHidden(true)
                Text("One photo. Three moods.")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                Text("Choose a moment, change its feeling, and share it.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                PhotosPicker(selection: $selection, matching: .images) {
                    Label("Choose a photo", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(isLoading)
                if isLoading { ProgressView("Loading photo…") }
                if let errorMessage {
                    Text(errorMessage).foregroundStyle(.red)
                }
                Spacer()
                Text("Your original photo stays unchanged.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(28)
            .navigationTitle("Photo Mood")
            .background(Color.purple.opacity(0.04))
        }
        // 选择发生变化后异步读取数据；只拿到用户选中的照片。
        .task(id: selection) {
            guard let selection else { return }
            isLoading = true
            errorMessage = nil
            defer { isLoading = false }
            do {
                guard let data = try await selection.loadTransferable(type: Data.self) else {
                    throw PhotoError.unreadable
                }
                let image = try await PhotoProcessor.shared.importPhoto(data)
                try Task.checkCancellation()
                photo = SelectedPhoto(image: image)
            } catch is CancellationError {
                return
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        .sheet(item: $photo, onDismiss: { selection = nil }) { photo in
            PhotoEditor(photo: photo)
        }
    }
}

struct PhotoEditor: View {
    let photo: SelectedPhoto
    @Environment(\.dismiss) private var dismiss
    @State private var mood: Mood = .original
    @State private var output: PhotoOutput?
    @State private var renderedMood: Mood?
    @State private var errorMessage: String?
    @State private var isRendering = false
    // 临时导出文件不等于永久收藏；用户需分享或保存到 Files。
    @State private var folder = FileManager.default.temporaryDirectory
        .appendingPathComponent("PhotoMood-\(UUID().uuidString)", isDirectory: true)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    Image(uiImage: output?.image ?? photo.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 420)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .accessibilityLabel("Photo preview")
                    Picker("Mood", selection: $mood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(mood.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    if isRendering { ProgressView("Applying mood…") }
                    if let errorMessage {
                        Text(errorMessage).foregroundStyle(.red)
                        Button("Try again") { Task { await render() } }
                    }
                    if let output, renderedMood == mood, !isRendering, errorMessage == nil {
                        ShareLink(item: output.file) {
                            Label("Share photo", systemImage: "square.and.arrow.up")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                    Text("Share the JPEG or choose Save to Files. Export size: up to 2048 pixels on the longest side.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(24)
            }
            .navigationTitle("Choose your mood")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .task(id: mood) { await render() }
    }

    @MainActor
    private func render() async {
        let requestedMood = mood
        isRendering = true
        errorMessage = nil
        do {
            let result = try await PhotoProcessor.shared.render(photo.image, mood: requestedMood, folder: folder)
            try Task.checkCancellation()
            guard requestedMood == mood else { return }
            output = result
            renderedMood = requestedMood
            isRendering = false
        } catch is CancellationError {
            // 新任务负责更新界面，旧任务不覆盖新结果。
            return
        } catch {
            guard requestedMood == mood else { return }
            errorMessage = error.localizedDescription
            isRendering = false
        }
    }
}
