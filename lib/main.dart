import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_styles.dart';
import 'providers/flashcard_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
      ],
      child: const FlashcardQuizApp(),
    ),
  );
}

class FlashcardQuizApp extends StatelessWidget {
  const FlashcardQuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      theme: AppStyles.appTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
