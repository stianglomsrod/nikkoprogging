class CompanionEventStateSnapshot {
  const CompanionEventStateSnapshot({
    required this.completedTaskCount,
    required this.autoTriggeredEventIds,
    required this.handledEventIds,
    required this.skippedEventIds,
    required this.pendingEventId,
  });

  final int completedTaskCount;
  final Set<String> autoTriggeredEventIds;
  final Set<String> handledEventIds;
  final Set<String> skippedEventIds;
  final String? pendingEventId;
}
