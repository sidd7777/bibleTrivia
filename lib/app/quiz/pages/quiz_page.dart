import 'package:bible_trivia/app/homepage/pages/home_page.dart';
import 'package:bible_trivia/widgets/progress_bar.dart'; // Import your ProgressBar widget
import 'package:bible_trivia/widgets/quiz_option.dart';
import 'package:flutter/material.dart';

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../model/quiz_questions.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  String nextQuestionButtonText = AppTheme.nextQuestionText;
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  int score = 0;
  bool showConfirmButton = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Start the slide-in animation for the first question automatically
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedOption = answer;
      isAnswered = true;
      showConfirmButton = false;
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      // Fade out the current question
      _animationController.reverse().then((_) {
        setState(() {
          currentQuestionIndex++;
          resetQuestionState();
          showConfirmButton = true;
        });

        // Slide the next question in
        _animationController.forward();
      });
    } else {
      nextQuestionButtonText = AppTheme.endQuizText;
    }
  }

  void resetQuestionState() {
    selectedOption = null;
    isAnswered = false;
    nextQuestionButtonText = AppTheme.nextQuestionText;
  }

  void handleQuizCompletion() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${AppTheme.quizCompletedText} ${AppTheme.userScoreText} $score",
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

  Future<bool> _onWillPop() async {
    final shouldExit = await _showExitDialog();
    return shouldExit ?? false; // Return true or false to pop or not
  }

  Future<bool?> _showExitDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppTheme.exitQuizTitle),
        content: Text(AppTheme.exitQuizMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // User cancels
            child: Text(AppTheme.cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // User confirms exit
            child: Text(AppTheme.exitText),
          ),
        ],
      ),
    );
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

    // Calculate progress
    double progress = (currentQuestionIndex + 1) / questions.length;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppTheme.appBarTitleText,
          showDrawer: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
          child: Column(
            children: [
              // Use your ProgressBar widget
              ProgressBar(progress: progress),
              const SizedBox(height: AppTheme.spaceSizeSmall),
              Expanded(
                child: Stack(
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(), // Placeholder for fading out
                    ),
                    SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        key: ValueKey<int>(currentQuestionIndex),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppTheme.userScoreText} $score',
                            style: InheritedAppTheme.scoreTextStyle,
                          ),
                          const SizedBox(height: AppTheme.spaceSizeMedium),
                          Text(
                            currentQuestion.question,
                            style: InheritedAppTheme.questionTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppTheme.spaceSizeMedium),
                          ...currentQuestion.options.map(
                            (option) {
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
                            },
                          ),
                        ],
                      ),
                    ),
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
                  buttonText: isLastQuestion ? AppTheme.exitQuizText : nextQuestionButtonText,
                  onPressed: isLastQuestion ? handleQuizCompletion : nextQuestion,
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomElevatedButton(
                  buttonText: AppTheme.endQuizText,
                  onPressed: () async {
                    final shouldExit = await _showExitDialog();
                    if (shouldExit == true && mounted) {
                      Navigator.pop(context); // Exit the quiz
                    }
                  },
                  backgroundColor: AppTheme.buttonBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
