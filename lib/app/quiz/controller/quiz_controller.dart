import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../homepage/pages/home_page.dart';
import '../../model/quiz_questions.dart';

class QuizController extends ChangeNotifier {
  final List<QuizQuestions> questions = [
    QuizQuestions(
      question: "What is the first book of the Bible?",
      options: ["Genesis", "Exodus", "Leviticus", "Numbers"],
      correctAnswer: "Genesis",
    ),
    QuizQuestions(
      question: "Who was the king of Israel who built the temple in Jerusalem?",
      options: ["David", "Solomon", "Saul", "Hezekiah"],
      correctAnswer: "Solomon",
    ),
    QuizQuestions(
      question: "How many disciples did Jesus have?",
      options: ["7", "10", "12", "14"],
      correctAnswer: "12",
    ),
    QuizQuestions(
      question: "Which of these is NOT a disciple of Jesus?",
      options: ["Peter", "James", "Paul", "John"],
      correctAnswer: "Paul",
    ),
    QuizQuestions(
      question: "How many days and nights did it rain when Noah was on the ark?",
      options: ["10", "20", "40", "50"],
      correctAnswer: "40",
    ),
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  int score = 0;
  String nextQuestionButtonText = AppTheme.nextQuestionText;

  void checkAnswer(String answer) {
    if (answer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }
    isAnswered = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      resetQuestionState();
      notifyListeners();
    } else {
      nextQuestionButtonText = AppTheme.endQuizText;
    }
  }

  void resetQuestionState() {
    selectedOption = null;
    isAnswered = false;
    nextQuestionButtonText = AppTheme.nextQuestionText;
    notifyListeners();
  }

  void selectOption(String option) {
    selectedOption = option;
    notifyListeners();
  }

  bool isLastQuestion() {
    return currentQuestionIndex == questions.length - 1;
  }

  void handleQuizCompletion(BuildContext context, QuizController quizController) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${AppTheme.quizCompletedText} ${AppTheme.userScoreText} ${quizController.score}",
          textAlign: TextAlign.center,
        ),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(
          title: AppTheme.appBarTitleText,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
