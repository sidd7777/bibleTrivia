import 'package:flutter/material.dart';

import '../core/app-theme/app_theme.dart';
import '../core/app-theme/inherited_app_theme.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final String? selectedOption;
  final bool isAnswered;
  final String correctAnswer;
  final Function(String) onSelect;

  const QuizOption({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.isAnswered,
    required this.correctAnswer,
    required this.onSelect,
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
      onTap: isAnswered ? null : () => onSelect(option),
      child: Card(
        elevation: AppTheme.spaceSizeMedium,
        color: getButtonColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spaceSizeSmall),
          child: Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedOption,
                onChanged: isAnswered ? null : (value) {},
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
