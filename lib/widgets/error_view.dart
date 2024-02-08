import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget icon;
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.icon = const Icon(
      Icons.error_outline_outlined,
      size: 100,
    ),
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              height: 4,
            ),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null)
              FilledButton(
                onPressed: onRetry!,
                child: const Text('Try again'),
              )
          ],
        ),
      ),
    );
  }
}
