import 'package:animo/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool transitioning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Pallete.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    const Text(
                      "Checking for updates",
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
