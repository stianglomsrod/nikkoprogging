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

### 5) Enkel adaptiv logikk er heuristisk

- Status: Active (intentional)
- Decision: Prototypen bruker en enkel in-memory heuristikk for Oppgave-valg (mood-basert malvanskelighet + enkel suksessrate-justering).
- Reason: Rask validering av flyt og produktforstaelse uten full adaptiv motor.
- Risk:
  - Forslag kan bli for enkle eller for krevende i kanttilfeller.
  - Modellen representerer ikke langsiktig personalisering.
- Future resolution:
  - Innfor en mer robust adaptiv motor med tydelige regler per Fokusomrade.
  - Bruk persistert historikk nar lagringslag er pa plass.

### 6) Promptteller resettes ikke automatisk per nytt tidsvindu

- Status: Active (intentional)
- Decision: `Modus`-teller per Fokusomrade spores i minne, men nullstilles ikke automatisk ved nytt tidsvindu/dogn i denne prototypen.
- Reason: Holder scheduler-simuleringen enkel i tidlig fase.
- Risk:
  - Tellelogikk avviker fra fremtidig produksjonsatferd over lengre bruk.
- Future resolution:
  - Legg til tydelig vindu/dogn-rotasjon i scheduler-komponenten.
  - Knytt tellere til tidsvinduer i persistert modell senere.

### 7) Companion-figur er forelopig en UI-placeholder

- Status: Active (intentional)
- Decision: Companion vises som en enkel Flutter-widget (former/ikon-stil) uten egendefinert grafikk-asset.
- Reason: Holder prototypen lett og rask uten nye avhengigheter.
- Risk:
  - Visuell identitet kan oppleves midlertidig.
- Future resolution:
  - Erstatt med endelig figur/design nar visuell retning og navneevent er avklart.

### 8) Navneevent er ikke implementert enn

- Status: Active (intentional)
- Decision: Appen viser forelopig navn-plassholderen `.....`.
- Reason: Navn skal introduseres i en senere egen opplevelse/event.
- Risk:
  - Oppleves midlertidig for noen brukere.
- Future resolution:
  - Implementer navneevent som lar bruker gi companion/figur et navn.

### 9) Innstillinger er fortsatt kun in-memory

- Status: Active (intentional)
- Decision: Endringer i Fokusomrader, Aktivt tidsrom og Modus lagres kun i runtime-minne.
- Reason: Ingen persistering i tidlig prototyping.
- Risk:
  - Innstillinger resettes ved app-restart.
- Future resolution:
  - Persist innstillinger via repository + valgt lagringslag nar dette prioriteres.

## Deferred Integrations (By Decision)

- Riverpod
- Drift + SQLite (not now; evaluate later)
- Supabase (not now)
- Firebase (not now)
- `flutter_local_notifications`
- `flutter_tts`
- Backend/sync/auth (if later required)

These are deferred intentionally and should not be added unless explicitly requested.
