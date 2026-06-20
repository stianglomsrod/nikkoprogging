enum AppMode { development, tester }

class AppConfig {
  const AppConfig({
    required this.mode,
    required this.showPrototypeControls,
    required this.showPrototypeTimeControls,
  });

  final AppMode mode;
  final bool showPrototypeControls;
  final bool showPrototypeTimeControls;

  static const AppConfig development = AppConfig(
    mode: AppMode.development,
    showPrototypeControls: true,
    showPrototypeTimeControls: true,
  );

  static const AppConfig tester = AppConfig(
    mode: AppMode.tester,
    showPrototypeControls: false,
    showPrototypeTimeControls: false,
  );

  static AppConfig fromEnvironment(String rawValue) {
    final normalized = rawValue.trim().toLowerCase();
    if (normalized == 'tester') {
      return tester;
    }
    return development;
  }
}
