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
        name: 'Studier og læring',
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
        name: 'Påminnelser',
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
      ...TaskLibrary.studyTasks(),
      ...TaskLibrary.exerciseTasks(),
      ...TaskLibrary.reminderTasks(),
    ];
  }
}
