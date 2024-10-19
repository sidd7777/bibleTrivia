import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final String? selectedOption;
  final bool isAnswered;
  final String correctAnswer;
  final Function(String) onSelect;

  const QuizOption({
    super.key,
    required this.option,
    this.selectedOption,
    required this.isAnswered,
    required this.correctAnswer,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    bool isCorrect = option == correctAnswer;
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () => onSelect(option),
      child: Container(
        decoration: BoxDecoration(
          color: isAnswered
              ? (isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.grey))
              : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          option,
          style: TextStyle(
            color: isAnswered && isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
