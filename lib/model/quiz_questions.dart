import 'dart:core';

class QuizQuestions {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestions(
      {required this.question,
      required this.options,
      required this.correctAnswer});
}
