import 'package:animo/models/base_media.dart';
import 'package:animo/screens/explore/explore.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/media/detail_anime.dart';
import 'package:animo/screens/media/detail_manga.dart';
import 'package:animo/screens/media/manga_reader_screen.dart';
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
      path: '/manga/:slug',
      name: 'manga',
      builder: (context, state) {
        String slug = state.pathParameters['slug']!;
        return DetailManga(
            baseMedia: BaseMedia(slug: slug, type: MediaType.manga));
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigator,
          path: 'chapter/:ch',
          name: 'chapter',
          builder: (context, state) {
            String slug = state.pathParameters['slug']!;
            String ch = state.pathParameters['ch']!;
            return MangaReaderScreen(
              slug: slug,
              type: MediaType.manga,
              chapter: ch,
            );
          },
        ),
        // GoRoute(
        //   path: 'characters',
        //   builder: (context, state) {},
        // ),
      ],
    ),
    GoRoute(
      path: '/anime/:slug',
      name: 'anime',
      builder: (context, state) {
        String slug = state.pathParameters['slug']!;

        return DetailAnime(
          baseMedia: BaseMedia(slug: slug, type: MediaType.anime),
        );
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
