import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showError(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(Icons.error_outline_outlined, color: Colors.white),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      );
  }

  static void showSuccess(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(Icons.check_circle_outline_outlined, color: Colors.white),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      );
  }
}
