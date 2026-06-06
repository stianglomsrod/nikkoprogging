# EPIC: Global Feedback Button

## Purpose
Define a future feedback system where testers/users can submit context-rich feedback from anywhere in the app, including offline scenarios.

## User Value
- Reduces friction to report issues and ideas immediately.
- Improves feedback quality via automatic screenshot and context capture.
- Builds trust by preserving drafts/history and handling offline use safely.

## Scope
- Always-available global feedback trigger in upper-left UI area.
- Automatic screenshot capture on feedback entry.
- Feedback modal for text + type + send/cancel.
- Feedback history view separate from new-report flow.
- Search/filter capabilities in feedback history.
- Offline queueing and later sync concept.
- Basic rate limiting/cooldown behavior.

## Out of Scope for Now
- Implementation of button/modal/history UI.
- Screenshot implementation details.
- File-storage implementation.
- Backend APIs or sync implementation.
- Final anti-spam policy tuning.

## Trigger and Entry Points
- Primary entry: fixed feedback button visible in all app views.
- Secondary entry: open feedback history without starting a new report.
- On feedback button tap:
  1. capture screenshot of current screen
  2. capture context metadata
  3. open feedback modal

## UX Flow
### New feedback flow
1. User taps global feedback button.
2. System captures screenshot automatically.
3. System attaches context:
   - active page/view
   - recent user actions
   - timestamp
   - state/session id
4. Modal opens and user can:
   - write feedback text
   - choose type (`generell feedback`, `bug report`, `forbedringsforslag`)
   - send or cancel
5. If practical, draft text is preserved on cancel.

### History flow
1. User opens feedback history.
2. Sees earlier submissions.
3. Can open an item to view:
   - screenshot
   - text
   - type
   - timestamp
4. Can search and filter by:
   - text/metadata
   - feedback type
   - date

### Offline behavior
- If offline, report is stored locally.
- Sync retry happens later when connectivity is available.
- Data should not be lost.

### Rate limiting behavior
- Limit submissions per defined time period.
- Apply brief cooldown after send.
- Show calm wait message when limit is exceeded (for example: `Vent litt før du sender på nytt.`).

## Data Implications
Likely future data concepts:
- Feedback report entity:
  - id
  - screenshot path/reference
  - user text
  - feedback type
  - context metadata
  - created timestamp
- Local sync fields:
  - sync status
  - retry count / last retry time
  - last sync error
- Optional local draft state for canceled/interrupted composition.

## Persistence/Backend Implications
- Requires local persistence for history and offline queue.
- Requires local file/image storage for screenshots.
- Requires sync design for eventual backend upload.
- Drift + SQLite likely for metadata; file storage strategy needed for image binaries.
- Backend can be phased later; MVP may begin local-only for testers.

## Risks and Open Questions
- Screenshot privacy and sensitive-content handling policy.
- Limits on screenshot resolution/size and storage cleanup policy.
- Which recent actions are safe and useful to include in context metadata.
- Retention window for local feedback history and attachments.
- Exact spam/cooldown thresholds.

## Suggested Implementation Phases
1. Local-only capture and storage foundation:
   - screenshot capture abstraction
   - metadata model
   - local storage and history list
2. Global button + modal + local send flow.
3. Search/filter in history.
4. Offline queue state and retry engine.
5. Optional backend sync and server-side rate limiting.

## Acceptance Criteria for a Future MVP
- Global feedback button is visible from all primary app views.
- Tapping button captures screenshot automatically and opens feedback modal.
- User can send/cancel with text + feedback type.
- History view lists earlier feedback and opens detail entries.
- Offline submissions are queued locally and preserved.
- Feedback items include screenshot, text, type, context, timestamp.
- Basic rate limiting/cooldown prevents rapid spam bursts.
- Feature is documented and implemented as calm/supportive UX.
