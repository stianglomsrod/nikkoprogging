import 'package:companion_app/core/events/companion_event.dart';

class CompanionEventDefinitions {
  static const companionNameId = 'event_companion_name';
  static const userNameId = 'event_user_name';
  static const sleepSoundId = 'event_sleep_sound';
  static const backgroundMusicId = 'event_background_music';
  static const symbolId = 'event_symbol';
  static const backgroundColorId = 'event_background_color';

  static const deferredAudioEventIds = <String>{backgroundMusicId};

  static const orderedUnlocks = <CompanionEvent>[
    CompanionEvent(
      id: companionNameId,
      kind: CompanionEventKind.companionName,
      threshold: 3,
    ),
    CompanionEvent(
      id: userNameId,
      kind: CompanionEventKind.userName,
      threshold: 6,
    ),
    CompanionEvent(
      id: sleepSoundId,
      kind: CompanionEventKind.sleepSound,
      threshold: 9,
    ),
    CompanionEvent(
      id: backgroundMusicId,
      kind: CompanionEventKind.backgroundMusic,
      threshold: 12,
    ),
    CompanionEvent(
      id: symbolId,
      kind: CompanionEventKind.symbol,
      threshold: 15,
    ),
    CompanionEvent(
      id: backgroundColorId,
      kind: CompanionEventKind.backgroundColor,
      threshold: 18,
    ),
  ];

  static bool isDeferredAudioEvent(String eventId) {
    return deferredAudioEventIds.contains(eventId);
  }
}
