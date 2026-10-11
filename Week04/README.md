# Week04 — Focus Bloom

A two-page SwiftUI focus timer. iPhone / iOS 16 or later. No packages or audio assets required. The assignment allows time **and/or** audio; this app implements time.

## Run in Xcode（运行步骤）
1. 解压，双击 `FocusBloom.xcodeproj`。不要只打开 Swift 文件。
2. 顶部 Scheme 选择 `FocusBloom`，运行设备选择已安装的 iPhone 模拟器，然后按 ⌘R。
3. 真机运行：连接 iPhone，在 Signing & Capabilities → Team 选择自己的 Personal Team；如提示标识符冲突，修改 Bundle Identifier。手机需满足 iOS 16+。
4. 首页点 `Try a 10-second demo`，第二页点 `Start / Resume` 即可演示。

## Files and concepts
- `FocusBloomApp.swift`: app entry point.
- `ContentView.swift`: HomeView, FocusTimer, TimerPage.
- `@State`: selected duration on page 1.
- `NavigationStack` / `NavigationLink`: navigation between two pages.
- `@StateObject` / `@Published`: keep timer state and refresh the interface.
- `Timer.publish`: refresh the displayed time every 0.1 seconds.
- `Date`: calculate actual remaining time rather than subtracting one each tick.
- `Circle.trim`: show elapsed progress as a ring.

## Behavior and limits
Start begins counting; Pause freezes the remaining duration; Resume continues; Reset returns to the selected duration. Completion shows a checkmark. Back navigation ends the session. Time catches up after backgrounding while the app remains alive, but there is no background notification, audio, or persistence after force-quitting. No completed-session history is stored.

## Validation
Source and project structure were reviewed during generation. This environment has no Xcode or Swift compiler; this project has NOT been compiled or run on iOS here.

Before submission, verify in Xcode:
- [ ] Both pages open; each preset displays the selected duration.
- [ ] 10-second demo reaches 00:00 and COMPLETE.
- [ ] Pause stays fixed for several seconds; Resume continues.
- [ ] Reset returns to the full duration; Start again begins a fresh session.
- [ ] Background for several seconds and return; time catches up.
- [ ] Back returns home; a new selection starts a fresh timer.
- [ ] Capture one screenshot of each page for the wiki.

## Submit
1. Upload this entire **uncompressed Week04 folder** to your homework repository, keeping the `.xcodeproj` and Swift files together. Do not upload only the ZIP.
2. Copy the GitHub URL of the uploaded Week04 folder.
3. Use `WIKI_WEEK04.md` for your own wiki page. Replace placeholders, review the draft, and add actual run results and screenshots.
4. Edit the course wiki home page at https://github.com/molab-itp/content-2026-itp/wiki#week-04-homework and add the line in `SUBMISSION_LINK.md` under Week 04, following the existing class format.
5. Add this week's summary to your personal wiki. Future weeks need their own real progress updates.

If you do not have permission to edit the course wiki, ask the instructor for access.
