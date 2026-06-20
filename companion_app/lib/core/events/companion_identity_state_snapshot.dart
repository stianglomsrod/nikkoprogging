import 'package:companion_app/core/events/companion_identity.dart';

class CompanionIdentityStateSnapshot {
  const CompanionIdentityStateSnapshot({
    required this.companionName,
    required this.userName,
    required this.symbol,
    required this.backgroundTone,
  });

  final String? companionName;
  final String? userName;
  final CompanionSymbolOption symbol;
  final CompanionBackgroundTone backgroundTone;
}
