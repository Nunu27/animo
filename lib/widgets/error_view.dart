import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget icon;
  final String message;
  final VoidCallback? onRetry;

  const ErrorView(
      {super.key,
      this.icon = const Icon(Icons.error_outline_outlined),
      required this.message,
      this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(message),
          if (onRetry != null)
            FilledButton(
              onPressed: onRetry!,
              child: const Text('Try again'),
            )
        ],
      ),
    );
  }
}
