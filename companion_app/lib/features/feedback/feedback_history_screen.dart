import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/features/feedback/feedback_history_detail_screen.dart';
import 'package:flutter/material.dart';

class FeedbackHistoryScreen extends StatelessWidget {
  const FeedbackHistoryScreen({super.key, required this.feedbackRepository});

  final FeedbackRepository feedbackRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tilbakemeldinger')),
      body: FutureBuilder<List<FeedbackItem>>(
        future: feedbackRepository.readAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? const <FeedbackItem>[];
          if (items.isEmpty) {
            return const _FeedbackHistoryEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  key: ValueKey('feedback-history-item-${item.id}'),
                  title: Text(_typeLabel(item.type)),
                  subtitle: Text(
                    item.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(_formatShortDate(item.createdAtMs)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => FeedbackHistoryDetailScreen(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _typeLabel(FeedbackType type) {
    switch (type) {
      case FeedbackType.general:
        return 'Generell';
      case FeedbackType.bug:
        return 'Feil';
      case FeedbackType.suggestion:
        return 'Forslag';
    }
  }

  String _formatShortDate(int timestampMs) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day.$month $hour:$minute';
  }
}

class _FeedbackHistoryEmptyState extends StatelessWidget {
  const _FeedbackHistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Ingen tilbakemeldinger enda', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text(
              'Nar du sender innspill, dukker de opp her.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
