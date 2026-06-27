import '../models/flashcard.dart';

class FlashcardService {
  // Simulating a database or API response with 5 sample flashcards
  final List<Flashcard> _initialFlashcards = [
    const Flashcard(
      id: '1',
      question: 'What is Flutter?',
      answer: 'Flutter is an open-source UI software development kit created by Google.',
    ),
    const Flashcard(
      id: '2',
      question: 'What programming language does Flutter use?',
      answer: 'Dart',
    ),
    const Flashcard(
      id: '3',
      question: 'What is a Widget in Flutter?',
      answer: 'A widget is an immutable description of part of a user interface.',
    ),
    const Flashcard(
      id: '4',
      question: 'What is Clean Architecture?',
      answer: 'A software design philosophy that separates the elements of a design into ring levels to provide a high level of decoupling.',
    ),
    const Flashcard(
      id: '5',
      question: 'What is Provider?',
      answer: 'A wrapper around InheritedWidget to make state management easier and more reusable.',
    ),
  ];

  Future<List<Flashcard>> fetchFlashcards() async {
    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_initialFlashcards);
  }
}
