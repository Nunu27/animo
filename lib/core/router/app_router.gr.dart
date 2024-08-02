// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:animo/domain/enums/media_type.dart' as _i9;
import 'package:animo/presentation/extension/pages/extension_create_page.dart'
    as _i1;
import 'package:animo/presentation/extension/pages/extension_edit_page.dart'
    as _i2;
import 'package:animo/presentation/home/pages/home_page.dart' as _i3;
import 'package:animo/presentation/media/pages/media_detail_page.dart' as _i4;
import 'package:animo/presentation/root_page.dart' as _i5;
import 'package:animo/presentation/search/pages/search_page.dart' as _i6;
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ExtensionCreateRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ExtensionCreatePage(),
      );
    },
    ExtensionEditRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ExtensionEditPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    MediaDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MediaDetailRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.MediaDetailPage(
          key: args.key,
          id: args.id,
          cover: args.cover,
        ),
      );
    },
    RootRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RootPage(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SearchPage(
          key: args.key,
          mediaType: args.mediaType,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ExtensionCreatePage]
class ExtensionCreateRoute extends _i7.PageRouteInfo<void> {
  const ExtensionCreateRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ExtensionCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionCreateRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ExtensionEditPage]
class ExtensionEditRoute extends _i7.PageRouteInfo<void> {
  const ExtensionEditRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ExtensionEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionEditRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MediaDetailPage]
class MediaDetailRoute extends _i7.PageRouteInfo<MediaDetailRouteArgs> {
  MediaDetailRoute({
    _i8.Key? key,
    required int id,
    required String cover,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          MediaDetailRoute.name,
          args: MediaDetailRouteArgs(
            key: key,
            id: id,
            cover: cover,
          ),
          initialChildren: children,
        );

  static const String name = 'MediaDetailRoute';

  static const _i7.PageInfo<MediaDetailRouteArgs> page =
      _i7.PageInfo<MediaDetailRouteArgs>(name);
}

class MediaDetailRouteArgs {
  const MediaDetailRouteArgs({
    this.key,
    required this.id,
    required this.cover,
  });

  final _i8.Key? key;

  final int id;

  final String cover;

  @override
  String toString() {
    return 'MediaDetailRouteArgs{key: $key, id: $id, cover: $cover}';
  }
}

/// generated route for
/// [_i5.RootPage]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SearchPage]
class SearchRoute extends _i7.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i8.Key? key,
    required _i9.MediaType mediaType,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            mediaType: mediaType,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i7.PageInfo<SearchRouteArgs> page =
      _i7.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.mediaType,
  });

  final _i8.Key? key;

  final _i9.MediaType mediaType;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, mediaType: $mediaType}';
  }
}
