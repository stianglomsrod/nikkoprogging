# Plan: Agent Slices (Execution Handover)

## Purpose

Denne planen er laget for nye agenter som skal plukke opp arbeidet i små, trygge leveranser.
Hver slice skal kunne gjennomfores og valideres isolert.

## Working Rules

- Jobb kun innenfor aktiv slice.
- Ikke utvid scope uten eksplisitt brukerbeskjed.
- Kjor validering etter hver slice.
- Oppdater relevante epic/plandokumenter nar slice er ferdig.

## Current Progress Snapshot

- Slice 0: Done
- Slice 1: In progress (delvis)
- Slice 2: Not started
- Slice 3: Not started
- Slice 4: Not started
- Slice 5: Not started
- Slice 6: Not started

---

## Slice 0: Baseline and Acceptance Freeze

### Goal

Frys krav, testbaseline og leveranseformat for videre arbeid.

### Scope

- Samle akseptkriterier per epic-punkt.
- Bekreft testbaseline og analyse-status.

### Done When

- Baseline-rapport finnes.
- Valideringskommandoer er fastlagt.

### Validation

- flutter analyze
- flutter test test/widget_test.dart

---

## Slice 1: Global Feedback + Screenshot Capture

### Goal

Feedback skal vaere tilgjengelig fra alle sentrale views, og screenshot tas automatisk ved feedback-entry.

### Scope

- Global feedback trigger (ikke kun Home).
- Automatisk screenshot-capture ved apning av feedback.
- Lagre screenshotPath i feedback-item.
- Vise screenshot i feedback detail.

### Out of Scope

- Offline queue/retry.
- Rate limiting/cooldown.

### Done When

- Feedback kan apnes fra flere views.
- Innsendt feedback lagrer screenshot-referanse nar capture lykkes.
- Detail-view viser screenshot med fallback ved manglende fil.

### Validation

- flutter analyze
- flutter test test/widget_test.dart
- Relevante feedback-tester

---

## Slice 2: Offline Queue/Retry + Anti-Spam

### Goal

Robust lokal innsending med retry og spam-beskyttelse.

### Scope

- Lokal queue med status: pending/sending/sent/failed.
- Retry-strategi (exponential backoff + jitter).
- Enkel cooldown/rate limiting lokalt.
- Rolig brukerfeedback ved blokkering.

### Done When

- Offline innsending bevares uten tap.
- Retry skjer kontrollert uten duplikater.
- Rask spam-blasting begrenses.

### Validation

- flutter analyze
- Fokus-tester for feedback queue/rate-limit

---

## Slice 3: Bedtime Schedule + Leggetid Prompt

### Goal

Bruker skal sette leggetid i settings og fa leggetid-paminnelse med forslag om a starte sovnlyd.

### Scope

- Leggetid-felt i settings.
- Triggerlogikk ved app-bruk/resume rundt leggetid.
- Prompt med handlinger: start sovnlyd / senere.

### Done When

- Leggetid kan lagres og endres.
- Prompt vises riktig ved tidspunkt i normal app-flyt.

### Validation

- flutter analyze
- Widget/integration-tester for leggetid-flow

---

## Slice 4: Marker Overlay + Statistics Surface

### Goal

Synliggjore viktige markorer i historikk og etablere egen statistikkflate.

### Scope

- Marker-overlay pa dagstolper (events/unlocks).
- Ny statistics-surface med rolige aggregater.

### Done When

- Markorer vises tydelig uten visuelt rot.
- Statistikkside har egen inngang og fungerer med eksisterende data.

### Validation

- flutter analyze
- Historikk/statistikk widget-tester

---

## Slice 5: Day/Week/Month/Year Navigation

### Goal

Implementere tidsnivaa-navigasjon i historikk/statistikk.

### Scope

- Bytte mellom day/week/month/year.
- Drill down/up mellom nivaaer.
- Korrekt aggregering per nivaa.

### Done When

- Navigasjon fungerer stabilt mellom alle tidsnivaa.
- Data stemmer mellom aggregater og detaljvisning.

### Validation

- flutter analyze
- Tester for tidsnavigasjon og aggregater

---

## Slice 6: Documentation Alignment

### Goal

Oppdatere epics/plans sa dokumentasjonen matcher faktisk produktretning.

### Scope

- Oppdater companion events-epic med faktiske UX-valg.
- Oppdater feedback-epic med valgt implementasjonsretning.
- Oppdater history/stats-epic med faktiske leveranser.

### Done When

- Ingen kjente avvik mellom dokumentasjon og implementert adferd.

### Validation

- Dokument-review + referanser til endrede filer

---

## Agent Handover Checklist (per slice)

1. Les aktiv slice i denne planen.
2. Les relevante epic-dokumenter under docs/epics.
3. Verifiser berorte filer med read før edit.
4. Implementer minst mulig nødvendig endring.
5. Kjor validering.
6. Rapporter:
   - Implementert
   - Delvis implementert
   - Ikke implementert
   - Neste steg

## Suggested Reporting Template

- Slice: <id/navn>
- Resultat: Done/Partial/Blocked
- Endrede filer: <liste>
- Tester/analyse: <resultat>
- Gjenstaende arbeid i samme slice: <kort liste>
- Forslag til neste slice: <id/navn>
