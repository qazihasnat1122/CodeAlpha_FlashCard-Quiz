import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../constants/app_styles.dart';
import '../constants/app_colors.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardWidget({Key? key, required this.flashcard}) : super(key: key);

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _showAnswer = false;

  @override
  void didUpdateWidget(covariant FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset to showing the question when the flashcard changes
    if (oldWidget.flashcard.id != widget.flashcard.id) {
      setState(() {
        _showAnswer = false;
      });
    }
  }

  void _toggleAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnswer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotateAnim = Tween(begin: 3.14159, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotateAnim,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(_showAnswer) != child!.key);
              var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              final value = isUnder ? min(rotateAnim.value, 3.14159 / 2) : rotateAnim.value;
              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        child: Card(
          key: ValueKey(_showAnswer),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          shadowColor: AppColors.primary.withOpacity(0.3),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: _showAnswer 
                  ? [AppColors.secondary.withOpacity(0.1), AppColors.surface]
                  : [AppColors.primary.withOpacity(0.05), AppColors.surface],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _showAnswer ? 'Answer' : 'Question',
                  style: AppStyles.subtitleStyle.copyWith(
                    color: _showAnswer ? AppColors.secondaryVariant : AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _showAnswer ? widget.flashcard.answer : widget.flashcard.question,
                  style: AppStyles.headingStyle.copyWith(
                    fontSize: _showAnswer ? 22 : 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                OutlinedButton.icon(
                  onPressed: _toggleAnswer,
                  icon: Icon(
                    _showAnswer ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    _showAnswer ? 'Hide Answer' : 'Show Answer',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double min(double a, double b) => a < b ? a : b;
