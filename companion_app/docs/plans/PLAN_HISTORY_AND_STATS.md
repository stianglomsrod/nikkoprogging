# PLAN: History and Statistics Implementation

## Purpose

This document breaks the History and Statistics epic into small implementation chunks that can be delivered incrementally while preserving the current calm prototype behavior and product tone.

The goal is a supportive overview of activity over time, not a performance dashboard.

## Current State to Preserve

- Dark, low-stimuli visual style.
- Centered `.....` header placeholder unless companion name is unlocked/set.
- Top dialogue box, centered animated companion figure, bottom action area.
- Mood order: `Energisk`, `Ok`, `Tung`.
- Result action: `Fortsett`.
- Figure tap in result state continues flow.
- Settings remains behind gear icon and keeps circle-first model.
- In-memory scheduler/adaptive logic and energisk chain behavior remain unchanged.
- Existing idle/happy/sleep animation mapping remains unchanged.
- Companion events remain in-memory and deferred audio remains auto-skipped in event layer.
- No database/backend/auth/notifications/TTS in this phase.

## Product Constraints and Clarifications

- History/statistics must feel supportive and reflective.
- Avoid pressure, ranking, shame, or productivity scoring language.
- Personal milestone reporting is explicitly out of scope as a separate reporting feature.
- Timeline markers for app events/unlocks are allowed when implemented gently.

## Delivery Strategy

- Start with clear history domain concepts and aggregation rules in `lib/core/history/`.
- Introduce a repository boundary before any persistence implementation.
- Build a very small MVP history UI (7-day bars + day detail) using built-in Flutter widgets.
- Keep grouping (week/month/year) and automatic summaries as later slices.
- Keep all data and UI work in-memory until persistence is explicitly approved.
- Prepare a Drift/SQLite handoff plan without implementing database code now.

## Suggested File and Module Direction

This plan does not implement code, but future implementation should likely keep this split:

- Core history model/aggregation/repository abstractions in `lib/core/history/`
- History feature UI in `lib/features/history/`
- Home page acts as source of inputs, not history-logic owner
- Tests under `test/core/history/` and `test/features/history/`

Potential future files (not created in this plan):

- `lib/core/history/history_entry.dart`
- `lib/core/history/day_history_summary.dart`
- `lib/core/history/history_aggregator.dart`
- `lib/core/history/history_repository.dart`
- `lib/core/history/in_memory_history_repository.dart`
- `lib/features/history/history_screen.dart`
- `lib/features/history/widgets/day_activity_bar.dart`
- `lib/features/history/widgets/day_detail_view.dart`
- `test/core/history/history_aggregator_test.dart`

---

## Chunk 1: History Domain Model and In-Memory Aggregation Foundation

### Goal

Define small history-friendly domain objects and aggregation rules that can transform existing runtime data (attempts, moods, events) into day-level summaries without introducing persistence.

### Files likely to change

- `lib/core/models/attempt_entry.dart` (only if minimal metadata is needed)
- `lib/features/home/home_page.dart` (only for wiring data emit calls, no heavy logic)

### New files likely to be created

- `lib/core/history/history_entry.dart`
- `lib/core/history/day_history_summary.dart`
- `lib/core/history/history_aggregator.dart`
- `test/core/history/history_aggregator_test.dart`

### Data/state needed

- In-memory history entries from:
  - task attempts (`Ja`/`Nei`/interrupted-equivalent in current model)
  - mood selections
  - companion event moments (triggered/skipped/saved)
- Aggregated day-level values:
  - completed count
  - attempts/activity count
  - active-day flag
  - optional mood distribution summary

### UI behavior

- No new visible UI required in this chunk.
- Existing user flow stays unchanged.

### Tests to add/update

- Aggregates count `Ja` completions correctly.
- Non-completed outcomes are included as activity but not as completed count.
- Multiple entries on same day aggregate into one day summary.
- Empty days produce zero-activity summary values without error.
- Event markers are captured in day summary timeline metadata.

### Documentation updates

- `TECH_DEBT.md` only if new interim shortcuts are introduced.
- `DB_NOTES.md` only if this chunk clarifies future storage fields.

### Acceptance criteria

- Aggregation logic works fully in memory from current runtime data.
- No UI/flow regression in home/scheduler/event prototype behavior.
- History aggregation rules are test-covered and readable.

### Risks/open questions

- Definition of "interrupted" in current attempt model may need an explicit enum later.
- Day-boundary/timezone rule must be chosen and used consistently.

