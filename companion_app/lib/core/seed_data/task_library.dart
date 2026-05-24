import 'package:companion_app/core/content/companion_text_library.dart';
import 'package:companion_app/core/models/task_item.dart';

class TaskLibrary {
  static List<TaskItem> householdTasks() {
    return [
      ..._buildTasks(
        titles: CompanionTextLibrary.negativeTasks,
        difficulty: 1,
        prefix: 'household_easy',
      ),
      ..._buildTasks(
        titles: CompanionTextLibrary.okTasks,
        difficulty: 2,
        prefix: 'household_ok',
      ),
      ..._buildTasks(
        titles: CompanionTextLibrary.energiskTasks,
        difficulty: 3,
        prefix: 'household_energisk',
      ),
    ];
  }

  static List<TaskItem> _buildTasks({
    required List<String> titles,
    required int difficulty,
    required String prefix,
  }) {
    return [
      for (int index = 0; index < titles.length; index++)
        TaskItem(
          id: '${prefix}_$index',
          focusAreaId: 'household',
          title: _capitalize(titles[index]),
          difficulty: difficulty,
        ),
    ];
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    return '${value[0].toUpperCase()}${value.substring(1)}.';
  }
}
