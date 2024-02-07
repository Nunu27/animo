import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/explore.dart';
import 'package:animo/screens/explore/explore_detail.dart';
import 'package:animo/screens/explore/search_screen.dart';
import 'package:animo/screens/library/library.dart';
import 'package:animo/screens/media/detail_anime.dart';
import 'package:animo/screens/media/detail_manga.dart';
import 'package:animo/screens/media/manga_reader_screen.dart';
import 'package:animo/screens/profile/profile.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/error_view.dart';
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
          baseMedia: BaseData(slug: slug, type: MediaType.manga),
        );
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
              baseData:
                  BaseData(slug: ch, type: MediaType.manga, parentSlug: slug),
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
          baseMedia: BaseData(slug: slug, type: MediaType.anime),
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
                  path: ':media/:filter',
                  name: 'explore-detail',
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    final MediaType mediaType =
                        getMediaType(state.pathParameters['media']!);
                    final String filter = state.pathParameters['filter']!;
                    final String title = state.extra as String;

                    if (state.error != null) {
                      return ErrorView(message: state.error!.message);
                    }

                    return ExploreDetail(
                      mediaType: mediaType,
                      filter: filter,
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
    )
  ],
);
