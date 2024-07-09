import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget icon;
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.icon = const Icon(
      Icons.error_outline_outlined,
      size: 30,
    ),
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 4,
          ),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          if (onRetry != null)
            FilledButton(
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onRetry!,
              child: const Text('Try again'),
            )
        ],
      ),
    );
  }
}
