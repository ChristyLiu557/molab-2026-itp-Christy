# First Draft — Pocket Color Walk
Christy Liu · Week09

## Concept
I propose an iPhone visual journal for noticing colors during everyday walks. Users choose a photo, manually select one representative color, add a short note and an optional typed place name, and save a journal entry. The intended audience is students and visual makers who want to collect small observations without the pressure of a social feed.

Example: I notice a yellow storefront, take a photo using the Camera app, import it into my journal, choose a yellow swatch, and write “a bright moment on my walk.”

## Connection to earlier work
This develops the idea already documented in my Week07 FINAL_PROJECT_RESEARCH.md. Week03 explores changing colors and SwiftUI interaction; Week04–06 Focus Bloom introduces navigation, preferences, and local JSON records; Week07 Photo Mood provides photo-import source. Week08 Video Mood source explores color effects over time, but its runtime issues are still unresolved. These are starting points, not a claim that every previous feature has passed testing.

## Minimum scope
- Journal list: photo, chosen color, date, and note excerpt.
- New entry: photo picker, manual color selection, note, optional typed place.
- Detail: review an entry and delete it.
- Local persistence: JSON metadata plus image files.

A phone is appropriate because it is available during a walk and supports photos and touch. The first version imports existing photos; it does not need GPS or direct camera capture.

## Alternate concept / possible extension
Color Walk Together could let classmates respond to a weekly color prompt and share text/color observations. Week09's Firestore exercise helps explore cloud persistence. It does not yet implement a shared journal. Shared data would need a clear audience, identity, access rules, and a plan for removing posts. I will only choose this extension after the local journal works and peer feedback supports it.

## Work plan
- Week09: draft proposal; configure and test the MakeItSo Firebase tutorial adaptation.
- Week10: refine scope with a classmate, sketch the three screens, and finalize the proposal.
- Week11: verify photo import and build the entry form.
- Week12: implement local save/load, journal list, detail, and deletion.
- Week13: user testing, accessibility/layout fixes, error handling; evaluate one optional feature.
- Week14: final testing, documentation, demo recording, and presentation.

## Risks and success criteria
Photo loading, image-file storage, and orientation need real device tests. Prioritize those over automatic palettes, video, GPS, or social features.
Success means a user can create three entries, relaunch, revisit them, and delete one without losing the others.

## Questions for feedback
Does selecting one color feel expressive enough? Is a place name helpful? Would sharing improve the experience, or make it less personal?

Peer feedback is pending; no partner or feedback result has been invented.

