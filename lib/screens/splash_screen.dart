import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:animo/providers/user_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool transitioning = false;

  void checkState() async {
    final user = ref.read(userStateProvider);
    if (user == null) {
      context.go('/signin');
    } else {
      context.go('/explore');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('assets/images/adaptive-icon.png'),
                      height: 256,
                      width: 256,
                    ),
                  ),
                ),
              ),
              if (!transitioning)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    const Text(
                      'Checking for updates',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
