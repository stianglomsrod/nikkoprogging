# PROJECT_DNA

## App Concept

`companion_app` is a calm, low-stress companion/reminder app for iOS and Android.
It should support the user based on current mood/dagsform and previous activity, while reducing pressure and decision overload.

Core product feeling:

- One task at a time.
- Gentle and supportive tone.
- No punishment loops.
- Attempts are meaningful, not only completions.

## Current Phase

Early prototype / flow-validation phase.

Current implementation status:

- Starter Flutter app scaffold is present.
- Product-specific domain, adaptive logic, and structured feature modules are not implemented yet.
- Data is intentionally local/hardcoded for first prototype iterations.

## Current Stack

- Flutter
- Dart
- VS Code
- Android emulator (current dev target)

## Product Principles

- Keep the app emotionally safe and supportive.
- Avoid guilt mechanics, fear of failure, or pressure-based engagement.
- Guide the user with clear next steps instead of large choice lists.
- Treat attempts as positive progress.
- Build rhythm and consistency, not performance pressure.

## Architecture Principles

- Keep architecture small and understandable while the product loop is being validated.
- Separate adaptive/recommendation logic from UI widgets.
- Prefer explicit, readable code over premature abstraction.
- Postpone infrastructure complexity until the interaction model is validated.

## Current Decisions (Intentional)

- Use hardcoded/local seed data in the first prototype.
- Avoid backend and persistence setup during early flow validation.
- Keep dependencies minimal and stay close to default Flutter tooling.

## Planned Later (Not Now)

- Riverpod
- Drift + SQLite
- `flutter_local_notifications`
- `flutter_tts`
- Possible backend/sync later

These are deferred by design and should only be introduced when explicitly requested.

## Persistent Agent Rules

- Preserve the calm, low-stress companion app principles.
- Never introduce punitive language, "game over", guilt, harsh streaks, or productivity-pressure patterns.
- Keep the flow simple: one task at a time, few choices, clear next step.
- Attempts matter, not only completed tasks.
- Keep adaptive logic separate from UI code.
- Do not add backend, database, authentication, notifications, or TTS unless explicitly requested.
- Prefer small, understandable architecture over premature abstraction.
- Document file-structure changes in `FILE_TREE.md`.
- Document project decisions and onboarding context in `PROJECT_DNA.md`.
- Document shortcuts, compromises, and deferred work in `TECH_DEBT.md`.
- Surface blockers and uncertainties in your report.
- Do not invent hidden requirements.
