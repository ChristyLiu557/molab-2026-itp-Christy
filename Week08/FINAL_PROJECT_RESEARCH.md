# Final Project Research — Pocket Color Walk

## Existing direction
[Week07 research](https://github.com/ChristyLiu557/molab-2026-itp-Christy/blob/main/Week07/FINAL_PROJECT_RESEARCH.md) proposes collecting a photo, colors, an optional place, and a note from daily walks.

## Week08 exploration
Video Mood asks whether a color treatment can change how a short everyday moment feels. Its source connects video import, per-frame image filtering, and video export. Runtime results are pending; no user research outcome is being asserted.

## Scope decision
Keep the final minimum version small: choose a photo, manually pick one color, add a note, and save a local entry. This builds on Week03 color interaction, Week06 JSON storage, and Week07 photo import.

Video entries are optional future work. They would require storing larger files, managing thumbnails and playback, and testing export and audio. Automatic palette extraction, GPS, and live camera capture are also outside the initial scope.

## Research resources
- [Apple Photos picker — WWDC22](https://developer.apple.com/videos/play/wwdc2022/10023/): starting material for selected-media loading. Watch and record one observation in my own words.
- [Apple video filter composition](https://developer.apple.com/documentation/avfoundation/avvideocomposition/videocomposition(with:applyingcifilterswithhandler:completionhandler:)): reference for applying Core Image work per frame. The API is used in this prototype; runtime verification is pending.
- [Class CameraRecorder](https://github.com/molab-itp/08-CameraRecorder): future comparison with live-camera processing; sample not run as part of this delivery.

## Next experiment
Use a 5–10 second walking clip. Generate warm and monochrome versions, then ask a classmate which one communicates the memory best and whether a still image would be sufficient. Record their response instead of inventing feedback.

- Experiment date: pending
- Export observations: pending
- Classmate feedback: pending
- Decision after feedback: pending

