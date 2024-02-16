import 'package:animo/screens/media/detail_screen.dart';
import 'package:animo/screens/media/manga_reader_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/screens/auth/signin_screen.dart';
import 'package:animo/screens/explore/explore.dart';
import 'package:animo/screens/explore/explore_detail.dart';
import 'package:animo/screens/explore/search_screen.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/media/detail_anime.dart';
import 'package:animo/screens/profile/profile.dart';
import 'package:animo/screens/splash_screen.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/scaffold_with_bar.dart';

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
    // GoRoute(
    //   path: '/manga/:slug',
    //   name: 'manga',
    //   builder: (context, state) {
    //     String slug = state.pathParameters['slug']!;
    //     return DetailScreenOld(
    //       slug: slug,
    //       type: MediaType.manga,
    //     );
    //   },
    //   routes: [
    //     GoRoute(
    //       parentNavigatorKey: _rootNavigator,
    //       path: 'chapter/:ch',
    //       name: 'chapter',
    //       builder: (context, state) {
    //         String slug = state.pathParameters['slug']!;
    //         String ch = state.pathParameters['ch']!;

    //         return MangaReaderScreen(
    //           baseData:
    //               BaseData(slug: ch, type: MediaType.manga, parentSlug: slug),
    //         );
    //       },
    //     ),
    //     // GoRoute(
    //     //   path: 'characters',
    //     //   builder: (context, state) {},
    //     // ),
    //   ],
    // ),
    // GoRoute(
    //   path: '/anime/:slug',
    //   name: 'anime',
    //   builder: (context, state) {
    //     String slug = state.pathParameters['slug']!;

    //     return DetailAnime(
    //       slug: slug,
    //       type: MediaType.anime,
    //     );
    //   },
    // ),
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
                  path: 'search',
                  name: 'explore-search',
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    final MediaType mediaType = state.extra as MediaType;
                    return SearchScreen(mediaType: mediaType);
                  },
                ),
                GoRoute(
                  path: ':type/:path',
                  name: 'explore-detail',
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    final MediaType mediaType =
                        MediaType.values.byName(state.pathParameters['type']!);
                    final String path = state.pathParameters['path']!;
                    final String title = state.extra as String;

                    if (state.error != null) {
                      return ErrorView(message: state.error!.message);
                    }

                    return ExploreDetail(
                      mediaType: mediaType,
                      path: path,
                      options:
                          Map<String, dynamic>.from(state.uri.queryParameters),
                      title: title,
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
            path: 'read/:chapter',
            name: 'read',
            builder: (context, state) {
              final parentSlug = state.pathParameters['slug']!;
              final type =
                  MediaType.values.byName(state.pathParameters['type']!);
              final slug = state.pathParameters['chapter']!;

              if (type == MediaType.anime) {
                throw 'Unsupported';
              } else if (type == MediaType.manga) {
                return MangaReaderScreen(
                    baseData: BaseData(
                        slug: slug, parentSlug: parentSlug, type: type));
              } else {
                throw 'Unsupported';
              }
            },
          )
        ]),
  ],
);
