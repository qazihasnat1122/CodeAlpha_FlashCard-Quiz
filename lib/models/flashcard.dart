class Flashcard {
  final String id;
  final String question;
  final String answer;

  const Flashcard({
    required this.id,
    required this.question,
    required this.answer,
  });

  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
