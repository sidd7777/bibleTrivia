import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onClose;

  const CustomErrorDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: onClose,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
