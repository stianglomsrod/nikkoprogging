enum CompanionEventKind {
  companionName,
  userName,
  sleepSound,
  backgroundMusic,
  symbol,
  backgroundColor,
}

class CompanionEvent {
  const CompanionEvent({
    required this.id,
    required this.kind,
    required this.threshold,
  });

  final String id;
  final CompanionEventKind kind;
  final int threshold;
}
