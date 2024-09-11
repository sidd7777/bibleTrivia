import 'package:bible_trivia/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../factory.dart';
import '../model/quiz_questions.dart';
import 'main.dart';

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
  List<QuizQuestions> questions = [
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

  Color getButtonColor(String option) {
    if (selectedOption == option) {
      return option == questions[currentQuestionIndex].correctAnswer
          ? Colors.green
          : Colors.red;
    }
    return Colors.black; // Default button color
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedOption = answer;
      isAnswered = true;
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = null; // Reset selected option
        isAnswered = false; // Reset answered status
        nextQuestionButtonText = "Next Question";
      } else {
        nextQuestionButtonText = "End Quiz";
      }
    });
  }

  void handleQuiz() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Quiz Completed. Your Score is $score"),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(
          title: Factory.appBarTitleText,
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
        title: const Text("Exit Quiz ?"),
        content: const Text("Are you sure you want to exit the Quiz ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Exit"),
          ),
        ],
      ),
    );
    if (mounted && exit == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: Factory.appBarTitleText),
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
          title: Factory.appBarTitleText,
          showDrawer: false,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    QuizQuestions currentQuestion = questions[currentQuestionIndex];
    bool isLastQuestion = currentQuestionIndex == questions.length - 1;

    if (isLastQuestion) {
      nextQuestionButtonText = "End Quiz";
    }
    return Scaffold(
      appBar: const CustomAppBar(
        title: Factory.appBarTitleText,
        showDrawer: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current User Score : $score',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                currentQuestion.question,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ...currentQuestion.options.map((option) {
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: selectedOption,
                  onChanged: isAnswered
                      ? null
                      : (value) {
                          setState(() {
                            selectedOption = value.toString();
                          });
                        },
                );
              }),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: selectedOption != null && !isAnswered
                    ? () {
                        checkAnswer(selectedOption!);
                      }
                    : null,
                child: const Text("Confirm Selection"),
              ),
              const SizedBox(height: 20.0),
              if (isAnswered)
                ElevatedButton(
                  onPressed: isAnswered
                      ? () {
                          if (isLastQuestion) {
                            handleQuiz();
                          } else {
                            nextQuestion();
                          }
                        }
                      : null,
                  child: Text(nextQuestionButtonText),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: exitQuiz,
                  child: const Text("Exit Quiz?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
