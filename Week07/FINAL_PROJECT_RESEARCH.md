# Final Project Research — Pocket Color Walk

## Idea

A visual journal of colors found during daily walks. Choose or capture a photo, collect a small color palette, and optionally attach a place and a short note.

Why a phone? It is available during a walk and combines a camera, photo library, location, and touch input. These capabilities make collecting a moment in its real setting practical.

## Starting resources

### 1. What's new in the Photos picker — WWDC22

https://developer.apple.com/videos/play/wwdc2022/10023/

Research note: the system picker lets the user select specific photos without granting full photo-library access. A selection is a placeholder; the app must load its data. Loading can take time or fail, so the interface should show progress and errors.

Connection to Week07: choose a photo, load its data, and show a preview before sharing an edited result.

Next: watch the session and write down one API or design detail in my own words.

### 2. AVCam: Building a camera app — Apple sample code

https://developer.apple.com/documentation/avfoundation/avcam-building-a-camera-app

Research direction: explore this sample as a starting point for adding camera capture. Check the downloaded sample's Xcode, iOS, and device requirements before trying it.

Next: download and run the sample on a supported device. Record what works and what needs adaptation. This sample has not been downloaded or tested as part of Week07.

## Possible scope

- First prototype: choose a photo, manually select a representative color, and add a note.
- Next: save entries locally and display a journal.
- Stretch goals: automatic palette extraction, camera capture, and optional location.

## Questions to investigate

- What makes a palette feel representative of a photo?
- Is a manually chosen color more personal than an automatic palette?
- Does location add value, or should it stay optional?

These are research starting points, not a claim that the videos have been watched or the sample has been tested.
