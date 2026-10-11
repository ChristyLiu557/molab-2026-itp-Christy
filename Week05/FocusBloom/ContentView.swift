import SwiftUI
import Combine

// Page 1: choose a duration, then open the timer page.
struct HomeView: View {
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
                    Text("Your selected duration is saved for next time.")
                        .font(.caption).foregroundStyle(.secondary)
                }.padding(24)
            }
            .background(Color(red: 0.95, green: 0.96, blue: 0.91))
            .tint(green)
        }
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
                    if timer.isComplete { timer.reset(); timer.start() }
                    else if timer.isRunning { timer.pause() }
                    else { timer.start() }
                } label: {
                    Text(timer.isComplete ? "Start again" : timer.isRunning ? "Pause" : "Start / Resume")
                        .font(.headline).frame(maxWidth: .infinity).padding()
                        .background(green, in: Capsule()).foregroundStyle(.white)
                }
                Button("Reset") { timer.reset() }
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
}
