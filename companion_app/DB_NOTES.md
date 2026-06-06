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
