import 'package:animo/screens/home/home.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/profile/profile.dart';
import 'package:animo/widgets/scaffold_with_bar.dart';
import 'package:animo/screens/auth/signin_screen.dart';
import 'package:animo/screens/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  initialLocation: '/signin',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/signin',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SignInScreen()),
    ),
    ShellRoute(
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: ScaffoldWithBar(child: child));
      },
      routes: [
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Home()),
        ),
        GoRoute(
          path: '/library',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Library()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Profile()),
        )
      ],
    )
  ],
);
