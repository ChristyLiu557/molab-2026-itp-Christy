import SwiftUI
import Combine

// Page 1: choose a duration, then open the timer page.
struct HomeView: View {
    @StateObject private var history = SessionStore()
    // AppStorage saves this preference between app launches.
    @AppStorage("focusDurationMinutes") private var minutes = 5
    private let green = Color(red: 0.22, green: 0.40, blue: 0.31)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 70)).foregroundStyle(green)
                        .padding(.top, 36)
                    Text("Focus Bloom")
                        .font(.largeTitle.bold())
                    Text("A little time. A little growth.")
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("YOUR FOCUS TIME").font(.caption.bold())
                        Picker("Duration", selection: $minutes) {
                            ForEach([1, 5, 10, 25], id: \.self) { value in
                                Text("\(value) min").tag(value)
                            }
                        }
                        .pickerStyle(.segmented)
                        Text("Put your phone down and give one task your attention.")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    .padding(24).background(.white, in: RoundedRectangle(cornerRadius: 24))
                    NavigationLink {
                        TimerPage(duration: TimeInterval(minutes * 60))
                    } label: {
                        Text("Open timer").font(.headline).frame(maxWidth: .infinity)
                            .padding().background(green, in: Capsule()).foregroundStyle(.white)
                    }
                    NavigationLink("Try a 10-second demo") {
                        TimerPage(duration: 10)
                    }
                    .font(.subheadline)
                    NavigationLink("View history") {
                        HistoryPage()
                    }
                    Text("Your selected duration is saved for next time.")
                        .font(.caption).foregroundStyle(.secondary)
                }.padding(24)
            }
            .background(Color(red: 0.95, green: 0.96, blue: 0.91))
            .tint(green)
        }
        .environmentObject(history)
    }
}

// Date-based timing avoids counting delayed timer callbacks as exact seconds.
final class FocusTimer: ObservableObject {
    let duration: TimeInterval
    @Published private(set) var remaining: TimeInterval
    @Published private(set) var isRunning = false
    @Published private(set) var isComplete = false
    private var endDate: Date?

    init(duration: TimeInterval) {
        self.duration = duration
        self.remaining = duration
    }

    var progress: Double { 1 - remaining / duration }
    var displayTime: String {
        let seconds = Int(ceil(remaining))
        return String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }

    func start() {
        guard !isRunning, !isComplete else { return }
        endDate = Date().addingTimeInterval(remaining)
        isRunning = true
    }

    func update() {
        guard isRunning, let endDate else { return }
        remaining = max(0, endDate.timeIntervalSinceNow)
        if remaining == 0 {
            isRunning = false
            isComplete = true
            self.endDate = nil
        }
    }

    func pause() {
        update()
        isRunning = false
        endDate = nil
    }

    func reset() {
        isRunning = false
        isComplete = false
        endDate = nil
        remaining = duration
    }
}

// Page 2: the timer is owned by this page, so back navigation ends the session.
struct TimerPage: View {
    @StateObject private var timer: FocusTimer
    @EnvironmentObject private var history: SessionStore
    @State private var sessionID = UUID()
    @State private var saved = false
    @Environment(\.scenePhase) private var scenePhase
    private let ticks = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let green = Color(red: 0.22, green: 0.40, blue: 0.31)

