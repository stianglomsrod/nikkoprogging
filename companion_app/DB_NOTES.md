## Database direction

No database yet.

Local-first persistence is planned later.

Likely/preferred later local database direction:

- Drift + SQLite

Reason:

- Works well with structured relational data
- Supports local-first usage
- Good fit for mood history, task attempts, achievements, memory state and adaptive calculations
- Keeps private user data local by default
- Allows future sync/backend integration through a repository layer

Not now:

- No database in the first clickable prototype
- No backend yet
- No auth yet

Future persistence note for energisk chain rule:

- If/when persistence is added, consider storing enough state to recover chain continuity across app restarts (for example recent mood sequence, active chain flag, remaining chain-task count, task IDs already used in active chain, and whether an attempt belongs to an energisk chain).

Future backend options:

- Supabase/Postgres for account, backup, sync and remote task catalog
- Firebase only if realtime/cloud-first features become central

## Future Data Implications from Planned Epics

No new database implementation is introduced now.
These are planning notes only for future local-first persistence work.

### Companion events and unlocks

Likely future data areas:

- completed-task counter based on `Ja` outcomes
- unlock state per event id and one-time auto-trigger flags
- companion identity preferences:
	- companion name
	- user name
	- symbol
	- background color
- sound preference placeholders:
	- sleep sound choice + enabled/disabled
	- background sound choice + enabled/disabled

### History and statistics

Likely future data areas:

- persisted task attempt history with timestamps
- persisted mood history with timestamps
- event/unlock timeline history
- derived daily/weekly/monthly aggregates or summary snapshots

### Global feedback

Likely future data areas:

- feedback reports (text, type, timestamp, context)
- screenshot/attachment references and storage linkage
- offline sync status fields (queued/sent/failed, retry metadata)
- optional draft/canceled feedback preservation metadata

### Direction reminder

- Database status remains unchanged: no database implemented yet.
- Local-first persistence remains the planned path.
- Drift + SQLite remains likely/preferred for local metadata when persistence work starts.
