enum AppMode { development, tester }

class AppConfig {
  const AppConfig({
    required this.mode,
    required this.showPrototypeControls,
    required this.showPrototypeTimeControls,
    required this.autoPromptWhenIdle,
    this.currentHourOverride,
  });

  final AppMode mode;
  final bool showPrototypeControls;
  final bool showPrototypeTimeControls;
  final bool autoPromptWhenIdle;
  final int? currentHourOverride;

  static const AppConfig development = AppConfig(
    mode: AppMode.development,
    showPrototypeControls: true,
    showPrototypeTimeControls: true,
    autoPromptWhenIdle: false,
  );

  static const AppConfig tester = AppConfig(
    mode: AppMode.tester,
    showPrototypeControls: false,
    showPrototypeTimeControls: false,
    autoPromptWhenIdle: true,
  );

  AppConfig copyWith({
    AppMode? mode,
    bool? showPrototypeControls,
    bool? showPrototypeTimeControls,
    bool? autoPromptWhenIdle,
    int? currentHourOverride,
  }) {
    return AppConfig(
      mode: mode ?? this.mode,
      showPrototypeControls:
          showPrototypeControls ?? this.showPrototypeControls,
      showPrototypeTimeControls:
          showPrototypeTimeControls ?? this.showPrototypeTimeControls,
      autoPromptWhenIdle: autoPromptWhenIdle ?? this.autoPromptWhenIdle,
      currentHourOverride: currentHourOverride ?? this.currentHourOverride,
    );
  }

  static AppConfig fromEnvironment(String rawValue) {
    final normalized = rawValue.trim().toLowerCase();
    if (normalized == 'tester') {
      return tester;
    }
    return development;
  }
}