---

## Chunk 2: In-Memory History Repository Boundary

### Goal

Introduce a repository-style boundary for history read/write operations while keeping runtime-only implementation.

### Files likely to change

- `lib/features/home/home_page.dart` (replace direct history writes with repository calls)
- `lib/core/events/companion_event_controller.dart` (only if event timeline emission hook is needed)

### New files likely to be created

- `lib/core/history/history_repository.dart`
- `lib/core/history/in_memory_history_repository.dart`
- `test/core/history/in_memory_history_repository_test.dart`

### Data/state needed

- Repository API for:
  - append history entry
  - query day summaries (for date range)
  - query day detail entries (single day)
- In-memory backing store keyed by timestamp/day.

### UI behavior

- No required new user-visible behavior.
- Existing prototype remains visually and behaviorally unchanged.

### Tests to add/update

- Writes/reads preserve order and data integrity.
- Range queries return correct days.
- Day-detail query returns correct entries and marker metadata.
- In-memory reset behavior is explicit and test-documented.

### Documentation updates

- `PROJECT_DNA.md` concise architecture note if repository boundary lands.
- `TECH_DEBT.md` entry update if in-memory repo is temporary debt.

### Acceptance criteria

- History consumers depend on repository abstraction, not concrete storage details.
- No dependency additions and no persistence implementation.

### Risks/open questions

- API shape should avoid premature schema commitments before Drift approval.
- Event/mood write timing should be consistent with user-visible flow stages.

---

## Chunk 3: Minimal History Screen MVP (7-Day Bars)

### Goal

Add a first calm history screen with a simple 7-day overview: one bar per day using built-in Flutter widgets and supportive copy.

### Files likely to change

- `lib/features/home/home_page.dart` (small navigation entry only)
- `lib/features/home/settings_page.dart` (optional entry if chosen)

### New files likely to be created

- `lib/features/history/history_screen.dart`
- `lib/features/history/widgets/day_activity_bar.dart`
- `lib/features/history/widgets/history_empty_state.dart`
- `test/features/history/history_screen_test.dart`

### Data/state needed

- Last 7 days day-summary query from history repository.
- Per-day values for:
  - completed count (primary bar height)
  - optional activity hint (for example dot/secondary shade)

### UI behavior

- Calm daily bars with minimal numbers.
- Supportive empty/low-activity text (for example: "Noen dager er roligere").
- No pressure language, rankings, or performance score.
- No external chart package.

### Tests to add/update

- Renders exactly 7 daily bars for 7-day query.
- Empty state appears with supportive tone when no activity exists.
- Mixed-activity week renders bars without overflow or layout break.
- Existing home/settings flows remain intact after adding navigation entry.

### Documentation updates

- `FILE_TREE.md` update when feature files are added.
- `PROJECT_DNA.md` status note once history MVP exists.

### Acceptance criteria

- User can open history screen and see a calm 7-day overview.
- UI remains simple and non-punitive.
- No dependency/database/backend additions.

### Risks/open questions

- Best placement for history entry point without cluttering current calm UI.
- Whether to show exact values by default or only on interaction.

---

## Chunk 4: Day Detail View

### Goal

Allow tapping a day bar to open a day-detail view that shows a neutral, supportive breakdown for that day.

### Files likely to change

- `lib/features/history/history_screen.dart`

### New files likely to be created

- `lib/features/history/widgets/day_detail_view.dart`
- `lib/features/history/widgets/day_detail_section.dart`
- `test/features/history/day_detail_view_test.dart`

### Data/state needed

- Day-level detail query including:
  - completed tasks
  - non-completed attempts
  - mood entries
  - event/unlock markers
  - activity times

### UI behavior

- Tap on day bar opens detail surface (route/sheet based on design decision).
- Copy remains neutral and supportive.
- No guilt framing for empty/quiet days.

### Tests to add/update

- Tapping bar opens detail for selected day.
- Detail sections display expected categories.
- Quiet day view uses calm copy and no punitive wording.

### Documentation updates

- `PROJECT_DNA.md` concise note if interaction pattern is finalized.

### Acceptance criteria

- Day details are accessible from 7-day view.
- Detail content reflects stored in-memory history accurately.

### Risks/open questions

- Route vs sheet interaction tradeoffs for mobile ergonomics.
- How to summarize repeated task titles without visual clutter.

---

