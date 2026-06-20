import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:flutter/material.dart';

class FeedbackHistoryDetailScreen extends StatelessWidget {
  const FeedbackHistoryDetailScreen({super.key, required this.item});

  final FeedbackItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tilbakemelding')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _MetaRow(label: 'Tid', value: _formatTimestamp(item.createdAtMs)),
          const SizedBox(height: 12),
          _MetaRow(label: 'Type', value: _typeLabel(item.type)),
          if (item.screenContext != null && item.screenContext!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _MetaRow(
              label: 'Skjerm',
              value: _screenContextLabel(item.screenContext!),
            ),
          ],
          const SizedBox(height: 20),
          Text(
            'Melding',
            key: const ValueKey('feedback-detail-message-title'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SelectableText(
            item.message,
            key: const ValueKey('feedback-detail-message-body'),
          ),
        ],
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

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(value)),
      ],
    );
  }
}
