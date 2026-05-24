import 'package:companion_app/core/models/modus.dart';

class FocusArea {
  FocusArea({
    required this.id,
    required this.name,
    required this.enabled,
    required this.startHour,
    required this.endHour,
    required this.modus,
  });

  final String id;
  final String name;
  final bool enabled;
  final int startHour;
  final int endHour;
  final Modus modus;

  bool isActiveAtHour(int hour) {
    if (startHour <= endHour) {
      return hour >= startHour && hour < endHour;
    }
    return hour >= startHour || hour < endHour;
  }

  FocusArea copyWith({
    bool? enabled,
    int? startHour,
    int? endHour,
    Modus? modus,
  }) {
    return FocusArea(
      id: id,
      name: name,
      enabled: enabled ?? this.enabled,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      modus: modus ?? this.modus,
    );
  }
}
