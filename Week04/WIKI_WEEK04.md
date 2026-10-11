# Week 04 — Focus Bloom

> Draft: review before posting. Replace the project link, add screenshots, and record your actual Xcode results. Do not present pending tests as completed.

## Concept
Focus Bloom is a small SwiftUI app that turns a focus session into a visual countdown. I wanted to make a calm interface with a green color palette and a leaf motif.

## Pages and interaction
1. **Home:** choose a 1-, 5-, 10-, or 25-minute session, or open a 10-second demo.
2. **Focus session:** start, pause, resume, and reset the countdown. A circular progress indicator fills as time passes, and a checkmark appears when the session ends.

## Time-based behavior
The app uses `Timer.publish` to refresh the screen and a stored end date to calculate the remaining time. Using the end date helps the countdown catch up when the app returns from the background. It does not send a background alarm.

## Progress / weekly summary
This week's project is a two-page focus timer. The source includes navigation, duration selection, timer controls, and a completion state. The next step is to run the project in Xcode, check the interactions, and document the results below.

## Concepts to explain
- `@State` stores the selected duration.
- `NavigationLink` opens the timer page.
- `@StateObject` keeps the timer model alive while that page is open.
- `@Published` updates the UI when the remaining time or timer status changes.
- A scheduled refresh is different from the actual elapsed time.

## Questions
- How could I add a completion sound and a local notification?
- How could I save a session so it survives closing the app?
- How should I decide which state belongs to a view and which belongs in a separate model?

## Testing and screenshots
**Status:** pending Xcode / iPhone testing.

[Add actual test results and one screenshot of each page here.]

## Project
[Week04 — Focus Bloom](REPLACE_WITH_YOUR_WEEK04_GITHUB_FOLDER_URL)

## Process note
I used ChatGPT to help generate the initial code and documentation. [Add the changes you made and the parts you tested or learned to explain.]
