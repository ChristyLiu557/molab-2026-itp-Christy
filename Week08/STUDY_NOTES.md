# Swift / SwiftUI study notes

These are study prompts, not a claim that the material has already been mastered.

1. **State vs model:** mood and strength belong to the editor view's State. MovieModel owns players, loading state, errors, and generated output. StateObject preserves the model while the view updates.
2. **Asynchronous import:** PhotosPicker returns a selection, not a permanent file. ImportedMovie copies the received file before the picker releases it.
3. **MainActor:** UI-visible model changes happen on the main actor. AVFoundation processes frames through its own asynchronous callbacks.
4. **Per-frame filtering:** every frame receives a new filter instance, avoiding shared mutable filter state. Strength controls sepia intensity or desaturation.
5. **Real media output:** styling a SwiftUI player would only change its appearance. Assigning a videoComposition to the export session produces changed pixels in the saved movie.
6. **Continuation:** a continuation connects a completion-handler API to async code. It must resume exactly once.
7. **Temporary vs persistent files:** imported and exported copies are disposable. Save through the share sheet to retain a movie. A future journal needs persistent storage and metadata.
8. **Honest testing:** a valid project file does not prove the app compiles or that audio/orientation exports correctly.

After running the app:
- Change the Sunshine caption and explain which view updates.
- Compare strength 0, 50%, and 100%.
- Trace the chosen file from picker to copy to asset to export.
- Explain why changing the effect hides an earlier result.
- Write one issue you encountered and the change you made in your wiki.

