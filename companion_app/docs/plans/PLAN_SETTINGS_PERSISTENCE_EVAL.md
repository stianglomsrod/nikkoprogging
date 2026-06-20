# PLAN: Focus-Area Settings Persistence Evaluation

## Goal

Add a small local persistence slice for focus-area settings so choices survive app restarts, without expanding product scope.

## Scope (persist now)

- enabled/disabled per focus area
- start/end hour per focus area
- modus per focus area
- selected focus area id in settings

## Out of scope (do not persist now)

- prototype simulated hour (dev-state)
- scheduler runtime counters
- adaptive engine internals
- energisk chain runtime state
- new UI/feature behavior

## Data contract (initial)

For each focus area id:

- enabled: bool
- startHour: int
- endHour: int
- modus: enum name (`avslappet`/`stabil`/`sporty`)

Global settings field:

- selectedAreaId: nullable string (fallback to first available area)

## Runtime behavior

- app starts from seed focus areas
- if persisted settings exist, values are merged by matching `focusArea.id`
- unknown persisted ids are ignored
- if persisted selectedAreaId is missing/invalid, use first available area id

## Architecture boundary

- new repository boundary under `lib/core/settings/`
- drift implementation behind same interface
- Home page consumes repository snapshot only for hydration and save-on-settings

## Acceptance criteria

- focus-area settings survive restart
- selected settings circle survives restart when valid
- no change to history/event/identity persistence behavior
- no new dependencies
- `flutter analyze` and `flutter test` pass
