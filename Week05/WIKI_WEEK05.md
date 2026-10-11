# Week 05 — Focus Bloom: Saving a Preference

> Draft: replace the project link and update the testing / fundamentals / office-hours status before posting.

## Progress
I continued working on my two-page Focus Bloom navigation app. In Week 04, I ran the app in the iPhone simulator and checked its navigation and timer controls. For Week 05, I added `@AppStorage` to save the selected focus duration between app launches.

The home page still offers 1-, 5-, 10-, and 25-minute sessions. The timer page still supports starting, pausing, resuming, and resetting a session. Only the duration preference is saved; an unfinished countdown is not restored after the app is closed.

## Problems / challenges
The main concept to understand is the difference between temporary view state and persistent preferences. The original `@State` value was initialized to 5 minutes when the app launched. `@AppStorage("focusDurationMinutes")` can load the saved selection instead.

**Week05 test status:** pending. [After testing, describe whether the selected duration survived stopping and relaunching the app. Record any errors here.]

## Plans
- Test persistence by selecting 10 minutes, stopping the app, and launching it again.
- Repeat with 25 minutes and verify that the timer page receives the correct duration.
- Complete the assigned Swift Language Fundamentals material.
- Check that my personal wiki has a summary for every week so far.
- Use office hours and/or coding lab to discuss any remaining questions.

## Questions
- How is `@AppStorage` different from `@State`?
- What happens when the app has no stored value for a key?
- How could I restore an unfinished countdown rather than only saving its selected duration?

## Fundamentals and support
- Swift Language Fundamentals: [add actual progress / completion status]
- Office hours / coding lab: [add actual attendance and discussion, or mark planned]

## Project
[Week05 — Focus Bloom](REPLACE_WITH_YOUR_WEEK05_GITHUB_FOLDER_URL)

## Screenshots
[Add the home page showing the saved duration and the timer page.]

## Process note
I used ChatGPT to help prepare the AppStorage modification and documentation. [Add your own changes, observations, and explanation of the code.]
