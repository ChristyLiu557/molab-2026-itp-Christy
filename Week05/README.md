Week05 — Focus Bloom

A two-page SwiftUI focus timer with start, pause, resume, and reset controls.

What's New
Added `@AppStorage` to remember the selected duration after restarting the app.

```swift
@AppStorage("focusDurationMinutes") private var minutes = 5
```

The default is 5 minutes. Only the selected duration is saved, not an unfinished countdown.

Run and Test
1. Open `FocusBloom.xcodeproj` in Xcode.
2. Select an iPhone simulator and press **Command + R**.
3. Choose **10 min**, stop the app, and run it again.
4. Check that **10 min** is still selected.
