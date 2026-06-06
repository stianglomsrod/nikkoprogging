# PROJECT_DNA

## App Concept

`companion_app` is a calm, low-stress companion/reminder app for iOS and Android.
It should support the user with small concrete tasks based on current mood/sinnsstemning, selected focus areas, and previous activity, while reducing pressure and decision overload.

Core product feeling:

- One task at a time.
- Gentle and supportive tone.
- No punishment loops.
- Attempts are meaningful, not only completions.

## Current Phase

Early prototype / flow-validation phase.

Current implementation status:

- In-memory prototype UI and logic are implemented for setup, scheduler simulation, mood check, task selection, and Ja/Nei result flow.
- Basic structured modules are present for models, scheduler logic, adaptive task selection, and seed data.
- Data is intentionally local/hardcoded for first prototype iterations.
- Scheduler behavior is currently simulated manually in prototype UI via "Simuler neste prompt".
- Main user view is intentionally calm and minimal, with settings moved behind a gear icon.
- Companion placeholder name is currently shown as `.....` in the app bar.
- A small in-app companion figure is visible before any future naming event.
- The visible `.....` placeholder is centered in the top app bar.
- Companion figure placement is below intro/dialogue text and above user inputs in the main flow.
- Settings now show focus areas as circles first; controls appear for the selected area only.
- A local Dart content/task library now stores prototype messages and task text adapted from the uploaded `texts.py` source.
- App-wide visual direction is dark, calm, and low-stimuli, tuned toward deep navy/blue-black surfaces and muted blue accents.
- Dialogue field is intentionally top-oriented and shown in a subtle bordered message-like area.
- Companion dialogue text belongs in the top dialogue field (not below the figure).
- Dialogue text should stay simple/clean, avoid awkward forced line breaks, and avoid focus-area labels in the dialogue field.
- In task state, the top dialogue should primarily contain the task text itself (not combined with generic lead-ins and action questions).
- Energisk chain rule is now part of prototype behavior: two consecutive `Energisk` mood selections trigger a temporary two-task chain.
- In an active energisk chain, the second task appears directly after the first task result (no additional mood prompt between those two tasks).
- Energisk chain is exactly two tasks and resets after the second task result.
- Completion (`Ja`/`Nei`) on the first task does not decide whether the second chain task appears.
- Energisk chain transitions are extracted into a dedicated helper (`lib/core/flow/energisk_chain_controller.dart`) so `home_page.dart` can stay focused on UI coordination.
- Companion figure should sit visually centered in the flexible middle area.
- Companion figure now uses a real image asset instead of the earlier placeholder-only shape widget.
- Main screen should behave as stable top/middle/bottom zones so the figure keeps a consistent visual center across idle/mood/task/result states.
- Top dialogue content should not push the figure downward.
- Primary input/action buttons in active flow states are anchored near the bottom action area.
- Action questions such as `Fikk du gjort oppgaven?` belong in the bottom action area directly above the relevant buttons.
- Bottom action content should not push the figure upward.
- Bottom actions do not require a large visible card/container.
- Button labels should use readable larger text with leading capitals (`Tung`, `Ok`, `Energisk`, `Ja`, `Nei`).
- Norwegian user-facing text must render correctly in UTF-8, including `å`, `ø`, and `æ`.
- Home UI is split into smaller widgets (layout shell, dialogue box, and state-specific bottom action views), while `home_page.dart` remains the state/flow coordinator.

## Current Stack

- Flutter
- Dart
- VS Code
- Android emulator (current dev target)

## Product Principles

- Keep the app emotionally safe and supportive.
- Avoid guilt mechanics, fear of failure, or pressure-based engagement.
- Guide the user with clear next steps instead of large choice lists.
- Treat attempts as positive progress.
- Build rhythm and consistency, not performance pressure.

## Clarified Product Model

### Initial setup and settings

- On first use, the user selects which focus/task areas they want help with.
- Example focus areas: household tasks, study/learning, exercise, reminders.
- Focus areas can be changed later in Settings.

### Per-focus-area configuration

- Each focus area has its own active time window.
- Each focus area has its own `Modus`.
- There is no single global day tempo.

`Modus` controls how many prompts/tasks that focus area can generate inside its own active time window:

- `avslappet` = 1 task/prompt
- `stabil` = 2 tasks/prompts
- `sporty` = 3 tasks/prompts

Multiple focus areas may be active at the same time and their windows may overlap.

Example:

- Household: 16:00-21:00, `stabil`
- Study: 18:00-20:00, `avslappet`
- Exercise: 15:00-19:00, `sporty`

