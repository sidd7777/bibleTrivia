import 'package:flutter/material.dart';

class ExitDialog {
  static Future<bool?> show(BuildContext context, String title, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // User cancels
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // User confirms exit
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }
}
