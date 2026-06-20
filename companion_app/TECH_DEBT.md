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

### 3) History persistence is partial (raw timeline only)

- Status: Active (intentional)
- Decision: Raw history timeline entries are now persisted locally for attempts, moods, and event actions using Drift + SQLite.
- Decision: Aggregates remain derived and several adjacent domains still run in memory.
- Reason: This keeps persistence rollout narrow and low-risk while preserving current repository/UI behavior.
- Risk:
  - Some behavior still resets between sessions because non-history state is not persisted yet.
  - Aggregation cost may grow with larger timelines until optional cache slices are introduced.
- Future resolution:
  - Add next persistence slices incrementally behind existing repository interfaces.
  - Keep summary caches optional and performance-driven.

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

### 7) Companion-figur bruker forelopig et statisk prototype-asset

- Status: Active (intentional)
- Decision: Companion vises na med et lokalt bilde-asset i appen, uten dynamiske varianter eller temaspesifikke asset-sett.
- Reason: Gir bedre visuell identitet i prototypen med lav teknisk kompleksitet.
- Risk:
  - Assetet kan fortsatt oppleves som midlertidig inntil endelig visuell profil er avklart.
- Future resolution:
  - Erstatt/utvid med endelig figurpakke nar visuell retning og navneevent er avklart.

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

### 10) Innholdsbibliotek er fortsatt lokalt og hardkodet

- Status: Active (intentional)
- Decision: Tekster og oppgaver fra `texts.py` er konvertert til et lokalt Dart-bibliotek i appen.
- Reason: Holder innhold enkelt tilgjengelig i prototypefasen uten backend eller database.
- Risk:
  - Innholdet er ikke redigerbart uten kodeendring.
  - Tone og variasjon er ikke validert fullt ut i appen enn.
- Future resolution:
  - Flytt innhold bak en tydelig repository/content-kilde nar persistering eller ekstern admin blir relevant.

### 11) Oppgavebiblioteket er forelopig mest husarbeidstungt

- Status: Active (intentional)
- Decision: Oppgaver fra `texts.py` er i denne passeringen primart koblet til `Huslige oppgaver`.
- Reason: Kildematerialet er hovedsakelig husholdningsorientert.
- Risk:
  - Andre Fokusomrader har mindre rikt innholdsgrunnlag enn husholdning forelopig.
- Future resolution:
  - Utvid innholdsbiblioteket med tilsvarende oppgavebanker for studier, trening og paminnelser.

### 12) Energisk-kjede er forelopig kun runtime-basert

- Status: Active (intentional)
- Decision: To-oppgavekjede etter to pa rad `Energisk` spores kun i minne via egen helper (`lib/core/flow/energisk_chain_controller.dart`).
- Reason: Holder prototypelogikken liten og enkel i valideringsfasen.
- Risk:
  - Hvis appen lukkes midt i en aktiv kjede, gjenopptas ikke kjedetilstand ved restart.
  - Samspill mellom kjedeoppgave nummer to og fremtidig `Modus`/kvotelogikk er valgt minimalt i denne passeringen.
- Future resolution:
  - Persist kjedetilstand nar persisteringslag prioriteres.
  - Avklar og implementer endelig kvotepolicy mellom scheduler-prompt og intern kjedeoppgave i senere modell.

### 13) Companion-animasjon er forelopig spritesheet-basert prototypeflyt

- Status: Active (intentional)
- Decision: Companion-animasjon er i denne fasen frame-basert og generert fra et kilde-spritesheet via lokalt verktøy.
- Reason: Rask validering av rolig figurbevegelse uten a introdusere runtime-avhengigheter eller kompleks animasjonspipeline.
- Risk:
  - Frame-sett og timinger er forelopige og kan trenge justering nar endelig visuell profil er klar.
  - Ved oppdatert spritesheet ma generering kjores pa nytt.
  - Runtime-koblingen mellom `idle`/`happy`/`sleep` er bevisst enkel i prototypen og kan trenge finjustering i senere UX-pass.
- Future resolution:
  - Erstatt med endelige produksjonsassets nar visuell retning er ferdig.
  - Behold eller forenkle verktoyflyten avhengig av endelig art pipeline.

### 14) Companion-events/unlocks er implementert med smal persistering

- Status: Active (intentional)
- Decision: Event-sekvens for unlocks er implementert i appflyt, og event-state persistering er innfort i en smal Slice 2 (completed count + trigger/handled/skipped/pending state).
- Reason: Sikrer stabil unlock-progresjon pa tvers av app-restart uten full data-lags omskriving.
- Risk:
- Event-state er persistert, men andre domener rundt langsiktig personalisering og lyd er fortsatt delvis deferred.
- Future resolution:
- Utvid persistering trinnvis for resterende domener ved behov (for eksempel lydpreferanser nar audio-slice blir aktiv).

### 15) Historikk/statistikk er MVP med delvis persistering

- Status: Active (intentional)
- Decision: En liten in-memory grunnmur for historikk (entry-modeller + dagaggregering) er lagt i `lib/core/history/`.
- Decision: Repository-grensen for historikk er beholdt, og en Drift-basert implementasjon er lagt bak samme API (`drift_history_repository`) for raw timeline persistering.
- Decision: En enkel historikkskjerm med 7-dagers stolper og rolig empty-state er lagt i `lib/features/history/`.
- Decision: Dagdetalj er lagt via tap pa stolpe (fullfort/ikke-fullfort, stemning, hendelser, aktivitetstidspunkter), men gruppering (uke/maned/ar) og oppsummeringer er ikke implementert enn.
- Decision: Chunk 5 handoff-plan er delvis realisert gjennom Persistence Slice 1 (Drift + SQLite for raw timeline), mens videre slices gjenstar.
- Reason: Holder tidlig validering enkel, men forbereder tydelig domene og aggregeringsregler for senere iterasjoner.
- Risk:
- Historikkvisningen kan fortsatt oppleves for enkel over tid uten gruppering og oppsummeringer.
- Dagens oppsett persisterer ikke ennå andre domener rundt historikk (for eksempel innstillinger/unlock state), sa helhetsopplevelsen er fortsatt delvis runtime-basert.
- Future resolution:
- Legg til uke/maned/ar-gruppering og rolige oppsummeringer etter validering av dagdetaljflyt.
- Hold dagoppsummeringer derivert i neste fase, og vurder cache bare ved reelt behov.

### 16) Global feedback-system er roadmap-only og avhenger av lagring/sync

- Status: Active (intentional)
- Decision: Global feedbackknapp med automatisk skjermbilde, historikk og offline-kø er dokumentert, men ikke implementert.
- Reason: Krever skjermbildehåndtering, lokal lagring, metadata, offline-kø og senere sync-strategi.
- Risk:
  - Testere mangler innebygd tilbakemeldingskanal direkte i appen.
- Future resolution:
  - Start med lokal feedback-flyt + historikk.
  - Legg til offline retry/sync etter at persistering er etablert.

## Deferred Integrations (By Decision)

- Riverpod
- Supabase (not now)
- Firebase (not now)
- `flutter_local_notifications`
- `flutter_tts`
- Backend/sync/auth (if later required)

These are deferred intentionally and should not be added unless explicitly requested.
