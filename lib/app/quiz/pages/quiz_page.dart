import 'package:bible_trivia/widgets/progress_bar.dart';
import 'package:bible_trivia/widgets/quiz_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import for Provider

import '../../../core/app-theme/app_theme.dart';
import '../../../core/app-theme/inherited_app_theme.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/exit_dialog.dart';
import '../controller/quiz_controller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await _showExitDialog(context);
    return shouldExit ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return ExitDialog.show(
      context,
      AppTheme.exitQuizTitle,
      AppTheme.exitQuizMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizController(),
      child: Consumer<QuizController>(
        builder: (context, quizController, _) {
          if (quizController.questions.isEmpty) {
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

          final currentQuestion = quizController.questions[quizController.currentQuestionIndex];
          final isLastQuestion = quizController.isLastQuestion();

          // Calculate progress
          double progress =
              (quizController.currentQuestionIndex + 1) / quizController.questions.length;

          return WillPopScope(
            onWillPop: () => _onWillPop(context),
            child: Scaffold(
              appBar: const CustomAppBar(
                title: AppTheme.appBarTitleText,
                showDrawer: false,
              ),
              body: SingleChildScrollView(
                // Added SingleChildScrollView
                padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
                child: Column(
                  children: [
                    // Use your ProgressBar widget
                    ProgressBar(progress: progress),
                    const SizedBox(height: AppTheme.spaceSizeSmall),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppTheme.userScoreText} ${quizController.score}',
                          style: InheritedAppTheme.scoreTextStyle,
                        ),
                        const SizedBox(height: AppTheme.spaceSizeMedium),
                        Text(
                          currentQuestion.question,
                          style: InheritedAppTheme.questionTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spaceSizeMedium),
                        ...currentQuestion.options.map((option) {
                          return QuizOption(
                            option: option,
                            selectedOption: quizController.selectedOption,
                            isAnswered: quizController.isAnswered,
                            correctAnswer: currentQuestion.correctAnswer,
                            onSelect: (selected) {
                              quizController.selectOption(selected);
                            },
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spaceSizeMedium),

                    // Conditional button rendering
                    if (!quizController.isAnswered)
                      CustomElevatedButton(
                        buttonText: AppTheme.confirmSelectionText,
                        onPressed: quizController.selectedOption == null
                            ? () {} // Disable button if no option is selected
                            : () {
                                quizController.checkAnswer(quizController.selectedOption!);
                              },
                        backgroundColor: quizController.selectedOption == null
                            ? Colors.grey
                            : AppTheme.buttonBackgroundColor,
                      ),

                    if (quizController.isAnswered)
                      CustomElevatedButton(
                        buttonText: isLastQuestion
                            ? AppTheme.exitQuizText
                            : quizController.nextQuestionButtonText,
                        onPressed: isLastQuestion
                            ? () => quizController.handleQuizCompletion(context, quizController)
                            : quizController.nextQuestion,
                      ),

                    const SizedBox(height: AppTheme.spaceSizeMedium),

                    if (!isLastQuestion)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomElevatedButton(
                          buttonText: AppTheme.endQuizText,
                          onPressed: () async {
                            final shouldExit = await _showExitDialog(context);
                            if (shouldExit == true) {
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
        },
      ),
    );
  }
}
