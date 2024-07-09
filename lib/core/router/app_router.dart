import 'package:animo/core/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: RootRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: ExtensionCreateRoute.page),
            AutoRoute(page: ExtensionEditRoute.page),
          ],
        ),
        AutoRoute(page: MediaDetailRoute.page),
      ];
}
