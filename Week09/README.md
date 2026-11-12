# Week09 — Color Walk Tasks
**Christy Liu · Option 1: MakeItSo Firebase tutorial adaptation**

## Status
Project source and documentation are prepared. Firebase project creation, the student's configuration file, dependency resolution, a full iOS build, cloud tests, GitHub upload, and wiki posting are still pending. This is not a report of a completed Firebase deployment.

## What the app does
A small cloud-backed task list for creative walks: add “Find a warm color,” edit it, mark it completed, and delete it. It adapts the class MakeItSo tutorial rather than replacing it with an unrelated sample.

The original reminder model, SwiftUI editing/list flow, Combine view model, and Firestore snapshot approach are retained. Changes include a walking theme, anonymous authentication before loading data, per-user Firestore paths, visible error messages, and title validation. Anonymous users have separate lists; this is not a shared lobby or a cross-device account system.

## Open
Read [SETUP_ZH.md](SETUP_ZH.md), configure your own Firebase project, and place your own GoogleService-Info.plist inside MakeItSo/.
Open **MakeItSo.xcodeproj**, select the MakeItSo scheme, let packages resolve, and run on an iPhone simulator or device.

The existing class build phase intentionally stops a build when the configuration file is absent. No fake configuration file or teacher-owned configuration is included.

## Files
- [FINAL_PROJECT_PROPOSAL.md](FINAL_PROJECT_PROPOSAL.md): Part 1, first draft.
- [WIKI_WEEK09.md](WIKI_WEEK09.md): Progress / Problems / Plans / Questions.
- [SETUP_ZH.md](SETUP_ZH.md): Firebase setup and submission steps.
- [TEST_CHECKLIST.md](TEST_CHECKLIST.md): evidence to collect.
- firestore.rules: access rules for the matching per-user collection.
- UPSTREAM_README.md and LICENSE: original notes and Apache 2.0 license.

## Source and attribution
Adapted with AI assistance from [molab-itp/09-MakeItSo](https://github.com/molab-itp/09-MakeItSo), tree snapshot **e72ef4637b40fcf489e23a51d6fe3fcc26f4f175**, reviewed November 12, 2026.
Original tutorial and source by Peter Friese: [MakeItSo](https://peterfriese.github.io/MakeItSo/tutorials/makeitso/).
Original source license headers are preserved. Modified files identify or document the Week09 changes here.
The class README mentions a historical gRPC build issue; it is not a newly observed result on this machine.

* AI was used in this task  