## Chunk 5: Persistence Planning and Drift/SQLite Handoff (No Implementation)

### Goal

Prepare an explicit migration/handoff plan from in-memory history repository to future local-first persistence, without adding DB code now.

### Files likely to change

- `DB_NOTES.md`
- `TECH_DEBT.md`
- `docs/epics/EPIC_HISTORY_AND_STATS.md` (only if clarifications are needed)

### New files likely to be created

- Optional future planning note under `docs/plans/` if needed (for example migration checklist).

### Data/state needed

High-level future storage needs (no schema commitment):

- task attempts with timestamp and result (`Ja`/`Nei`/other non-completed)
- task metadata snapshot at attempt time (id/title/focus area/difficulty)
- mood entries and timing
- mood-before/mood-after linkage where applicable
- energisk-chain linkage metadata where relevant
- event lifecycle records (triggered/skipped/saved)
- achievement/unlock timeline markers
- day aggregate summaries or derivation strategy
- optional weekly/monthly summary cache strategy
- user-facing history entry stream

### UI behavior

- None in this chunk (planning only).

### Tests to add/update

- None required in this chunk unless repository interface contracts are formalized.

### Documentation updates

- `DB_NOTES.md` with clear status:
  - no database implemented yet
  - local-first persistence planned later
  - Drift + SQLite likely/preferred later direction, not implemented now
- `TECH_DEBT.md` update to keep in-memory history limitations explicit.

### Acceptance criteria

- Migration strategy is clear enough for a future implementation agent.
- No database or dependency is introduced.

### Risks/open questions

- On-demand aggregation vs cached summaries for long timelines.
- Data-retention and pruning policy for very long-term use.

---

## Chunk 6: Later Grouping, Timeline Markers, and Supportive Summaries

### Goal

Extend history experience beyond MVP with grouped time navigation and gentle weekly/monthly summaries.

### Files likely to change

- `lib/features/history/history_screen.dart`
- `lib/core/history/history_aggregator.dart`
- `lib/core/history/history_repository.dart`

### New files likely to be created

- `lib/core/history/time_grouping.dart`
- `lib/core/history/summary_builder.dart`
- `lib/features/history/widgets/time_group_switcher.dart`
- `lib/features/history/widgets/timeline_marker_chip.dart`
- `test/core/history/summary_builder_test.dart`

### Data/state needed

- Grouped aggregates for:
  - day (recent)
  - week (intermediate)
  - month (longer-term)
  - year (multi-year overview)
- Summary inputs:
  - completed tasks count
  - active days
  - mood trend/most common mood
  - important events/unlocks
  - optional longest streak (displayed gently, never punitive)

### UI behavior

- Navigation: year -> month -> week -> day and back.
- Timeline markers for events/unlocks/achievements with low-clutter rules.
- Weekly/monthly summaries in calm, supportive language.
- Explicitly avoid personal milestone reporting as a separate reporting module.

### Tests to add/update

- Group transitions return expected buckets.
- Marker density rules avoid clutter in busy periods.
- Summary text generation avoids punitive wording.
- Navigation round-trip between grouping levels is stable.

### Documentation updates

- `PROJECT_DNA.md` and `EPIC_HISTORY_AND_STATS.md` concise status updates as slices land.

### Acceptance criteria

- Grouped history navigation works at planned levels.
- Summaries remain supportive and non-pressure oriented.
- No ranking/productivity dashboard behavior is introduced.

### Risks/open questions

- How much auto-summary text variation is needed to avoid repetition.
- Accessibility/readability of marker overlays on small screens.

---

## Cross-Cutting Testing Plan

- Unit tests for aggregation, grouping, and summary-building logic.
- Repository contract tests to keep storage swap safe.
- Widget tests for 7-day bars, day detail interactions, and empty states.
- Tone checks for supportive copy in history screens and summaries.
- Regression checks to ensure home flow, companion events, and energisk chain behavior are not altered by history integration.

## Future Persistence Preparation (No Implementation in This Plan)

History/statistics usefulness depends on persistence across restarts. Until persistence is approved, history remains prototype-only and in-memory.

When persistence is approved, keep a repository boundary and migrate implementation behind it rather than wiring DB logic directly into UI.

## Non-Goals for This Planning Pass

- No code implementation.
- No dependencies or chart packages.
- No database schema implementation.
- No backend/auth/notifications/TTS/audio changes.
- No redesign of current home/settings UI.
- No personal milestone reporting as a separate reporting feature.
