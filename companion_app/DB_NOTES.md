## Database direction

History persistence slice 1 is now implemented.

Current implemented local persistence scope:

- Drift + SQLite is used for history timeline and companion event/identity state slices
- persisted entry types: attempts, moods, event actions
- companion event state is persisted (completed count, auto-triggered ids, handled ids, skipped ids, pending event id)
- companion identity state is persisted (companion name, user name, selected symbol, selected background tone)
- daily summaries remain derived through the existing history aggregator
- no cached summaries yet
- no week/month/year grouping persistence yet

Local-first persistence is planned later.

Likely/preferred later local database direction:

- Drift + SQLite

Reason:

- Works well with structured relational data
- Supports local-first usage
- Good fit for mood history, task attempts, achievements, memory state and adaptive calculations
- Keeps private user data local by default
- Allows future sync/backend integration through a repository layer

Still not implemented:

- no backend yet
- no auth yet
- no persistence yet for focus-area settings/modus windows, scheduler state, or global feedback

Future persistence note for energisk chain rule:

- If/when persistence is added, consider storing enough state to recover chain continuity across app restarts (for example recent mood sequence, active chain flag, remaining chain-task count, task IDs already used in active chain, and whether an attempt belongs to an energisk chain).

Future backend options:

- Supabase/Postgres for account, backup, sync and remote task catalog
- Firebase only if realtime/cloud-first features become central

## Future Data Implications from Planned Epics

Notes below cover areas that are partially implemented or not yet implemented in persistence.

### Companion events and unlocks

Likely future data areas:

- event seen/triggered timestamps
- sound preference placeholders:
  - sleep sound choice + enabled/disabled
  - background sound choice + enabled/disabled
- attempt-to-threshold linkage metadata (whether a task attempt contributed to unlock progress)

### History and statistics

Likely future data areas:

- persisted task attempt history with timestamps
- persisted mood history with timestamps
- event/unlock timeline history
- derived daily/weekly/monthly aggregates or summary snapshots

### History chunk 5 handoff notes (planning only)

Schema and database code are now implemented for the approved history slice.
This section remains relevant as rollout intent for next slices.

Recommended persistence order when implementation is approved later:

1. Persist raw timeline entries first:

- task attempts with timestamp, result state, focus area, mood, task id, and task-title snapshot
- mood entries with timestamp
- event lifecycle actions (triggered/skipped/saved) with timestamp and event id

2. Keep aggregates derived at read-time first:

- day summaries can be computed from raw entries in early persistence rollout

3. Add cached summaries only if needed later:

- weekly/monthly cache should be optional and performance-driven, not required for first persistence slice

Conceptual query/index direction for later Drift planning (no schema commitment):

- day-range timeline queries by timestamp
- single-day detail queries by day start/end boundaries
- event timeline queries by timestamp and event id

Policy decisions to keep explicit before persistence implementation:

- timezone/day-boundary normalization strategy
- snapshot policy for user-facing labels (for example task title at attempt time)
- retention policy for long-term history growth

### Global feedback

Likely future data areas:

- feedback reports (text, type, timestamp, context)
- screenshot/attachment references and storage linkage
- offline sync status fields (queued/sent/failed, retry metadata)
- optional draft/canceled feedback preservation metadata

### Direction reminder

- Database status: partial implementation is now in place for history raw timeline only.
- Local-first persistence remains the path.
- Drift + SQLite is now in use for history persistence.
- Additional persisted domains should still be added gradually behind repository boundaries.
