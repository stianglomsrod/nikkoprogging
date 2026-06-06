# EPIC: Companion Events and Unlocks

## Purpose

Define a calm, non-punitive progression system where small companion identity moments unlock over time based on completed tasks.

## User Value

- Gives a soft sense of development and companionship without pressure.
- Makes the companion feel more personal over time.
- Keeps motivation gentle and identity-based rather than performance-based.

## Scope

- Event unlock sequence tied to completed task count (`Ja` only).
- One-time automatic event triggers at specific thresholds.
- Post-unlock settings management for unlocked identity/personalization items.
- Event copy and flow guidelines aligned with calm tone.

## Out of Scope for Now

- UI implementation of event modals/screens.
- Any audio playback or audio-engine implementation.
- New packages/dependencies.
- Persistence/backend implementation.
- Notifications/background jobs.

## Trigger and Entry Points

### Global counting rule

- Counter uses completed tasks only (`Ja`).
- `Nei` / skipped / not completed does not increment unlock progress.
- Energisk chain tasks count individually if completed:
  - If both chain tasks are answered `Ja`, that counts as 2 completed tasks.

### Event thresholds and behavior

#### 3 completed tasks: Companion name event

- Event id: `event_companion_name`
- Trigger: after 3 completed tasks.
- Prompt: `Vil du gi meg et navn?`
- Input: free text and skip option.
- Behavior:
  - If user enters a name, header shows that name.
  - If user skips, header remains `.....`.
  - Automatic trigger occurs once only.
  - User can set/change companion name later in Settings.

#### 6 completed tasks: User name event

- Event id: `event_user_name`
- Trigger: after 6 completed tasks.
- Prompt: `Hva heter du?`
- Input: free text and skip option.
- Behavior:
  - If provided, name may be used in selected greeting text.
  - If skipped, no personal name references are shown.
  - Automatic trigger occurs once only.
  - User can set/change later in Settings.

#### 9 completed tasks: Sleep sound event

- Event id: `event_sleep_sound`
- Trigger: after 9 completed tasks.
- Prompt: `Vil du ha rolig lyd når du skal sove?`
- Choices:
  - `stille`
  - `regn`
  - `havbølger`
  - `skog om natten`
  - `white noise`
  - `peis`
  - `lo-fi sleep`
- Additional controls:
  - activate feature
  - deactivate feature
- Behavior:
  - Can later support automatic playback at selected time.
  - Can later support manual start after unlock.
  - Playback should stop automatically.
  - If disabled, no automatic behavior.

#### 12 completed tasks: Background music event

- Event id: `event_background_music`
- Trigger: after 12 completed tasks.
- Prompt: `Hva slags lyd vil du ha i bakgrunnen når du bruker meg?`
- Choices:
  - `stille`
  - `lo-fi`
  - `ambient`
  - `regn`
  - `natur`
  - `piano`
- Behavior:
  - `stille` means no sound.
  - Only one active background sound at a time.
  - Applies immediately and for later sessions once persistence exists.

#### 15 completed tasks: Symbol event

- Event id: `event_symbol`
- Trigger: after 15 completed tasks.
- Prompt: `Vil du velge et lite symbol som kan være en del av meg?`
- Choices:
  - `stjerne ✦`
  - `måne ☾`
  - `blad ❧`
  - `hjerte ♡`
  - `sky ☁`
  - `dråpe 💧`
  - `ingen`
- Behavior:
  - Selected symbol is shown on both sides of companion name.
  - `ingen` means no symbol rendering.
  - Only one active symbol at a time.
  - Applies immediately once chosen.
  - Can be changed later in Settings.

#### 18 completed tasks: Background color event

- Event id: `event_background_color`
- Trigger: after 18 completed tasks.
- Prompt: `Hvilken farge føles best for deg i appen?`
- Choices:
  - `mørk blå`
  - `dyp grønn`
  - `varm grå`
  - `myk lilla`
  - `dempet beige`
  - `standard / default dark theme`
- Behavior:
  - Sets one global background tone.
  - One active color at a time.
  - Can reset to default later.
  - Can be changed later in Settings.

## UX Flow

- Unlock checks happen after result handling, not during active task interaction.
- Suggested presentation timing:
  1. User completes threshold task with `Ja`.
  2. Normal result state is shown.
  3. On continue, event prompt can be shown.
- Flow principles:
  - Calm, optional, non-intrusive.
  - Never blocks task completion flow.
  - Skip is always available.

## Data Implications

Likely future data concepts:

- Completed-task counter (`Ja` outcomes only).
- Event unlock state by event id (locked/unlocked/completed/skipped).
- One-time trigger flags for automatic event presentation.
- Companion identity preferences:
  - companion name
  - user name
  - symbol
  - background color
- Audio preference placeholders:
  - sleep sound choice and enabled flag
  - background sound choice and enabled flag

## Persistence/Backend Implications

- Requires local persistence to avoid retriggering events and to keep identity choices.
- Fits planned local-first approach (Drift + SQLite likely later).
- Backend sync is optional future work; not required for initial MVP.
- Audio events additionally require future decisions for:
  - assets
  - playback lifecycle
  - background behavior

## Risks and Open Questions

- Exact threshold boundary behavior if multiple completions are processed close together.
- Whether multiple pending unlocks should queue or show one per session.
- Name validation constraints (length, allowed characters, profanity handling) for future implementation.
- Accessibility and localization for symbol labels.
- How much event copy variation is needed to avoid repetition.

## Suggested Implementation Phases

1. Persisted unlock engine foundation:
   - completed-task counting rule (`Ja` only)
   - event state machine
   - one-time trigger safeguards
2. Companion and user naming events + settings editing.
3. Symbol and background color events + settings editing.
4. Audio unlock UI state only (no playback) if needed.
5. Audio playback implementation and lifecycle decisions.

## Acceptance Criteria for a Future MVP

- Event thresholds 3/6/9/12/15/18 are tracked from completed tasks (`Ja`) only.
- Energisk chain completions count per completed task.
- Automatic trigger for each event happens at most once.
- Companion name can be set at unlock and changed later in Settings.
- User name can be set at unlock and changed later in Settings.
- Symbol and background color can be selected and changed later in Settings.
- Event prompts appear calmly after result flow, not during task execution.
- No pressure language or punitive framing appears in event UX copy.
