# companion_app

A calm, low-stress companion/reminder app prototype built with Flutter.

## Project Docs (Read First)

- `PROJECT_DNA.md`: product model, architecture direction, and persistent agent rules.
- `FILE_TREE.md`: high-signal project structure snapshot.
- `DB_NOTES.md`: persistence direction and database planning notes.
- `TECH_DEBT.md`: intentional shortcuts, deferred work, and future resolution notes.
- `docs/epics/`: roadmap epics for planned features not yet implemented.

## Current Phase

Early prototype / flow-validation.

- Focus is on validating scheduler-oriented product flow and adaptive task behavior.
- Hardcoded/local seed data is intentional for now.
- No database/backend/auth/notifications/TTS yet.

## Agent Reporting Rule

When creating, changing, moving, or deleting files, always report full relative paths from project root (not bare filenames).
Examples: `lib/features/home/home_page.dart`, `lib/features/home/settings_page.dart`, `test/core/scheduler/scheduler_engine_test.dart`.

## Flutter Starter Resources

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
