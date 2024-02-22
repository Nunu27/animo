import 'package:animo/models/base_data.dart';
import 'package:animo/screens/auth/signin_screen.dart';
import 'package:animo/screens/explore/explore.dart';
import 'package:animo/screens/explore/explore_detail.dart';
import 'package:animo/screens/explore/search_screen.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/media/detail_anime.dart';
import 'package:animo/screens/media/detail_screen.dart';
import 'package:animo/screens/media/reader_screen.dart';
import 'package:animo/screens/profile/profile.dart';
import 'package:animo/screens/splash_screen.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/scaffold_with_bar.dart';
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
              routes: [
                GoRoute(
                  path: ':type/search',
                  name: 'explore-search',
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    return SearchScreen(
                      mediaType: MediaType.values.byName(
                        state.pathParameters['type']!,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: ':type/:path',
                  name: 'explore-detail',
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    return ExploreDetail(
                      mediaType: MediaType.values.byName(
                        state.pathParameters['type']!,
                      ),
                      path: state.pathParameters['path']!,
                      options: Map<String, dynamic>.from(
                        state.uri.queryParameters,
                      ),
                      title: state.extra as String,
                    );
                  },
                )
              ],
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
    ),
    GoRoute(
        path: '/:type/:slug',
        builder: (context, state) {
          final slug = state.pathParameters['slug']!;
          final type = MediaType.values.byName(state.pathParameters['type']!);

          if (type == MediaType.anime) {
            return DetailAnime(type: type, slug: slug);
          } else {
            return DetailScreen(
              slug: slug,
              type: type,
            );
          }
        },
        routes: [
          GoRoute(
            path: 'read',
            name: 'read',
            builder: (context, state) {
              final type =
                  MediaType.values.byName(state.pathParameters['type']!);
              final extra = state.extra as Map<String, dynamic>;

              if (type == MediaType.anime) {
                return const Scaffold(
                  body: ErrorView(message: 'You can\'t read an anime'),
                );
              }

              return ReaderScreen(
                syncData: extra['syncData'],
                chapter: extra['chapter'],
                chapters: extra['chapters'],
              );
            },
          )
        ]),
  ],
);