The scheduler must eventually respect each focus area independently.

### Ongoing UX flow (scheduler-oriented)

- The product model is scheduler-oriented, not round/loop-oriented.
- The app should not use a user-driven new-round lifecycle.

Target flow:

1. A prompt appears at a random time inside a configured active time window.
2. The user opens the app.
3. The app asks for current mood/sinnsstemning.
4. Current mood options: `negativ`, `ok`, `energisk`.
5. The app presents one adaptively selected task.
6. The app asks: "Fikk du gjort oppgaven?"
7. The user answers `Ja` or `Nei`.
8. The app updates history/success rate and future task selection.

Important distinctions:

- Mood/sinnsstemning is entered before each task.
- Exception: in an active energisk chain, task number two skips the mood prompt and goes directly to task presentation.
- Mood is not a day-start setting.
- `Modus` is not mood.
- `Modus` is a per-focus-area quota/frequency setting.
- User-facing mood labels in UI are `tung`, `ok`, `energisk` (internal model may still use `negativ`).

### Energisk two-task chain rule (prototype)

- Chain trigger: the user selects `Energisk` two mood prompts in a row.
- Chain length: exactly two tasks total in that trigger cycle.
- Task 1: shown after the second consecutive `Energisk` mood input.
- Task 2: shown directly after Task 1 receives `Ja` or `Nei`, without a new mood question.
- Chain completion: after Task 2 receives `Ja` or `Nei`, chain state resets.
- Re-triggering: user must later provide two new consecutive `Energisk` mood inputs to trigger a new two-task chain.
- Non-punitive rule remains unchanged: `Nei` must not trigger punitive language or behavior.

### Task selection behavior

- Failed/skipped tasks must influence future selection.
- The app should avoid immediate repetition of recently failed/skipped tasks.
- Success rate should regulate suggested difficulty over time.
- Current mood should regulate tone and momentary task difficulty.
- Failure must not trigger punitive behavior.

## Architecture Principles

- Keep architecture small and understandable while the product loop is being validated.
- Separate adaptive/recommendation logic from UI widgets.
- Prefer explicit, readable code over premature abstraction.
- Postpone infrastructure complexity until the interaction model is validated.

## Current Decisions (Intentional)

- Use hardcoded/local seed data in the first prototype.
- Avoid backend and database setup during early flow validation.
- No notifications yet; scheduler behavior may be simulated in-app during prototype.
- Keep dependencies minimal and stay close to default Flutter tooling.
- Hide raw internal metrics (success rate, attempt counters, prompt counters) from normal user-facing UI.
- Keep the visual theme soft, muted, and low-stimuli.

## Planned Later (Not Now)

- Scheduler component and real notification delivery
- Persistence/history layer
- Database/backend decision (local DB, backend, or both)
- Riverpod (only if explicitly requested later)
- `flutter_local_notifications`
- `flutter_tts`
- Possible backend/sync later

These are deferred by design and should only be introduced when explicitly requested.

## Persistent Agent Rules

- Preserve the calm, low-stress companion app principles.
- Never introduce punitive language, "game over", guilt, harsh streaks, or productivity-pressure patterns.
- Keep the flow simple: one task at a time, few choices, clear next step.
- Attempts matter, not only completed tasks.
- Keep adaptive logic separate from UI code.
- Do not add backend, database, authentication, notifications, or TTS unless explicitly requested.
- Prefer small, understandable architecture over premature abstraction.
- Follow Flutter/mobile best practice by extracting distinct UI/flow/product-rule behaviors into small, focused widgets/helpers/controllers instead of allowing monolithic files to grow.
- When product logic becomes a distinct rule (for example chain behaviors), place it in an appropriately named core/helper module and add tests when practical.
- Document file-structure changes in `FILE_TREE.md`.
- Document project decisions and onboarding context in `PROJECT_DNA.md`.
- Document shortcuts, compromises, and deferred work in `TECH_DEBT.md`.
- Surface blockers and uncertainties in your report.
- Do not invent hidden requirements.
- When creating, changing, moving, deleting, or reading files, always report the full relative path from the project root. Do not report only filenames. Examples: `lib/features/home/home_page.dart`, `lib/core/content/companion_text_library.dart`, `test/core/scheduler/scheduler_engine_test.dart`.

## Data and Infrastructure Direction

Current state:

- No database yet.
- No backend yet.
- No auth yet.
- Hardcoded/local seed data is intentional technical debt for prototype speed.

Later decision point:

- The database/backend direction will be decided after core flow validation.
- Any persistence/backend adoption should happen behind a repository boundary.
