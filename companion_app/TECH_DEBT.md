# TECH_DEBT

Technical debt log for intentional shortcuts, compromises, and deferred work.

## Active Debt Items

### 1) Prototype data is hardcoded/local seed data
- Status: Active (intentional)
- Decision: Use hardcoded/local seed data for the first prototype instead of a database/backend.
- Reason: Faster MVP flow validation with minimal architecture overhead.
- Risk:
  - Data model and persistence boundaries are not validated yet.
  - Migration effort will be needed when introducing real storage.
- Future resolution:
  - Introduce a repository abstraction first (read/write interfaces used by UI/domain logic).
  - Replace hardcoded source with local database (planned: Drift + SQLite) and/or backend sync only after product flow is validated.
- Trigger to resolve:
  - When core user flow is stable and we need persistent history, personalization accuracy, or multi-session continuity.

## Deferred Integrations (By Decision)
- Riverpod
- Drift + SQLite
- `flutter_local_notifications`
- `flutter_tts`
- Backend/sync/auth (if later required)

These are deferred intentionally and should not be added unless explicitly requested.
