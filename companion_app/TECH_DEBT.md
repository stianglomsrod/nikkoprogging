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
  - Replace hardcoded source with real persistence and/or backend sync only after product flow is validated.
- Trigger to resolve:
  - When core user flow is stable and we need persistent history, personalization accuracy, or multi-session continuity.

### 2) No real scheduler/notifications yet

- Status: Active (intentional)
- Decision: The first prototype may simulate scheduler behavior manually (for example, a simulate-next-prompt control) instead of using real timed scheduling/notifications.
- Reason: Validate product flow before adding timing, platform background behavior, and notification complexity.
- Risk:
  - Timing behavior is not production-accurate.
  - Prompt cadence and overlap edge cases are only partially validated.
- Future resolution:
  - Add a dedicated scheduler component that respects per-focus-area active windows and `Modus` quotas.
  - Integrate notification delivery when explicitly requested.

### 3) No persistent history yet

- Status: Active (intentional)
- Decision: Task outcomes, mood history, and adaptive state may be kept in memory for prototype flow testing.
- Reason: Keeps implementation simple while validating UX and adaptation rules.
- Risk:
  - State resets between sessions.
  - Success-rate behavior cannot be validated over realistic long-term use.
- Future resolution:
  - Introduce persistence/history storage behind repository interfaces.
  - Then decide database/backend strategy based on validated product needs.

### 4) Failed/skipped-task avoidance may be simulated in memory

- Status: Active (intentional)
- Decision: Product rule is to diversify away from recently failed/skipped tasks; in early prototype this may be tracked in memory only.
- Reason: Enforces core behavior quickly without full persistence stack.
- Risk:
  - Recent-failure memory is lost on app restart.
  - Behavior may look inconsistent across sessions.
- Future resolution:
  - Persist recent outcomes/history so avoidance logic remains stable across sessions.
  - Keep non-punitive behavior as a fixed product rule.

## Deferred Integrations (By Decision)

- Riverpod
- Drift + SQLite (not now; evaluate later)
- Supabase (not now)
- Firebase (not now)
- `flutter_local_notifications`
- `flutter_tts`
- Backend/sync/auth (if later required)

These are deferred intentionally and should not be added unless explicitly requested.
