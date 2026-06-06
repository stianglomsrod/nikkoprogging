# PLAN: Companion Events Implementation

## Purpose

This document breaks the Companion Events epic into small implementation chunks that can be delivered incrementally while preserving current prototype behavior and calm product tone.

## Current State to Preserve

- Dark, low-stimuli visual style.
- Centered `.....` header placeholder until named.
- Top dialogue box, centered companion figure, bottom action area.
- Mood order: `Energisk`, `Ok`, `Tung`.
- Result action: `Fortsett`.
- Figure tap in result state continues flow.
- Settings remains behind gear icon and keeps circle-first model.
- In-memory scheduler/adaptive logic and energisk chain behavior remain unchanged.
- Existing idle/happy/sleep animation mapping remains unchanged.

## Event Rules (Authoritative for Implementation)

- Completed task means answer `Ja`.
- `Nei`, skipped, or not completed does not count.
- Energisk chain tasks count individually when answered `Ja`.
- Event thresholds:
  1. 3 completed -> companion name
  2. 6 completed -> user name
  3. 9 completed -> sleep sound
  4. 12 completed -> background music
  5. 15 completed -> symbol
  6. 18 completed -> background color
- Automatic trigger for each event happens at most once.

## Delivery Strategy

- Prioritize the smallest meaningful slice first:
  - companion name event at 3 completed tasks.
- Keep event rules separate from UI logic.
- Keep first implementation in-memory.
- Defer audio features to later phases.

## Suggested File and Module Direction

This plan does not implement code, but future implementation should likely keep this split:

- Core event model and definitions in `lib/core/events/`
- Event progression controller/helper in `lib/core/events/`
- Small event views under `lib/features/home/widgets/`
- Home screen remains coordinator, not event-logic monolith
- Tests under `test/core/events/` and widget coverage in `test/widget_test.dart`

---

## Chunk 1: In-memory completion and unlock state foundation

### Goal

Introduce an in-memory companion-event progression foundation that tracks completed-task count and computes pending unlocks without showing event UI yet (or with UI wiring only prepared).

### Files likely to change

- `lib/features/home/home_page.dart`
- `lib/core/models/attempt_entry.dart` (only if metadata is needed)

### New files likely to be created

- `lib/core/events/companion_event.dart`
- `lib/core/events/companion_event_definitions.dart`
- `lib/core/events/companion_event_controller.dart`
- `test/core/events/companion_event_controller_test.dart`

### Data/state needed

- In-memory completed task counter (`Ja` only)
- Event definitions (id + threshold + type)
- Event state flags:
  - unlocked/triggered
  - seen/consumed
  - skipped (for prompt-level handling)
- Optional pending event queue (single pending item first)

### UI behavior

- No visible event modal required yet.
- Normal task flow remains unchanged.
- Internal state can expose `pendingEvent` for next chunk.

### Tests to add/update

- `Ja` increments completed count.
- `Nei` does not increment completed count.
- Energisk follow-up task with `Ja` increments count individually.
- Event does not trigger before threshold.
- Event becomes pending exactly at threshold.
- Automatic trigger state is one-time only.

### Documentation updates

- `PROJECT_DNA.md` (only if a structural decision needs recording)
- `TECH_DEBT.md` (if interim shortcuts are introduced)

### Acceptance criteria

- Completed task counter is accurate by rules above.
- Pending event state can be queried from controller.
- Existing flow and tests for scheduler/adaptive/energisk remain green.

### Risks/open questions

- Whether to support one pending event at a time vs queue from day one.
- Whether event trigger check runs immediately on submit or only on transition to result/continue.

---

## Chunk 2: Companion name event UI (first user-visible slice)

### Goal

Show the companion name event after 3 completed tasks in a calm, non-blocking way and apply name to header if provided.

### Files likely to change

- `lib/features/home/home_page.dart`
- `lib/features/home/widgets/home_layout_shell.dart` (only if layout slot is needed)
- `lib/features/home/settings_page.dart` (if minimal state handoff is needed)

### New files likely to be created

- `lib/features/home/widgets/companion_name_event_view.dart`
- `test/features/home/widgets/companion_name_event_view_test.dart` (optional)

### Data/state needed

- Pending event state from controller
- Companion display name state (in-memory)
- One-time auto-trigger consumed flag

### UI behavior

- Event appears after normal result interaction timing (not during active task prompt).
- Prompt text: `Vil du gi meg et navn?`
- Input: free text field + skip action.
- Skip keeps header `.....`.
- Entered name replaces `.....` in header.
- Tone remains gentle and optional.

### Tests to add/update

- Companion name event appears after exactly 3 `Ja` completions.
- Companion name event does not appear before 3 completions.
- Skip path keeps `.....`.
- Name entry updates header text.
- Event auto-trigger does not repeat after first handling.

### Documentation updates

- `PROJECT_DNA.md` brief status note once feature exists.

### Acceptance criteria

- First companion event works end-to-end in-memory.
- No disruption to existing mood/task/result flow.
- Result figure tap-continue behavior remains intact.

### Risks/open questions

- Name validation policy (length/trim/empty input).
- If user closes event without explicit skip/save, expected fallback behavior.

---

## Chunk 3: Settings support for companion name after unlock

### Goal

Allow setting/changing companion name in Settings after the companion-name event has occurred (including users who skipped in the event itself).

### Files likely to change

- `lib/features/home/settings_page.dart`
- `lib/features/home/home_page.dart`
- Existing settings widgets under `lib/features/home/widgets/`

### New files likely to be created

- `lib/features/home/widgets/companion_identity_settings_panel.dart` (if extracted)

### Data/state needed

- Companion name value
- `event_companion_name` handled/unlocked state
- Rule for when settings control becomes available

### UI behavior

