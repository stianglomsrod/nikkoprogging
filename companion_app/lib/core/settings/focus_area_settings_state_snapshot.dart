import 'package:companion_app/core/models/modus.dart';

class FocusAreaSettingsStateSnapshot {
  const FocusAreaSettingsStateSnapshot({
    required this.areas,
    this.selectedAreaId,
  });

  final List<FocusAreaSettingState> areas;
  final String? selectedAreaId;
}

class FocusAreaSettingState {
  const FocusAreaSettingState({
    required this.id,
    required this.enabled,
    required this.startHour,
    required this.endHour,
    required this.modus,
  });

  final String id;
  final bool enabled;
  final int startHour;
  final int endHour;
  final Modus modus;
}
