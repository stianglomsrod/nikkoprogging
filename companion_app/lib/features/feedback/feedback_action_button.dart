import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/features/feedback/feedback_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef FeedbackScreenshotCapture = Future<String?> Function();

class FeedbackActionButton extends StatelessWidget {
  const FeedbackActionButton({
    super.key,
    required this.feedbackRepository,
    this.captureKey,
    this.captureScreenshot,
    this.screenContext,
  });

  final FeedbackRepository feedbackRepository;
  final GlobalKey? captureKey;
  final FeedbackScreenshotCapture? captureScreenshot;
  final String? screenContext;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _openFeedback(context),
      icon: const Icon(Icons.feedback_outlined),
      tooltip: 'Tilbakemelding',
    );
  }

  Future<void> _openFeedback(BuildContext context) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);

    final screenshotPath = await _captureFeedbackScreenshot();
    if (!navigator.mounted) {
      return;
    }

    final didSubmit = await FeedbackSheet.show(
      context: navigator.context,
      feedbackRepository: feedbackRepository,
      screenContext: screenContext,
      screenshotPath: screenshotPath,
    );

    if (!navigator.mounted || !didSubmit) {
      return;
    }

    messenger?.showSnackBar(
      const SnackBar(content: Text('Takk. Tilbakemeldingen er lagret.')),
    );
  }

  Future<String?> _captureFeedbackScreenshot() async {
    final customCapture = captureScreenshot;
    if (customCapture != null) {
      return customCapture();
    }

    final key = captureKey;
    if (key == null) {
      return null;
    }

    try {
      await WidgetsBinding.instance.endOfFrame;
      var boundaryContext = key.currentContext;
      var boundary =
          boundaryContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundaryContext == null || boundary == null) {
        return null;
      }

      if (boundary.debugNeedsPaint) {
        await WidgetsBinding.instance.endOfFrame;
        boundaryContext = key.currentContext;
        boundary =
            boundaryContext?.findRenderObject() as RenderRepaintBoundary?;
        if (boundaryContext == null || boundary == null) {
          return null;
        }
      }

      final image = await boundary.toImage(
        pixelRatio: View.of(boundaryContext).devicePixelRatio,
      );
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (data == null) {
        return null;
      }

      return _writeScreenshot(data.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  Future<String?> _writeScreenshot(Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final screenshotDirectory = Directory(
      p.join(directory.path, 'feedback_screenshots'),
    );
    if (!await screenshotDirectory.exists()) {
      await screenshotDirectory.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File(
      p.join(screenshotDirectory.path, 'feedback_$timestamp.png'),
    );
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}
