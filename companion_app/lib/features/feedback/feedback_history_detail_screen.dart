import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:flutter/material.dart';

class FeedbackHistoryDetailScreen extends StatelessWidget {
  const FeedbackHistoryDetailScreen({super.key, required this.item});

  final FeedbackItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tilbakemelding')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            _metaLine(),
            key: const ValueKey('feedback-detail-meta-line'),
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'Melding',
            key: const ValueKey('feedback-detail-message-title'),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          DecoratedBox(
            key: const ValueKey('feedback-detail-message-card'),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SelectableText(
                item.message,
                key: const ValueKey('feedback-detail-message-body'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _metaLine() {
    final pieces = <String>[_typeLabel(item.type)];
    if (item.screenContext != null && item.screenContext!.isNotEmpty) {
      pieces.add('Fra: ${_screenContextLabel(item.screenContext!)}');
    }
    pieces.add(_formatTimestamp(item.createdAtMs));
    return pieces.join(' · ');
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

  String _screenContextLabel(String raw) {
    switch (raw) {
      case 'home':
        return 'Hjem';
      default:
        return raw;
    }
  }

  String _formatTimestamp(int timestampMs) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day.$month.$year kl. $hour:$minute';
  }
}
