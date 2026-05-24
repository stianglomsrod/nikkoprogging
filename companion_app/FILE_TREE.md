# FILE_TREE

Current high-signal project structure (generated build/cache outputs omitted):

```text
companion_app/
|- analysis_options.yaml
|- pubspec.yaml
|- pubspec.lock
|- README.md
|- PROJECT_DNA.md
|- FILE_TREE.md
|- TECH_DEBT.md
|- lib/
|  |- main.dart
|  |- app/
|  |  |- companion_app.dart
|  |- core/
|  |  |- content/
|  |  |  |- companion_text_library.dart
|  |  |- models/
|  |  |  |- attempt_entry.dart
|  |  |  |- focus_area.dart
|  |  |  |- modus.dart
|  |  |  |- sinnsstemning.dart
|  |  |  |- task_item.dart
|  |  |- scheduler/
|  |  |  |- scheduler_engine.dart
|  |  |- adaptive_engine/
|  |  |  |- task_selector.dart
|  |  |- seed_data/
|  |  |  |- seed_data.dart
|  |  |  |- task_library.dart
|  |- features/
|     |- home/
|        |- home_page.dart
|        |- settings_page.dart
|        |- widgets/
|           |- companion_figure.dart
|- test/
|  |- widget_test.dart
|  |- core/
|  |  |- scheduler/
|  |  |  |- scheduler_engine_test.dart
|  |  |- adaptive_engine/
|  |     |- task_selector_test.dart
|- android/
|  |- app/
|  |  |- build.gradle.kts
|  |  |- src/
|  |     |- main/
|  |     |  |- AndroidManifest.xml
|  |     |  |- kotlin/com/example/companion_app/MainActivity.kt
|  |     |- debug/AndroidManifest.xml
|  |     |- profile/AndroidManifest.xml
|  |- build.gradle.kts
|  |- settings.gradle.kts
|  |- gradle.properties
|  |- gradlew
|  |- gradlew.bat
|  |- gradle/wrapper/gradle-wrapper.properties
|- ios/
|  |- Runner/
|  |  |- AppDelegate.swift
|  |  |- SceneDelegate.swift
|  |  |- Info.plist
|  |  |- Base.lproj/
|  |- Runner.xcodeproj/
|  |- Runner.xcworkspace/
|  |- Flutter/
|- web/
|  |- index.html
|  |- manifest.json
|  |- icons/
|- linux/
|  |- CMakeLists.txt
|  |- runner/
|  |- flutter/
|- macos/
|  |- Runner/
|  |- Runner.xcodeproj/
|  |- Runner.xcworkspace/
|  |- Flutter/
|- windows/
|  |- CMakeLists.txt
|  |- runner/
|  |- flutter/
```

Notes:

- `build/`, `.dart_tool/`, IDE cache folders, and other generated outputs are intentionally excluded.
- This file should be updated whenever the meaningful source structure changes.
