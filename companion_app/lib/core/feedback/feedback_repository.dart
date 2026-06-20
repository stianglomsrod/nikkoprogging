import 'package:companion_app/core/feedback/feedback_item.dart';

abstract class FeedbackRepository {
  Future<void> append(FeedbackItem item);

  Future<List<FeedbackItem>> readAll();

  Future<FeedbackItem?> readById(String id);
}
