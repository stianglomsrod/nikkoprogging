import 'package:companion_app/core/seed_data/task_library.dart';
import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/core/models/task_item.dart';

class SeedData {
  static List<FocusArea> focusAreas() {
    return [
      FocusArea(
        id: 'household',
        name: 'Huslige oppgaver',
        enabled: true,
        startHour: 16,
        endHour: 21,
        modus: Modus.stabil,
      ),
      FocusArea(
        id: 'study',
        name: 'Studier og laering',
        enabled: true,
        startHour: 18,
        endHour: 20,
        modus: Modus.avslappet,
      ),
      FocusArea(
        id: 'exercise',
        name: 'Trening',
        enabled: true,
        startHour: 15,
        endHour: 19,
        modus: Modus.sporty,
      ),
      FocusArea(
        id: 'reminders',
        name: 'Paaminnelser',
        enabled: true,
        startHour: 8,
        endHour: 22,
        modus: Modus.avslappet,
      ),
    ];
  }

  static List<TaskItem> tasks() {
    return [
      ...TaskLibrary.householdTasks(),
      const TaskItem(
        id: 's1',
        focusAreaId: 'study',
        title: 'Les en kort side med notater.',
        difficulty: 1,
      ),
      TaskItem(
        id: 's2',
        focusAreaId: 'study',
        title: 'Repeter et begrep i fem minutter.',
        difficulty: 1,
      ),
      TaskItem(
        id: 's3',
        focusAreaId: 'study',
        title: 'Los to oppgaver fra et tema.',
        difficulty: 2,
      ),
      TaskItem(
        id: 's4',
        focusAreaId: 'study',
        title: 'Jobb fokusert i femten minutter.',
        difficulty: 3,
      ),
      TaskItem(
        id: 'e1',
        focusAreaId: 'exercise',
        title: 'Ta en rolig ett-minutts strekkpause.',
        difficulty: 1,
      ),
      TaskItem(
        id: 'e2',
        focusAreaId: 'exercise',
        title: 'Ga en kort tur i fem minutter.',
        difficulty: 1,
      ),
      TaskItem(
        id: 'e3',
        focusAreaId: 'exercise',
        title: 'Gjor en enkel ovelse i ti minutter.',
        difficulty: 2,
      ),
      TaskItem(
        id: 'e4',
        focusAreaId: 'exercise',
        title: 'Kjor en sporty oekt med intervaller.',
        difficulty: 3,
      ),
      TaskItem(
        id: 'r1',
        focusAreaId: 'reminders',
        title: 'Drikk et glass vann.',
        difficulty: 1,
      ),
      TaskItem(
        id: 'r2',
        focusAreaId: 'reminders',
        title: 'Send en kort beskjed du har utsatt.',
        difficulty: 2,
      ),
      TaskItem(
        id: 'r3',
        focusAreaId: 'reminders',
        title: 'Planlegg en viktig avtale for i morgen.',
        difficulty: 3,
      ),
    ];
  }
}
