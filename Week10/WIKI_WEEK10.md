# Week10 — Final Project Proposal
## Pocket Color Walk
**Christy Liu · NYU ITP · Swift / SwiftUI**

Status: proposal and implementation plan. The final app is not implemented or tested yet. This document is ready to copy into my course wiki page; creating this repository file does not publish a wiki update.

## Project description
Pocket Color Walk is an iPhone visual journal for noticing colors during everyday walks. A user chooses a photo, manually selects one representative color, adds a short note and an optional place name, and saves the moment in a personal collection. The journal invites students and visual makers to pay attention to ordinary surroundings and revisit them through color.

For example, I could photograph a yellow storefront, choose a yellow swatch, write “a bright moment on my walk,” and later find the photo and note together in my journal. The selected color expresses the user's interpretation; the first version will not automatically extract colors from an image.

A phone makes this interaction practical because it is available during a walk and provides a photo library and touch interface. Users can take photos in the normal Camera app and import them afterward.

## Connection to my previous work
This proposal develops the idea already recorded in [Week07 final-project research](https://github.com/ChristyLiu557/molab-2026-itp-Christy/blob/main/Week07/FINAL_PROJECT_RESEARCH.md).

| Week | Repository evidence | Connection to the final project |
| --- | --- | --- |
| 01 | `week01/`: Swift playgrounds and text-art loops | Basic functions and iteration |
| 02 | `Week02/CatAndLollipop.playground` | Building visual forms from simple logic |
| 03 | `week03/`: Candy Jar with changing circle colors/sizes, animation, and navigation | Color interaction and simple visual feedback |
| 04 | `Week04/FocusBloom`: two-page focus timer | Navigation and state-driven interfaces |
| 05 | `Week05/FocusBloom`: saved duration using AppStorage | Remembering simple preferences |
| 06 | `Week06/FocusBloom`: session-history JSON storage | Saving and loading a collection locally |
| 07 | `Week07/PhotoMood`: photo import, effects, and JPEG sharing | Importing and displaying photos; image resizing |
| 08 | Video Mood project prepared and Week08 folder now visible in GitHub | Exploring mood through video; playback/export testing remains unconfirmed |
| 09 | MakeItSo adaptation: Color Walk Tasks, anonymous Firebase authentication and per-user Firestore records | Understanding cloud persistence, identity, and data access |

Evidence update (November 12, 2026): screenshots show the Week09 app running and a task saved in Firestore. I also confirmed that editing its title and marking it complete updated the cloud record. Relaunch and deletion tests have not yet been confirmed. Week08 and Week09 folders are now visible in the course repository. This does not establish that every earlier feature has passed testing. Week06 and Week07 documentation still identify runtime testing as pending. Week07 source includes resizing and orientation handling, but those behaviors still need device verification.

## Minimum viable app
1. **Journal:** browse saved entries as photo cards with a color swatch and date; show a helpful empty state.
2. **New entry:** select one photo, choose one color with a standard color control, and add a short note and optional typed place name. Cancel without saving or save once.
3. **Entry detail:** view the saved image, color, note, place, and date; delete an unwanted entry.
4. **Persistence:** entries remain after closing and reopening the app, with useful feedback if loading or saving fails.

The first version is local and single-user. Week09 demonstrated cloud task storage, but a photo journal also needs persistent image handling; keeping the first version local leaves time to test that properly. It requires no account, cloud service, GPS, video recording, or automatic palette extraction. Extra colors, photo effects, or sharing are stretch goals only after the core workflow works. Camera capture and automatic palettes can remain future work.

## Planned implementation
- Use SwiftUI for the three screens and navigation.
- Adapt the existing Photo Mood import flow, including loading, cancellation, and error states.
- Adapt the Week06 Codable/JSON approach for entry metadata. Store a unique ID, creation date, note, optional place name, image filename, and numeric RGB color values.
- Keep resized image files in persistent app storage and reference them from JSON; temporary export files are not permanent journal storage.
- Separate the entry model, storage helper, and views. Only confirm a save after both image and metadata writes succeed. Delete the associated image when deleting an entry.
- Confirm the deployment target and available iPhone/Xcode setup in Week11 before choosing additional APIs.

## Week-by-week work plan
The course repository lists final presentations in Week14. These are course-week milestones rather than assumed calendar dates.

| Week | Work | Deliverable / completion check |
| --- | --- | --- |
| 10 | Write the proposal, define the minimum scope, create this folder, and exchange proposal feedback with a classmate. | Proposal and plan prepared; wiki posting and feedback still to complete. |
| 11 | Verify Week07 import on a device; sketch Journal, New Entry, and Detail; create the final Xcode project in this folder and implement the entry form. | Import a photo, choose a color, enter text, and preview an unsaved entry; record peer feedback and revise scope. |
| 12 | Add persistent image/JSON storage, journal cards, detail view, and deletion. | Create three different entries, relaunch the app, verify their contents, delete one, and verify deletion after another relaunch. |
| 13 | Test with at least one classmate, resolve confusing interactions and failures, improve layout and accessibility. | Record observed issues and fixes; check canceled import, large/portrait photos, empty journal, repeated save taps, and readable labels. Add at most one stretch feature if the core passes. |
| 14 | Freeze scope, fix remaining problems, prepare screenshots and a short backup demo recording, and update the wiki. | Present the complete create → save → relaunch → revisit flow, explain the code and design choices, and disclose remaining limitations. |

If photo import remains unreliable in Week11, prioritize fixing it and use bundled sample images only for an explicitly labeled prototype. Drop stretch features before reducing testing or documentation time.

## Progress
- Reviewed earlier coursework and developed the Pocket Color Walk idea from Week07 research.
- Created my own Firebase project and enabled anonymous authentication for Week09.
- Ran Color Walk Tasks and verified a new task in the Firestore console; title edits and completion updates were also confirmed during testing.
- Week08 and Week09 folders are now present in my GitHub course repository.
- Defined a small final-project scope that builds on the color, photo, and local-storage exercises.
- Prepared this Week10 proposal, milestones, and feedback worksheet.
- The final Pocket Color Walk app has not yet been implemented; Week09 tests apply only to the tutorial adaptation.

## Problems
- Photo import and export from the earlier work still need runtime verification.
- Saving image files together with metadata is a new integration step beyond saving timer records.
- Week08 runtime troubleshooting remains unresolved; video is outside the final minimum scope.
- Firebase task storage is working in Week09, but it does not yet provide photo-journal storage or cross-device accounts.
- A feedback partner and actual feedback have not yet been recorded.

## Plans
- Post the proposal and this folder link to the course wiki.
- Pair with a classmate to give and receive feedback, then record what changed.
- Test the existing photo flow and build the three-screen prototype in Week11.
- Keep code and future progress notes in this Week10 folder, linking later weekly wiki updates to it.

## Questions
- Does choosing one color make the journal meaningful enough, or would three colors improve the experience?
- Is typed place information useful enough to keep in the first version?
- Is this scope appropriate for Week14, including time for testing?
- What is the clearest way to recover when an image exists but its metadata fails to save?

## Peer feedback — pending
Pair with one classmate, show the proposed three-screen flow, and review their proposal in return. Ask whether they understand what to do first, what they would want to revisit later, and which feature could be removed.

- Partner / date: to be recorded after the discussion.
- Feedback received: pending.
- Feedback I gave on their proposal: pending.
- Change I will make and why: pending.
- Suggestion I will defer and why: pending.

## Submission checklist
- [x] Prepare a project description and week-by-week plan.
- [x] Prepare Progress / Problems / Plans / Questions.
- [x] Prepare the local Week10 folder and proposal documents.
- [ ] Upload this Week10 folder to the existing course repository. Remote publication has not been confirmed.
- [ ] Copy the proposal into my personal course wiki page.
- [ ] Add the project link under Week10 on the course wiki home page.
- [ ] Give and receive peer feedback and replace the pending notes with actual results.

**Intended project folder (available after upload):** [Week10 — Pocket Color Walk](https://github.com/ChristyLiu557/molab-2026-itp-Christy/tree/main/Week10)

**Wiki home-page entry to paste:**

Christy — [Week10: Pocket Color Walk — Final Project Proposal](https://github.com/ChristyLiu557/molab-2026-itp-Christy/tree/main/Week10)

The existing repository is public, so no new private repository or collaborator invitations are needed for this submission route.

## Sources and process
- [Week10 assignment](https://github.com/molab-itp/content-2026-itp/blob/main/weeks/10_multi.md)
- [Week14 presentation milestone](https://github.com/molab-itp/content-2026-itp/blob/main/weeks/14_presentation.md)
- [Week06 local-storage work](https://github.com/ChristyLiu557/molab-2026-itp-Christy/blob/main/Week06/README.md)
- [Week07 photo source](https://github.com/ChristyLiu557/molab-2026-itp-Christy/blob/main/Week07/PhotoMood/ContentView.swift)
- [Week07 project research](https://github.com/ChristyLiu557/molab-2026-itp-Christy/blob/main/Week07/FINAL_PROJECT_RESEARCH.md)

Prepared with AI assistance using the repository's existing work. Project direction follows the Week07 research; the one-color minimum scope is a proposed simplification. The Week09 test results above are based on screenshots and my reported results. Final-app tests, peer feedback, and wiki publication remain unfinished. The local-first, one-color design is a proposed scope choice to review with a classmate.

