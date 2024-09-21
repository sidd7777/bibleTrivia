import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final String? selectedOption;
  final bool isAnswered;
  final String correctAnswer;
  final Function(String) onSelect; // Add a callback to handle selection

  const QuizOption({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.isAnswered,
    required this.correctAnswer,
    required this.onSelect, // Pass the callback
  });

  Color getButtonColor() {
    if (!isAnswered) return AppTheme.optionCardColor;

    if (option == correctAnswer) {
      return Colors.green; // Correct answer
    }
    if (selectedOption == option) {
      return Colors.red; // Selected but incorrect answer
    }
    return AppTheme.optionCardColor; // Default card color
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAnswered
          ? null
          : () => onSelect(option), // Call the callback on tap
      child: Card(
        elevation: AppTheme.spaceSizeMedium,
        color: getButtonColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
          child: Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedOption,
                onChanged: isAnswered
                    ? null
                    : (value) {
                        // Update selection if needed
                      },
              ),
              Expanded(
                child: Text(
                  option,
                  style: InheritedAppTheme.optionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
