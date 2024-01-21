import 'package:animo/screens/signin_screen.dart';
import 'package:animo/screens/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  initialLocation: '/signin',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
