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
|- DB_NOTES.md
|- TECH_DEBT.md
|- docs/
|  |- epics/
|  |  |- EPIC_COMPANION_EVENTS.md
|  |  |- EPIC_HISTORY_AND_STATS.md
|  |  |- EPIC_GLOBAL_FEEDBACK.md
|  |- plans/
|  |  |- PLAN_COMPANION_EVENTS.md
|  |  |- PLAN_HISTORY_AND_STATS.md
|- assets/
|  |- animations/
|  |  |- companion/
|  |  |  |- idle/
|  |  |  |  |- frame_01.png
|  |  |  |  |- frame_02.png
|  |  |  |  |- frame_03.png
|  |  |  |  |- frame_04.png
|  |  |  |  |- frame_05.png
|  |  |  |  |- frame_06.png
|  |  |  |- happy/
|  |  |  |  |- frame_01.png
|  |  |  |  |- frame_02.png
|  |  |  |  |- frame_03.png
|  |  |  |  |- frame_04.png
|  |  |  |  |- frame_05.png
|  |  |  |  |- frame_06.png
|  |  |  |- sleep/
|  |  |     |- frame_01.png
|  |  |     |- frame_02.png
|  |  |     |- frame_03.png
|  |  |     |- frame_04.png
|  |  |     |- frame_05.png
|  |- figures/
|  |  |- companion_figur.png
|- lib/
|  |- main.dart
|  |- app/
|  |  |- companion_app.dart
|  |- core/
|  |  |- content/
|  |  |  |- companion_text_library.dart
|  |  |- flow/
|  |  |  |- energisk_chain_controller.dart
|  |  |- history/
|  |  |  |- day_history_summary.dart
|  |  |  |- history_aggregator.dart
|  |  |  |- history_entry.dart
|  |  |  |- history_repository.dart
|  |  |  |- in_memory_history_repository.dart
|  |  |- events/
|  |  |  |- companion_event.dart
|  |  |  |- companion_event_controller.dart
|  |  |  |- companion_event_definitions.dart
|  |  |  |- companion_identity.dart
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
|           |- active_time_range_control.dart
|           |- background_color_event_view.dart
|           |- background_tone_settings_panel.dart
|           |- bottom_action_area.dart
|           |- companion_figure.dart
|           |- companion_name_event_view.dart
|           |- companion_name_settings_panel.dart
|           |- dialogue_box.dart
|           |- focus_area_circle_button.dart
|           |- focus_area_circle_selector.dart
|           |- focus_area_settings_panel.dart
|           |- home_layout_shell.dart
|           |- idle_state_view.dart
|           |- mood_state_view.dart
|           |- modus_selector.dart
|           |- prototype_time_panel.dart
|           |- result_state_view.dart
|           |- task_state_view.dart
|           |- symbol_event_view.dart
|           |- symbol_settings_panel.dart
|           |- user_name_event_view.dart
|           |- user_name_settings_panel.dart
|- test/
|  |- widget_test.dart
|  |- core/
|  |  |- flow/
|  |  |  |- energisk_chain_controller_test.dart
|  |  |- events/
|  |  |  |- companion_event_controller_test.dart
|  |  |- history/
|  |  |  |- history_aggregator_test.dart
|  |  |  |- in_memory_history_repository_test.dart
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
|- tools/
|  |- asset_processing/
|  |  |- split_companion_animation_sheet.py
```

Notes:

- `build/`, `.dart_tool/`, IDE cache folders, and other generated outputs are intentionally excluded.
- This file should be updated whenever the meaningful source structure changes.
