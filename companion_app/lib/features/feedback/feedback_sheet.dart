import 'dart:math';

import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:flutter/material.dart';

class FeedbackSheet extends StatefulWidget {
  const FeedbackSheet({
    super.key,
    required this.feedbackRepository,
    this.screenContext,
  });

  final FeedbackRepository feedbackRepository;
  final String? screenContext;

  static Future<bool> show({
    required BuildContext context,
    required FeedbackRepository feedbackRepository,
    String? screenContext,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FeedbackSheet(
        feedbackRepository: feedbackRepository,
        screenContext: screenContext,
      ),
    );

    return result ?? false;
  }

  @override
  State<FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<FeedbackSheet> {
  static const int _maxMessageLength = 1000;

  final TextEditingController _messageController = TextEditingController();
  final Random _random = Random();

  FeedbackType _selectedType = FeedbackType.general;
  bool _isSaving = false;
  String? _validationMessage;
  String? _errorMessage;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      setState(() {
        _validationMessage = 'Skriv litt om hva du vil dele.';
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _validationMessage = null;
      _errorMessage = null;
    });

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final id = 'fb_${nowMs}_${_random.nextInt(1 << 32)}';

    try {
      await widget.feedbackRepository.append(
        FeedbackItem(
          id: id,
          createdAtMs: nowMs,
          type: _selectedType,
          message: message,
          screenContext: widget.screenContext,
        ),
      );

      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
        _errorMessage =
            'Det gikk ikke denne gangen. Du kan gjerne prøve igjen.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Del tilbakemelding',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Takk for at du sier fra. Vi bruker dette til a gjore appen roligere og nyttigere.',
            ),
            const SizedBox(height: 16),
            Text('Type', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<FeedbackType>(
              segments: const [
                ButtonSegment<FeedbackType>(
                  value: FeedbackType.general,
                  label: Text('Generell'),
                ),
                ButtonSegment<FeedbackType>(
                  value: FeedbackType.bug,
                  label: Text('Feil'),
                ),
                ButtonSegment<FeedbackType>(
                  value: FeedbackType.suggestion,
                  label: Text('Forslag'),
                ),
              ],
              selected: <FeedbackType>{_selectedType},
              onSelectionChanged: (selection) {
                if (selection.isEmpty) {
                  return;
                }
                setState(() {
                  _selectedType = selection.first;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Melding', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextField(
              key: const ValueKey('feedback-message-input'),
              controller: _messageController,
              minLines: 4,
              maxLines: 8,
              maxLength: _maxMessageLength,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Skriv det du vil dele her.',
                errorText: _validationMessage,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_validationMessage == null && _errorMessage == null) {
                  return;
                }
                setState(() {
                  _validationMessage = null;
                  _errorMessage = null;
                });
              },
            ),
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  onPressed: _isSaving
                      ? null
                      : () => Navigator.of(context).pop(false),
                  child: const Text('Avbryt'),
                ),
                const Spacer(),
                FilledButton(
                  key: const ValueKey('feedback-send-button'),
                  onPressed: _isSaving ? null : _submit,
                  child: Text(_isSaving ? 'Sender...' : 'Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
