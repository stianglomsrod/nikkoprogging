# PLAN: Global Feedback Discovery (MVP-First)

## Purpose

Define a small, safe MVP plan for the Global Feedback epic before implementation.

This is a discovery/planning pass only.

## Why now

- Core local persistence baseline is now solid:
  - history timeline
  - companion event state
  - companion identity state
  - focus-area settings
- History MVP is currently sufficient for prototype quality.
- Feedback is likely the next highest-value capability for structured tester input.

## Scope strategy

Split into:

- MVP now (local-only, no screenshot, no sync)
- Later phases (screenshot, richer metadata, sync, search/filter, rate limiting)

## MVP now (implementable scope)

1. Global feedback entry point
- One globally available trigger from primary app views.

2. Feedback modal
- Free-text message
- Feedback type selector:
  - generell feedback
  - bug report
  - forbedringsforslag
- Send / avbryt

3. Local storage (minimal)
- Persist locally using existing repository-first approach.
- Keep payload minimal and calm.

4. History list (minimal)
- Simple list of submitted items
- Basic detail view per item (text + type + timestamp)

## Explicit non-goals for MVP now

- Automatic screenshot capture
- Offline sync engine/backend sync
- Search/filter UI
- Rate-limiting/cooldown logic
- Attachment/media support
- Advanced metadata pipelines

## Minimal data model (MVP)

Feedback item fields:

- id
- createdAt
- type
- message
- appVersion (if easily available)
- screenContext (simple, optional string)

Notes:

- Keep metadata optional and minimal.
- Do not collect sensitive runtime internals by default.

## UX flow (MVP)

1. User taps global feedback trigger.
2. Modal opens with type + text.
3. User sends.
4. App saves locally.
5. User gets calm confirmation message.
6. User can open feedback history list and inspect past entries.

Tone constraints:

- Supportive and neutral wording.
- Avoid technical/debug-heavy copy in user-facing text.

## Privacy and safety baseline

- No screenshot in MVP.
- No background collection.
- User-submitted text only + minimal metadata.
- Keep data local-only in MVP.

## Failure handling (MVP)

- Local write failure: show gentle retry message.
- Empty message: validation with calm guidance.
- Cancel action: no warning-heavy flow.

## Acceptance criteria (for future implementation)

- Global feedback trigger reachable from primary views.
- User can send feedback with type + text.
- Submission persists locally across app restart.
- User can view previously submitted feedback entries.
- No backend/auth dependencies introduced.
- No punitive language or pressure-based UX.

## Phase 2 backlog (deferred)

- Screenshot capture and storage policy
- Metadata expansion
- Sync/backend contract
- Search/filter in history
- Rate limiting/cooldown
- Retention and cleanup strategy

## Go/No-Go gate before implementation

Go when all are true:

- MVP scope accepted exactly as defined above.
- Non-goals accepted (no screenshot/sync/rate limiting in MVP).
- Minimal data model approved.
- UX entry point approved.

No-Go if scope expands beyond MVP baseline.
