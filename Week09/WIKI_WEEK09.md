# Week09 — MakeItSo / Color Walk Tasks
Draft: update the pending items after configuring and running the app.

## Part 1 — Final project proposal
Pocket Color Walk is a visual journal of everyday colors: choose a photo, select one color, write a note, and save it locally. It builds on my earlier color interaction, Focus Bloom storage, and Photo Mood source. An optional alternative is a shared weekly-color prompt, but I will prioritize a working local journal.
The full proposal and Week09–14 plan are in FINAL_PROJECT_PROPOSAL.md in my Week09 folder.

## Part 2 — Option 1
I selected the MakeItSo Firebase tutorial from the class repository. My adaptation, Color Walk Tasks, keeps its reminder creation, editing, completion, deletion, and Firestore listener pattern, with a creative-walk theme.
It uses anonymous authentication and per-user reminder collections. It is a cloud tutorial exercise, not a shared MoLobby implementation.

## Progress
- Reviewed the class MakeItSo source and verified Firebase 10.29.0 in Package.resolved.
- Prepared a Week09 copy with the same exact Firebase version and original attribution.
- Added anonymous sign-in, per-user data paths, visible errors, and title validation.
- Prepared a first project proposal, setup guide, access rules, and test checklist with AI assistance.

## Problems
- My own Firebase project and downloaded iOS configuration are not yet supplied.
- Package resolution, full compilation, real cloud writes, and runtime behavior are still unverified.
- Anonymous identities do not provide cross-device account access.
- Earlier Week08 white-screen troubleshooting is still pending.

## Plans
- Create my Firebase project, register the iOS app, enable anonymous sign-in, and publish the supplied Firestore rules.
- Build in Xcode and test create/edit/complete/delete against the Firestore console.
- Record screenshots of both the App and corresponding cloud data.
- Work through MakeItSo tutorial chapters 1–4, skipping the emulator chapter as instructed.
- Upload Week09 and update this wiki with actual results.

## Questions
- How does a Firestore listener differ from loading a local JSON file?
- How can I distinguish cached data from a confirmed cloud write?
- How would I link an anonymous user to a permanent account later?
- Should my final journal remain private/local or support a shared color prompt?

## Test evidence
Firebase project ID: pending
Xcode / device / iOS: pending
Build result: pending
Create / edit / complete / delete verified in cloud console: pending
Listener updates: pending
Second-user isolation: pending
Screenshots: pending

Project link after upload: [Week09 — Color Walk Tasks](https://github.com/ChristyLiu557/molab-2026-itp-Christy/tree/main/Week09)
Source: [class MakeItSo](https://github.com/molab-itp/09-MakeItSo)
Wiki publication has not been performed by the assistant.

