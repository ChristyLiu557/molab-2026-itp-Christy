# Week07 — Photo Mood

A SwiftUI app for choosing, editing, and sharing a photo.

- Choose a photo with PhotosPicker.
- Try Original, Warm, or B&W.
- Share the edited JPEG or save it to Files.

My twist: three moods with short captions. Warm uses a light sepia effect.
The original photo is unchanged. Exported images have a maximum long edge of 2048 pixels. Edits are temporary unless exported; this app does not keep a saved gallery.

## Run

1. Open `PhotoMood.xcodeproj` in Xcode.
2. Choose the PhotoMood scheme and an iPhone simulator running iOS 16 or later.
3. Press Command + R. For a real iPhone, select your signing team first.
4. Choose a photo, try all three moods, and share a JPEG to Files.

If the simulator has no photos, drag a JPEG into it and check the Photos app.

## Check before submitting

- Try a portrait photo and a landscape photo; check their orientation.
- Cancel the photo picker, then choose a photo again.
- Switch moods quickly; check that the final preview matches the selected mood.
- Open each exported JPEG in Files and check its effect.
- Tap Done and choose another photo.

Code and project references were inspected. This environment has no Xcode; build and device tests are still pending.

## Reference

[Apple: What's new in the Photos picker (WWDC22)](https://developer.apple.com/videos/play/wwdc2022/10023/)

This is an independently written app using PhotosPicker and Core Image. It has not been compared with a specific Week07 class demo.

## Submit

Put `Week07` beside your other weekly folders. In GitHub Desktop, commit with `Add Week07 Photo Mood` and push. Copy the actual Week07 folder URL into the class Week07 wiki. Update your personal wiki using `WIKI_WEEK07.md` after testing.

The instructor's midterm checklist is still needed. Final-project research notes are in `FINAL_PROJECT_RESEARCH.md`.
