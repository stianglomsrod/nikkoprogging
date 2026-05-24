class TaskItem {
  const TaskItem({
    required this.id,
    required this.focusAreaId,
    required this.title,
    required this.difficulty,
  });

  final String id;
  final String focusAreaId;
  final String title;
  final int difficulty;
}
