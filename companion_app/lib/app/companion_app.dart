import 'package:companion_app/app/app_config.dart';
import 'package:companion_app/core/events/companion_event_state_repository.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:companion_app/core/events/companion_identity_repository.dart';
import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/features/feedback/feedback_action_button.dart';
import 'package:companion_app/core/history/history_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';
import 'package:companion_app/features/home/home_page.dart';
import 'package:flutter/material.dart';

class CompanionApp extends StatelessWidget {
  const CompanionApp({
    super.key,
    required this.appConfig,
    required this.historyRepository,
    required this.feedbackRepository,
    required this.companionEventStateRepository,
    required this.companionIdentityRepository,
    required this.focusAreaSettingsRepository,
    this.feedbackScreenshotCapture,
    this.initialCompanionEventState,
    this.initialCompanionIdentityState,
    this.initialFocusAreaSettingsState,
  });

  final AppConfig appConfig;
  final HistoryRepository historyRepository;
  final FeedbackRepository feedbackRepository;
  final CompanionEventStateRepository companionEventStateRepository;
  final CompanionIdentityRepository companionIdentityRepository;
  final FocusAreaSettingsRepository focusAreaSettingsRepository;
  final FeedbackScreenshotCapture? feedbackScreenshotCapture;
  final CompanionEventStateSnapshot? initialCompanionEventState;
  final CompanionIdentityStateSnapshot? initialCompanionIdentityState;
  final FocusAreaSettingsStateSnapshot? initialFocusAreaSettingsState;

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF060B15);
    const surface = Color(0xFF0E1728);
    const seed = Color(0xFF6D88B8);

    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
      surface: surface,
    );

    return MaterialApp(
      title: 'Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: background,
        cardTheme: const CardThemeData(
          color: surface,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: background,
          surfaceTintColor: background,
          elevation: 0,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: scheme.primary.withValues(alpha: 0.9),
            foregroundColor: scheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide(
              color: scheme.outlineVariant.withValues(alpha: 0.85),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
      home: HomePage(
        appConfig: appConfig,
        historyRepository: historyRepository,
        feedbackRepository: feedbackRepository,
        feedbackScreenshotCapture: feedbackScreenshotCapture,
        companionEventStateRepository: companionEventStateRepository,
        initialCompanionEventState: initialCompanionEventState,
        companionIdentityRepository: companionIdentityRepository,
        initialCompanionIdentityState: initialCompanionIdentityState,
        focusAreaSettingsRepository: focusAreaSettingsRepository,
        initialFocusAreaSettingsState: initialFocusAreaSettingsState,
      ),
    );
  }
}
