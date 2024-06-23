import 'package:animo/core/router/app_router.dart';
import 'package:animo/core/theme/animo_theme.dart';
import 'package:animo/core/theme/color_schemes.g.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Animo',
      themeMode: ThemeMode.dark,
      darkTheme: const AnimoTheme(colorScheme: darkColorScheme).build(),
      theme: const AnimoTheme(colorScheme: lightColorScheme).build(),
      builder: BotToastInit(),
      routerConfig: router.config(),
    );
  }
}
