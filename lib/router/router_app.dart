import 'package:auto_route/auto_route.dart';
import 'package:dealer/router/router_app.gr.dart';

// dart run build_runner build

@override
RouteType get defaultRouteType => const RouteType.material();

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ControlRoute.page),
        AutoRoute(page: DbRemoteRoute.page),
        AutoRoute(page: CreateUserRoute.page),
        AutoRoute(page: WarehousesRoute.page)
      ];
}
