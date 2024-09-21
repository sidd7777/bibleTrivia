import 'package:bible_trivia/widgets/quiz_option.dart';
import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../../../main.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../model/quiz_questions.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String nextQuestionButtonText = "Next Question";
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  int score = 0;
  bool showConfirmButton = true; // New variable to control button visibility

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
      question:
          "How many days and nights did it rain when Noah was on the ark?",
      options: ["10", "20", "40", "50"],
      correctAnswer: "40",
    ),
  ];

  void checkAnswer(String answer) {
    setState(() {
      selectedOption = answer;
      isAnswered = true;
      showConfirmButton = false; // Hide button after selection
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        resetQuestionState();
        showConfirmButton = true; // Show button for the next question
      } else {
        nextQuestionButtonText = "End Quiz"; // Change button text
      }
    });
  }

  void resetQuestionState() {
    selectedOption = null; // Reset selected option
    isAnswered = false; // Reset answered status
    nextQuestionButtonText = "Next Question";
  }

  void handleQuiz() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Quiz Completed. Your Score is $score")),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(
          title: AppTheme.appBarTitleText,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> exitQuiz() async {
    if (!mounted) return;

    final exit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTheme.exitQuizText),
        content: const Text(AppTheme.confirmationExitQuiz),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppTheme.cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppTheme.exitText),
          ),
        ],
      ),
    );

    if (mounted && exit == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: AppTheme.appBarTitleText,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        appBar: CustomAppBar(
          title: AppTheme.appBarTitleText,
          showDrawer: false,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTheme.appBarTitleText,
        showDrawer: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current User Score: $score',
                    style: InheritedAppTheme.scoreTextStyle,
                  ),
                  const SizedBox(height: AppTheme.spaceSizeMedium),
                  Text(
                    currentQuestion.question,
                    style: InheritedAppTheme.questionTextStyle,
                  ),
                  const SizedBox(height: AppTheme.spaceSizeMedium),
                  ...currentQuestion.options.map((option) {
                    return QuizOption(
                      option: option,
                      selectedOption: selectedOption,
                      isAnswered: isAnswered,
                      correctAnswer: currentQuestion.correctAnswer,
                      onSelect: (selected) {
                        setState(() {
                          selectedOption = selected;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
            if (showConfirmButton)
              CustomElevatedButton(
                buttonText: AppTheme.confirmSelectionText,
                onPressed: (isAnswered || selectedOption == null)
                    ? () {}
                    : () {
                        checkAnswer(selectedOption!);
                      },
                backgroundColor: (isAnswered || selectedOption == null)
                    ? Colors.grey
                    : AppTheme.buttonBackgroundColor,
              ),
            const SizedBox(height: AppTheme.spaceSizeMedium),
            if (isAnswered)
              CustomElevatedButton(
                buttonText:
                    isLastQuestion ? "End Quiz" : nextQuestionButtonText,
                onPressed: isLastQuestion ? handleQuiz : nextQuestion,
              ),
            if (!isLastQuestion)
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomElevatedButton(
                  buttonText: AppTheme.exitQuizText,
                  onPressed: exitQuiz,
                  textColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
