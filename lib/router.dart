import 'package:animo/models/media_basic.dart';
import 'package:animo/screens/explore/explore.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/manga/detail_manga.dart';
import 'package:animo/screens/profile/profile.dart';
import 'package:animo/widgets/scaffold_with_bar.dart';
import 'package:animo/screens/auth/signin_screen.dart';
import 'package:animo/screens/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigator,
  observers: [BotToastNavigatorObserver()],
  initialLocation: '/splash',
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
    GoRoute(
      path: '/manga',
      builder: (context, state) {
        MediaBasic media = state.extra as MediaBasic;
        return DetailManga(media: media);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Explore()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Library()),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Profile()),
            )
          ],
        )
      ],
    )
  ],
);
