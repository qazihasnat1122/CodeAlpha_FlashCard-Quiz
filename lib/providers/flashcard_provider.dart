import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/flashcard_service.dart';

class FlashcardProvider extends ChangeNotifier {
  final FlashcardService _service = FlashcardService();

  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  List<Flashcard> get flashcards => _flashcards;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  
  Flashcard? get currentCard {
    if (_flashcards.isEmpty) return null;
    return _flashcards[_currentIndex];
  }

  bool get hasPrevious => _currentIndex > 0;
  bool get hasNext => _currentIndex < _flashcards.length - 1;

  FlashcardProvider() {
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    _isLoading = true;
    notifyListeners();

    _flashcards = await _service.fetchFlashcards();
    _currentIndex = 0;
    
    _isLoading = false;
    notifyListeners();
  }

  void nextCard() {
    if (hasNext) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousCard() {
    if (hasPrevious) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void addFlashcard(String question, String answer) {
    final newCard = Flashcard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: question,
      answer: answer,
    );
    _flashcards.add(newCard);
    
    // Automatically navigate to the newly added card (which is at the end of the list)
    _currentIndex = _flashcards.length - 1;
    notifyListeners();
  }

  void updateFlashcard(String id, String question, String answer) {
    final index = _flashcards.indexWhere((card) => card.id == id);
    if (index != -1) {
      _flashcards[index] = _flashcards[index].copyWith(
        question: question,
        answer: answer,
      );
      notifyListeners();
    }
  }

  void deleteFlashcard(String id) {
    final index = _flashcards.indexWhere((card) => card.id == id);
    if (index != -1) {
      _flashcards.removeAt(index);
      
      // Adjust currentIndex if necessary after deletion
      if (_flashcards.isEmpty) {
        _currentIndex = 0;
      } else if (_currentIndex >= _flashcards.length) {
        _currentIndex = _flashcards.length - 1;
      }
      notifyListeners();
    }
  }
}
