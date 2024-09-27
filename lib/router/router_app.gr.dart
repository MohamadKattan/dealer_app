// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:dealer/views/admin/control_screen.dart' as _i1;
import 'package:dealer/views/admin/create_user/create_user_screen.dart' as _i2;
import 'package:dealer/views/admin/db_remote_setting/db_remote_screen.dart'
    as _i3;
import 'package:dealer/views/home/home_screen.dart' as _i4;
import 'package:dealer/views/login/login_screen.dart' as _i5;
import 'package:dealer/views/splash/splash_screen.dart' as _i6;

/// generated route for
/// [_i1.ControlScreen]
class ControlRoute extends _i7.PageRouteInfo<void> {
  const ControlRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ControlRoute.name,
          initialChildren: children,
        );

  static const String name = 'ControlRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ControlScreen();
    },
  );
}

/// generated route for
/// [_i2.CreateUserScreen]
class CreateUserRoute extends _i7.PageRouteInfo<void> {
  const CreateUserRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CreateUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateUserRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.CreateUserScreen();
    },
  );
}

/// generated route for
/// [_i3.DbRemoteScreen]
class DbRemoteRoute extends _i7.PageRouteInfo<void> {
  const DbRemoteRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DbRemoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'DbRemoteRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.DbRemoteScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginScreen();
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}
