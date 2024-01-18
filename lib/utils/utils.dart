import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, MessageType type) {
  Color color;
  if (type == MessageType.error) {
    color = Colors.red;
  } else {
    color = Colors.green;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ),
  );
}

enum MessageType {
  error,
  success,
  info,
  warning,
}
