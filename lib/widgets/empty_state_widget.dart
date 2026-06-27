import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onAddPressed;

  const EmptyStateWidget({
    Key? key,
    required this.message,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.style_outlined,
              size: 120,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: AppStyles.titleStyle.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
              label: const Text('Add Flashcard'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
