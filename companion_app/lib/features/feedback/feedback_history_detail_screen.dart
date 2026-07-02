import 'dart:io';

import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/features/feedback/feedback_action_button.dart';
import 'package:flutter/material.dart';

class FeedbackHistoryDetailScreen extends StatelessWidget {
  const FeedbackHistoryDetailScreen({
    super.key,
    required this.item,
    required this.feedbackRepository,
  });

  final FeedbackItem item;
  final FeedbackRepository feedbackRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feedbackCaptureKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilbakemelding'),
        actions: [
          FeedbackActionButton(
            feedbackRepository: feedbackRepository,
            captureKey: feedbackCaptureKey,
            screenContext: 'feedback_detail',
          ),
        ],
      ),
      body: RepaintBoundary(
        key: feedbackCaptureKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              _metaLine(),
              key: const ValueKey('feedback-detail-meta-line'),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Skjermbilde',
              key: const ValueKey('feedback-detail-screenshot-title'),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            _ScreenshotAttachment(item: item),
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

class _ScreenshotAttachment extends StatelessWidget {
  const _ScreenshotAttachment({required this.item});

  final FeedbackItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenshotPath = item.screenshotPath;

    if (screenshotPath == null || screenshotPath.isEmpty) {
      return const _ScreenshotFallback(
        message:
            'Ingen skjermbildevedlegg ble lagret for denne tilbakemeldingen.',
      );
    }

    final screenshotFile = File(screenshotPath);
    if (!screenshotFile.existsSync()) {
      return const _ScreenshotFallback(
        message:
            'Skjermbildet er ikke tilgjengelig lenger, men teksten er fortsatt lagret her.',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: DecoratedBox(
        decoration: BoxDecoration(color: theme.cardColor),
        child: Image.file(
          screenshotFile,
          key: const ValueKey('feedback-detail-screenshot-image'),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const _ScreenshotFallback(
              message:
                  'Skjermbildet er ikke tilgjengelig lenger, men teksten er fortsatt lagret her.',
            );
          },
        ),
      ),
    );
  }
}

class _ScreenshotFallback extends StatelessWidget {
  const _ScreenshotFallback({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      key: const ValueKey('feedback-detail-screenshot-fallback'),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(padding: const EdgeInsets.all(14), child: Text(message)),
    );
  }
}
