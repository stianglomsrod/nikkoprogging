enum FeedbackType { general, bug, suggestion }

class FeedbackItem {
  const FeedbackItem({
    required this.id,
    required this.createdAtMs,
    required this.type,
    required this.message,
    this.appVersion,
    this.screenContext,
    this.screenshotPath,
  });

  final String id;
  final int createdAtMs;
  final FeedbackType type;
  final String message;
  final String? appVersion;
  final String? screenContext;
  final String? screenshotPath;
}