    init(duration: TimeInterval) {
        _timer = StateObject(wrappedValue: FocusTimer(duration: duration))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                Text(timer.isComplete ? "You made space to grow." : "Let your focus grow.")
                    .font(.title2.bold()).multilineTextAlignment(.center)
                    .padding(.top, 24)
                ZStack {
                    Circle().stroke(green.opacity(0.12), lineWidth: 12)
                    Circle().trim(from: 0, to: timer.progress)
                        .stroke(green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 14) {
                        Image(systemName: timer.isComplete ? "checkmark.seal.fill" : "leaf.fill")
                            .font(.system(size: 44)).foregroundStyle(green)
                        Text(timer.displayTime)
                            .font(.system(size: 48, weight: .medium, design: .rounded))
                            .monospacedDigit()
                        Text(timer.isComplete ? "COMPLETE" : timer.isRunning ? "FOCUSING" : "READY / PAUSED")
                            .font(.caption.bold()).foregroundStyle(.secondary)
                    }
                }
                .frame(width: 270, height: 270)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .accessibilityValue(timer.displayTime)
                Text(timer.isComplete ? "One small session, one step forward." : "Breathe. Stay with one thing.")
                    .foregroundStyle(.secondary)
                Button {
                    if timer.isComplete { resetSession(); timer.start() }
                    else if timer.isRunning { timer.pause() }
                    else { timer.start() }
                } label: {
                    Text(timer.isComplete ? "Start again" : timer.isRunning ? "Pause" : "Start / Resume")
                        .font(.headline).frame(maxWidth: .infinity).padding()
                        .background(green, in: Capsule()).foregroundStyle(.white)
                }
                Button("Reset") { resetSession() }
                if timer.isComplete {
                    Button(saved ? "Saved to history" : "Save session") {
                        saved = history.add(FocusSession(id: sessionID, savedAt: Date(), seconds: Int(timer.duration)))
                    }
                    .disabled(saved)
                    NavigationLink("View history") { HistoryPage() }
                }
                if let error = history.errorMessage {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
                Text("Going back ends this session. If you leave the app, the countdown catches up when you return. No background alarm is sent.")
                    .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
            }.padding(24)
        }
        .background(Color(red: 0.95, green: 0.96, blue: 0.91))
        .navigationTitle("Focus session")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(ticks) { _ in timer.update() }
        .onChange(of: scenePhase) { phase in
            if phase == .active { timer.update() }
        }
    }

    private func resetSession() {
        timer.reset()
        sessionID = UUID()
        saved = false
    }
}

// Codable converts session records to and from a local JSON file.
struct FocusSession: Identifiable, Codable {
    let id: UUID
    let savedAt: Date
    let seconds: Int

    var durationLabel: String {
        seconds < 60 ? "\(seconds) sec demo" : "\(seconds / 60) min"
    }
}

final class SessionStore: ObservableObject {
    @Published private(set) var sessions: [FocusSession] = []
    @Published private(set) var errorMessage: String?
    private var fileURL: URL?
    private var canSave = false

    init() {
        do {
            let folder = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = folder.appendingPathComponent("focus-sessions.json")
            fileURL = url
            if FileManager.default.fileExists(atPath: url.path) {
                let data = try Data(contentsOf: url)
                sessions = try JSONDecoder().decode([FocusSession].self, from: data)
            }
            canSave = true
        } catch {
            // Do not overwrite an existing file if loading it failed.
            errorMessage = "History could not be loaded. Existing data has not been overwritten."
        }
    }

    @discardableResult
    func add(_ session: FocusSession) -> Bool {
        guard canSave, let fileURL else { return false }
        guard !sessions.contains(where: { $0.id == session.id }) else { return true }
        let updated = [session] + sessions
        do {
            let data = try JSONEncoder().encode(updated)
            try data.write(to: fileURL, options: .atomic)
            sessions = updated
            errorMessage = nil
            return true
        } catch {
            errorMessage = "Session could not be saved. Please try again."
            return false
        }
    }
}

struct HistoryPage: View {
    @EnvironmentObject private var history: SessionStore

    var body: some View {
        List {
            if let error = history.errorMessage {
                Text(error).foregroundStyle(.red)
            }
            if history.sessions.isEmpty {
                Text("No saved sessions yet. Finish a timer and tap Save session.")
                    .foregroundStyle(.secondary)
            }
            ForEach(history.sessions) { session in
                VStack(alignment: .leading, spacing: 6) {
                    Label(session.durationLabel, systemImage: "checkmark.circle.fill")
                        .font(.headline).foregroundStyle(.green)
                    Text(session.savedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("History")
    }
}
