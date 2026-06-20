# PLAN: Global Feedback Implementation (Checklist + Chunks)

## Purpose

Convert feedback discovery into a strict, MVP-first implementation checklist without starting feature code yet.

This document is implementation planning only.

## Recommendation evaluation

The previous GPT recommendation is good and aligned with project constraints:

- Correct to require a checklist/chunk plan before coding.
- Correct to keep MVP narrow and defer screenshot/sync/rate limiting.
- Correct to clarify architecture boundaries and test scope first.

One adjustment for this project:

- Chunk 1 should include repository boundary plus Drift table together, but keep them isolated from UI wiring.

## MVP boundary (must stay strict)

Include in MVP:

- global feedback trigger
- feedback modal (type + message)
- local persistence for feedback items
- minimal feedback history list/detail

Explicitly deferred:

- screenshot capture
- sync/backend
- search/filter
- rate limiting/cooldown
- attachment/media
- advanced metadata pipeline

## Product/UX decisions to lock before coding

### 1) Global feedback trigger placement

Decision target:

- Place trigger where it is reachable but does not compete with the calm top line.

Candidate options:

- A: Small icon button in app bar actions (preferred for MVP consistency)
- B: Floating corner chip/button (higher visual noise, likely not preferred)

MVP recommendation:

- Use app bar action button with neutral tooltip text.

### 2) Feedback history entry

Decision target:

- Keep history reachable without extra global clutter.

Candidate options:

- A: History access from feedback modal (single flow entry)
- B: Separate app-bar action (more discoverable, more clutter)

MVP recommendation:

- Open feedback modal first; include a simple “Historikk” action inside the modal.

### 3) Copy/tone guardrails

Must remain:

- calm, supportive, neutral
- no blame/guilt language
- no technical/debug labels in user copy

## Architecture checklist

### Domain model (MVP)

Feedback item fields:

- id
- createdAtMs
- type (`general`, `bug`, `suggestion`)
- message
- appVersion (optional)
- screenContext (optional short string)

### Drift table (MVP exactness)

Proposed table:

- `feedback_items`

Columns:

- `id` TEXT PK
- `created_at_ms` INTEGER NOT NULL
- `feedback_type` TEXT NOT NULL
- `message` TEXT NOT NULL
- `app_version` TEXT NULL
- `screen_context` TEXT NULL
- `updated_at_ms` INTEGER NULL

Indexes:

- `idx_feedback_items_created_at_ms`
- optional `idx_feedback_items_feedback_type` (MVP optional)

### Repository boundary

Create under `lib/core/feedback/`:

- `feedback_repository.dart` (interface)
- `feedback_item.dart` (domain entity)
- `drift_feedback_repository.dart` (implementation)

Repository MVP operations:

- `readAll()` ordered newest-first
- `append(FeedbackItem item)`
- `readById(String id)` (optional if detail requires)

## UI checklist (MVP)

Create under `lib/features/feedback/`:

- `feedback_sheet.dart` (compose + send)
- `feedback_history_screen.dart` (list)
- `feedback_history_detail_screen.dart` (optional simple detail)
- small helper widgets as needed

Validation rules:

- message required, trimmed
- max length soft cap (for example 1000 chars) optional for MVP

## Test checklist

Core tests:

- repository write/read round-trip
- repository newest-first ordering
- empty state handling

Widget tests:

- feedback entry point opens sheet
- cannot send empty message
- send persists feedback and closes/shows calm confirmation
- history shows persisted entries
- calm copy and non-punitive wording assertions

Regression checks:

- `flutter analyze`
- `flutter test`

## Chunk plan

### Chunk 1: Feedback domain + repository + Drift table

- Add domain model
- Add repository interface + Drift implementation
- Add Drift table + migration
- Add core repository tests

Done criteria:

- can write/read feedback items locally
- migration test updated
- no UI changes yet

### Chunk 2: Feedback modal (compose/send)

- Add app-level entry point
- Add compose sheet with type + message
- Save through repository
- Calm success/failure feedback

Done criteria:

- user can submit one feedback item end-to-end
- no history screen required yet

### Chunk 3: Feedback history minimal view

- List persisted feedback entries
- Open simple item detail (if needed)

Done criteria:

- user can inspect prior submissions

### Chunk 4: Polish + test hardening

- copy/tone polish
- accessibility/spacing pass
- final test hardening

Done criteria:

- no regressions, tests green, calm UX preserved

## Deferred explicitly (post-MVP)

- screenshot capture and storage policy
- backend/sync contract
- offline retry engine
- search/filter
- cooldown/rate limiting
- retention/cleanup policy

## Go/No-Go gate

Go only if all are accepted:

- MVP boundary above is frozen
- trigger placement decision is approved
- Drift table shape is approved
- repository boundary is approved
- deferred list stays deferred

No-Go if scope expands beyond MVP boundary before Chunk 1 starts.
