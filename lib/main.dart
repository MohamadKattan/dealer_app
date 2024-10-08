import 'package:dealer/controller/helper_methods_controller.dart';
import 'package:dealer/router/router_app.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_bloc.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_bloc.dart';
import 'package:dealer/views/login/bloc/login_bloc.dart';
import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utilities/style_app/app_them/bloc/them_bloc.dart';

Future<void> main() async {
  await _initMethod();
  runApp(MyApp());
}

Future _initMethod() async {
  // Bloc.observer = const AppBlocObserver();
  await dotenv.load(fileName: ".env");
  AppGetter.checkPer = dotenv.get('PER', fallback: 'sane-default');
  HelperMethods.getDate();
  final result = await AppGetter.userController.getUserFromLocal();
  AppGetter.appLogger.showLogger(
      result.error != null ? LogLevel.error : LogLevel.info,
      result.error != null ? '${result.error}' : 'get user in main');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (_) => SplashBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<DbRemoteBloc>(create: (_) => DbRemoteBloc()),
        BlocProvider<UserSettingsBloc>(create: (_) => UserSettingsBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (_, theme) {
          return MaterialApp.router(
            title: 'Business System Management',
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: _appRouter.config(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
