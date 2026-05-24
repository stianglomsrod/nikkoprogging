## Database direction

The app will use a local-first database strategy.

Chosen local database:
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

Future backend options:
- Supabase/Postgres for account, backup, sync and remote task catalog
- Firebase only if realtime/cloud-first features become central