import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget? icon;
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({super.key, this.icon, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        if (icon != null) icon!,
        Text(message),
        if (onRetry != null)
          FilledButton(
            onPressed: onRetry!,
            child: const Text('Try again'),
          )
      ]),
    );
  }
}
