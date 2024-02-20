import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotLoginView extends StatelessWidget {
  const NotLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "You haven't logged in yet",
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 14,
          ),
          FilledButton(
            onPressed: () {
              context.go('/signin');
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
