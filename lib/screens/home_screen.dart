import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/confirmation_dialog.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import 'add_edit_flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _navigateToAddEditScreen(BuildContext context, {String? id}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditFlashcardScreen(flashcardId: id),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: 'Delete Flashcard',
        content: 'Are you sure you want to delete this flashcard? This action cannot be undone.',
        onConfirm: () {
          Provider.of<FlashcardProvider>(context, listen: false).deleteFlashcard(id);
          Navigator.of(ctx).pop();
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              final currentCard = provider.currentCard;
              if (currentCard == null) return const SizedBox.shrink();
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Flashcard',
                    onPressed: () => _navigateToAddEditScreen(context, id: currentCard.id),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    tooltip: 'Delete Flashcard',
                    onPressed: () => _showDeleteConfirmation(context, currentCard.id),
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.flashcards.isEmpty) {
            return EmptyStateWidget(
              message: 'No Flashcards Available',
              onAddPressed: () => _navigateToAddEditScreen(context),
            );
          }

          final currentCard = provider.currentCard!;
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Progress/Card number indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Card ${provider.currentIndex + 1} of ${provider.flashcards.length}',
                    style: AppStyles.subtitleStyle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // The Flashcard with animations
                Expanded(
                  child: Hero(
                    tag: 'flashcard_${currentCard.id}',
                    child: FlashcardWidget(
                      flashcard: currentCard,
                    ),
                  ),
                ),
                
                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Previous',
                          icon: Icons.arrow_back_ios_new,
                          isPrimary: false,
                          onPressed: provider.hasPrevious 
                              ? () => provider.previousCard() 
                              : () {}, // Handled visually by opacity if needed
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          text: 'Next',
                          // Only show trailing icon if we define it, else default leading is fine.
                          // Let's use a workaround for trailing icon by customizing the CustomButton if needed,
                          // but for now leading icon is okay.
                          isPrimary: true,
                          onPressed: provider.hasNext 
                              ? () => provider.nextCard() 
                              : () {}, // Let button style handle disabled state or just do nothing
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(context),
        tooltip: 'Add Flashcard',
        child: const Icon(Icons.add),
      ),
    );
  }
}
