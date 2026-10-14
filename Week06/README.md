# Week06 — Focus Bloom

A SwiftUI focus timer with saved session history.

## What's New
- Save a completed session with its duration and save time.
- View saved sessions on the History page.
- Records are stored locally in `focus-sessions.json` using `Codable`, `JSONEncoder`, and `JSONDecoder`.
- The selected duration still uses `@AppStorage`.

## Run and Test
1. Open `FocusBloom.xcodeproj` and run on an iPhone simulator.
2. Open the 10-second demo and start the timer.
3. When it finishes, tap **Save session**, then **View history**.
4. Stop and relaunch the app. Open History and check that the record remains.
5. Finish and save another session. Both records should appear, newest first.

Only completed sessions you explicitly save are recorded. An unfinished countdown is not restored. Records stay on this device; deleting the app removes its local data. Week06 is a separate app and starts with no history.

Week06 has not yet been compiled or run in Xcode by the assistant. Verify the steps above before submission.
