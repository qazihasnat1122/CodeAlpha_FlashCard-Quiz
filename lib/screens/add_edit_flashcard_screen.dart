import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final String? flashcardId; // Null implies 'Add', non-null implies 'Edit'

  const AddEditFlashcardScreen({Key? key, this.flashcardId}) : super(key: key);

  @override
  State<AddEditFlashcardScreen> createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  bool get isEditing => widget.flashcardId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      // Pre-fill the data for editing
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<FlashcardProvider>(context, listen: false);
        final card = provider.flashcards.firstWhere((c) => c.id == widget.flashcardId);
        _questionController.text = card.question;
        _answerController.text = card.answer;
      });
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<FlashcardProvider>(context, listen: false);
      final question = _questionController.text.trim();
      final answer = _answerController.text.trim();

      if (isEditing) {
        provider.updateFlashcard(widget.flashcardId!, question, answer);
      } else {
        provider.addFlashcard(question, answer);
      }

      Navigator.pop(context); // Return to Home Screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Flashcard' : 'Add Flashcard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _questionController,
                  label: 'Question',
                  hint: 'Enter the question here...',
                  maxLines: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Question cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _answerController,
                  label: 'Answer',
                  hint: 'Enter the answer here...',
                  maxLines: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Answer cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Cancel',
                        isPrimary: false,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: 'Save',
                        isPrimary: true,
                        onPressed: _saveFlashcard,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