- Keep circle-first settings model unchanged.
- Add companion-name editing in a calm, low-noise way (not dense redesign).
- If skipped earlier, user can set name here.

### Tests to add/update

- Name can be changed in Settings after event unlock.
- Name remains `.....` if still unset.
- Settings addition does not break focus-area controls.

### Documentation updates

- `PROJECT_DNA.md` concise note on settings capability.

### Acceptance criteria

- Companion name can be edited later from Settings after unlock.
- Existing settings behavior and visual structure are preserved.

### Risks/open questions

- Exact placement in settings to avoid clutter.
- Whether to allow clearing name back to `.....` explicitly.

---

## Chunk 4: User name event (6 completed tasks)

### Goal

Add second unlock event for user name with optional usage in gentle greeting copy.

### Files likely to change

- `lib/features/home/home_page.dart`
- `lib/core/content/companion_text_library.dart`
- `lib/features/home/settings_page.dart` (for later editing)

### New files likely to be created

- `lib/features/home/widgets/user_name_event_view.dart`

### Data/state needed

- User name value (optional)
- `event_user_name` one-time trigger + handled flags

### UI behavior

- Prompt: `Hva heter du?`
- Input + skip.
- If skipped, no personal name references.
- If provided, use sparingly in calm greeting variants.

### Tests to add/update

- Trigger occurs at 6 completed tasks, not before.
- Skip path avoids name insertion in dialogue.
- Optional name appears only in approved greeting contexts.

### Documentation updates

- `PROJECT_DNA.md` brief note only if behavior lands.

### Acceptance criteria

- Event triggers once and supports skip.
- No over-personalization or pressure language.

### Risks/open questions

- Which exact greeting locations may safely include user name.
- Frequency limits to avoid repetitive name usage.

---

## Chunk 5: Future identity events (symbol and background color)

### Goal

Prepare and later implement non-audio identity events:

- 15 completed -> symbol
- 18 completed -> background color

### Files likely to change

- `lib/core/events/companion_event_definitions.dart`
- `lib/features/home/home_page.dart`
- theme-related files under `lib/app/` or feature widgets
- `lib/features/home/settings_page.dart`

### New files likely to be created

- `lib/features/home/widgets/symbol_event_view.dart`
- `lib/features/home/widgets/background_color_event_view.dart`

### Data/state needed

- Selected symbol (or none)
- Selected background tone (or default)
- One-time trigger + handled flags for both events

### UI behavior

- Symbol shown around companion name when selected.
- One active symbol at a time.
- One active background tone at a time.
- Reset-to-default option available.

### Tests to add/update

- 15 and 18 threshold triggers fire correctly and only once.
- Symbol application/removal behavior is correct.
- Background tone applies without breaking calm theme readability.

### Documentation updates

- `PROJECT_DNA.md` and `TECH_DEBT.md` depending on implementation depth.

### Acceptance criteria

- Both events follow calm optional UX and one-time trigger rules.
- Settings can modify unlocked choices later.

### Risks/open questions

- Accessibility contrast across all tone options.
- Symbol rendering consistency across platforms/fonts.

---

## Chunk 6: Future audio events (deferred)

### Goal

Document implementation path for deferred audio unlocks:

- 9 completed -> sleep sound
- 12 completed -> background music

### Current prototype status

- Audio playback/features remain deferred (no audio engine, no new packages).
- Deferred-audio unlocks are now handled centrally in event logic and auto-skipped
  when pending so they never block later non-audio identity events.
- Home flow now depends on controller-level deferred-audio consumption instead of
  duplicating event-id checks in UI coordination code.

### Files likely to change

- Implemented in current scope:
  - `lib/core/events/companion_event_definitions.dart`
  - `lib/core/events/companion_event_controller.dart`
  - `lib/features/home/home_page.dart`
  - `test/core/events/companion_event_controller_test.dart`
- Later for real audio playback:
  - audio service/controller + settings + event views.

### New files likely to be created

- Later, likely `lib/core/audio/` and related widgets (future).

### Data/state needed

- Sleep sound preference + enabled state
- Background music preference + enabled state
- Playback timing/lifecycle configuration

### UI behavior

- Unlock prompts remain calm and optional.
- `stille` must remain first-class no-audio mode.
- One active background sound at a time.

### Tests to add/update

- Event trigger thresholds 9 and 12.
- Preference persistence behavior once storage exists.
- Deferred-audio events are marked skipped when consumed.
- Deferred-audio consumption does not block progression to later events (for example symbol at 15).
- Playback lifecycle and stop behavior (future integration tests).

### Documentation updates

- `TECH_DEBT.md` and epic docs as audio scope becomes active.

### Acceptance criteria

- Audio remains explicitly deferred until asset/package/lifecycle decisions are approved.

### Risks/open questions

- Package choice and platform constraints.
- Foreground/background playback behavior.
- Asset size and download strategy.

---

## Cross-Cutting Testing Plan

- Unit tests for event-controller progression and threshold logic.
- Widget tests for event prompts and skip/save outcomes.
- Regression tests for core flow:
  - scheduler simulation
  - mood selection order
  - energisk two-task chain
  - result continue behavior
  - companion animation state behavior
- Non-punitive copy checks for new event text.

## Future Persistence Preparation (No implementation in this plan)

When persistence is approved, likely store:

- completed task count
- event unlock and seen/triggered flags
- skipped flags
- companion name and user name
- selected symbol/background color
- sound/music preferences
- event timestamps
- whether each task attempt contributed to threshold progress

Keep local-first strategy and repository boundary for future migration to Drift + SQLite.

## Non-Goals for This Planning Pass

- No feature implementation.
- No dependency changes.
- No backend/database/auth/notifications/TTS/audio package integration.
- No generated platform-file changes.
