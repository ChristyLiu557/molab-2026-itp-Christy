# Week08 — Video Mood

**Draft: repository upload and device tests are pending. Update these statements with actual results before submission.**

## Project
Video Mood explores how color treatment changes the feeling of an everyday video. The proposed interaction is to choose a 1–60 second clip, select Original, Sunshine, or Dreamy B&W, adjust strength, generate the effect, and share the processed MP4. Mood captions connect the visual change to a personal memory.

It extends my Photo Mood photo work into time-based media. Unlike a live camera app, this prototype works with a chosen video, letting me focus on processing and export.

Project link **after upload**: [Week08 — Video Mood](https://github.com/ChristyLiu557/molab-2026-itp-Christy/tree/main/Week08).

## Progress
- Reviewed the existing Week01–07 folder structure. Each earlier week already has a folder, so no duplicate placeholders were needed.
- Prepared a SwiftUI video app with AI assistance, including video import, three looks, an effect-strength slider, processed playback, and MP4 sharing.
- Added loading/error states and export cancellation.
- Prepared a test checklist and Swift/SwiftUI study notes.
- The Xcode project configuration passed a file-format check; the app has not yet been compiled or tested on a device.

## Problems
- Full Xcode is unavailable in the environment used to prepare these files, so actual build and runtime behavior remain unverified.
- The local command-line Swift toolchain also reported duplicate module definitions during a syntax-only check.
- Video processing is more demanding than photo processing. Large clips, HDR footage, portrait orientation, audio, and export failure need testing.
- Earlier Week06/07 runtime tests are still documented as pending.
- Repository upload and wiki publication are separate unfinished steps.

## Plans
- Run the app in Xcode with a short SDR video and record the actual results.
- Compare exported Original, Sunshine, and Dreamy B&W clips outside the app.
- Test canceling selection, export cancellation, portrait video, audio, and changing effects.
- Work through the study notes, especially asynchronous file loading and the difference between interface state and exported media.
- Revisit earlier photo import and local-storage tests, then update the earlier weekly notes.
- Upload Week08 and add its link to the course wiki.

## Questions
- How can I display reliable export progress instead of an indeterminate spinner?
- How should I manage the memory and color space of HDR or 4K input?
- How can I make preview and exported colors match across devices?
- Is video valuable for my final color journal, or does a photo and a chosen color communicate the idea more clearly?

## Final project research to date
My Week07 research proposed **Pocket Color Walk**, a personal journal of colors noticed on daily walks. Video Mood explores the relationship between colors, motion, and remembered atmosphere.

For the final project's first version, I plan to keep photo selection, one manually chosen color, a short note, and local storage. Video adds file-size, playback, and persistence work, so it remains an optional future direction. Week06 provides a JSON-storage starting point and Week07 provides photo-import code, but successful integration is not yet demonstrated.

Research sources: Apple's Photos picker material and AVFoundation/Core Image documentation, alongside the course's video examples. I have not claimed to have watched all videos or run the samples. Next, I will test media import and ask a classmate whether motion adds enough value to justify the extra complexity.

## Actual test record
- Device / iOS / Xcode: pending
- Import / cancellation: pending
- Filter differences and strength: pending
- Exported MP4 / orientation / audio: pending
- Screenshots or demo: pending
- My changes and concepts I can explain: to be recorded after review

Process note: AI assisted with code and documentation preparation. But the ideation is created by myself. 
