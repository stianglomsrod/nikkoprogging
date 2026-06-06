# EPIC: History and Statistics

## Purpose

Define a supportive history and statistics experience that helps users reflect on activity and development over time without creating performance pressure.

## User Value

- Gives gentle visibility into personal rhythm and progress.
- Helps users recognize return patterns and meaningful effort.
- Supports reflection through simple visuals and calm summaries.

## Scope

- Timeline-based history with day-level bars as primary visual.
- Drill-down from day bars to day details.
- Time grouping model: day/week/month/year navigation.
- Supportive weekly and monthly auto-summary concepts.
- Marker system for meaningful companion moments/events.

## Out of Scope for Now

- Any implementation in current prototype.
- Final charting technology decision.
- Real-time analytics pipelines.
- Competitive/ranking dashboards.
- Personal milestone reporting as a separate feature.

## Trigger and Entry Points

- Main entry point: dedicated history/statistics surface in app navigation (future).
- Secondary entry points: timeline marker taps from relevant moments (future).
- Data freshness entry: when persisted attempt/mood/event data exists.

## UX Flow

1. User opens history view.
2. Sees calm daily bar overview (one bar per day).
3. Taps a day bar to open day detail.
4. Day detail may show:
   - completed tasks
   - skipped/not completed/interrupted tasks
   - registered moods
   - triggered events
   - unlocked achievements
   - activity times during the day
5. User can move between time scales:
   - year -> month -> week -> day
   - and back up.
6. Timeline markers indicate important moments (event progression, unlocks, achievements).

## Data Implications

Likely future data concepts:

- Persisted task attempt history (status, timestamp, task/focus metadata).
- Mood history linked to interaction times.
- Event/unlock history timeline.
- Derived daily aggregates (completed count, active-day flag, mood distribution).
- Derived weekly/monthly summary snapshots or on-demand computed aggregates.
- Marker metadata for notable moments.

## Persistence/Backend Implications

- Requires persistence before meaningful implementation.
- Local-first storage is needed for continuity across sessions.
- Drift + SQLite remains likely/preferred future direction.
- Backend sync can be layered later; not required for first MVP history.

## Risks and Open Questions

- How to keep charts readable with sparse vs dense long-term data.
- Whether summaries should be computed on demand or materialized.
- Definition of "interrupted" tasks in current model.
- Strategy for handling timezone/day-boundary consistency.
- Marker density rules to avoid clutter.

## Suggested Implementation Phases

1. Persistence prerequisites:
   - task attempt history
   - mood history
   - event/unlock history
2. Day-level timeline with tap-to-detail.
3. Week/month/year grouping navigation.
4. Marker overlays for key moments.
5. Weekly/monthly summary generation with supportive copy.

## Acceptance Criteria for a Future MVP

- Daily bar timeline renders from persisted data.
- Tapping a day opens day details with key activity breakdown.
- Timeline can navigate between day/week/month/year views.
- Marker icons show important event/unlock moments.
- Weekly and monthly summaries are available in supportive tone.
- No punitive language, rankings, or pressure-oriented dashboard framing.
- Personal milestone reporting is not included as a separate reporting feature.
