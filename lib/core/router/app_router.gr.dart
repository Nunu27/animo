// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:animo/presentation/pages/extension/extension_create_page.dart'
    as _i1;
import 'package:animo/presentation/pages/extension/extension_edit_page.dart'
    as _i2;
import 'package:animo/presentation/pages/home/home_page.dart' as _i3;
import 'package:animo/presentation/pages/root_page.dart' as _i4;
import 'package:auto_route/auto_route.dart' as _i5;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ExtensionCreateRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ExtensionCreatePage(),
      );
    },
    ExtensionEditRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ExtensionEditPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ExtensionCreatePage]
class ExtensionCreateRoute extends _i5.PageRouteInfo<void> {
  const ExtensionCreateRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ExtensionCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionCreateRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ExtensionEditPage]
class ExtensionEditRoute extends _i5.PageRouteInfo<void> {
  const ExtensionEditRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ExtensionEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionEditRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RootPage]
class RootRoute extends _i5.PageRouteInfo<void> {
  const RootRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
