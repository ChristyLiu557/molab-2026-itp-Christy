# Week08 — Video Mood
A SwiftUI video manipulation prototype by Christy Liu.

## Idea and personal twist
“One moment. A different feeling.” Import a short clip from an everyday walk and turn it into a small mood study. Choose Original, Sunshine (sepia warmth), or Dreamy B&W (desaturation with a little extra contrast), adjust strength, then generate a processed MP4. Compare the original with the result.

This continues Week07 Photo Mood and Week03 color interaction. The class's [CameraRecorder](https://github.com/molab-itp/08-CameraRecorder) and [FilterTheWorld](https://github.com/molab-itp/08-FilterTheWorld) provide the theme of filtering video. This is a separately written library-import app, not a claim that those sample projects were run or copied.

## Included
- A complete Xcode project and Swift source files, targeting iPhone / iOS 16+.
- Video import through the system Photos picker; a copy of the chosen file is used.
- Three looks, adjustable effect strength, original and processed playback.
- MP4 generation with AVFoundation and per-frame Core Image effects.
- Export cancellation, error messages, and sharing / Save to Files.
- A 1–60 second input limit to keep the class prototype manageable.
- Original media stays unchanged. Output is temporary until saved or shared.
- No camera recording, live camera filter, trimming, login, or cloud storage.

## Open and run
1. Install/open full Xcode (Xcode 14+ supports the deployment target; use a version compatible with your Mac and device).
2. Double-click **VideoMood.xcodeproj** in this folder.
3. Choose the VideoMood scheme and an installed iPhone simulator. Press **Command–R**.
4. For a physical iPhone, select your Apple team under Signing & Capabilities and use a unique bundle identifier if Xcode requests one.
5. Put a short video in the simulator's Photos library, or use a real iPhone with an existing video.
6. Tap **Choose a video**. Start with a 5–10 second ordinary SDR iPhone clip.
7. Select Sunshine and 45% strength, then tap **Create mood video**. Keep the app foregrounded.
8. Play the original and result separately. Use **Share / Save video → Save to Files**, then open the saved MP4 outside the app.
9. Repeat with Dreamy B&W at 100% and Original.

The effect is rendered after pressing Create, not live while moving the slider. Changing controls clears the previous result to prevent sharing a stale effect. Original still exports a new encoded MP4; it is not a bit-for-bit copy.

The app uses the system picker rather than requesting broad photo-library access. It does not write directly into Photos; use the share sheet. Audio is expected to be retained when supported by the source/export format and must be checked on-device.

## Validation status
- Xcode project file: passed local `plutil -lint`.
- Full iOS build and simulator/device tests: **not run**. Full Xcode is unavailable in the current environment.
- A Swift syntax-only attempt was blocked by the local toolchain's duplicate SwiftBridging module definitions; it is not a source-code pass or a confirmed app defect.
- See [TEST_CHECKLIST.md](TEST_CHECKLIST.md). Do not mark these checks passed until observed.
- New SDKs may show deprecation warnings for the iOS 16-compatible AVFoundation export/composition APIs. They were chosen to match earlier homework's iOS 16 target.

## Files
- `VideoMood/ContentView.swift`: import, model, filters, export, and interface, with explanatory comments.
- `VideoMood/VideoMoodApp.swift`: app entry point.
- `VideoMood.xcodeproj`: project configuration.
- [WIKI_WEEK08.md](WIKI_WEEK08.md): English wiki draft.
- [PREVIOUS_ASSIGNMENTS.md](PREVIOUS_ASSIGNMENTS.md): Part 1 audit.
- [FINAL_PROJECT_RESEARCH.md](FINAL_PROJECT_RESEARCH.md): current research and next steps.
- [TEST_CHECKLIST.md](TEST_CHECKLIST.md): honest runtime test worksheet.
- [STUDY_NOTES.md](STUDY_NOTES.md): Swift/SwiftUI concepts to study and explain.


## References and assistance
- [Assignment](https://github.com/molab-itp/content-2026-itp/blob/main/weeks/08_video.md)
- [Apple: asynchronous filter composition](https://developer.apple.com/documentation/avfoundation/avvideocomposition/videocomposition(with:applyingcifilterswithhandler:completionhandler:))
- [Apple: Photos picker](https://developer.apple.com/videos/play/wwdc2022/10023/)
- [Apple: Core Image processing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html)

Prepared with AI assistance. 
