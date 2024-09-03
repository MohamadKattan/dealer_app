import 'package:dealer/router/router_app.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/login/bloc/login_bloc.dart';
import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utilities/style_app/app_them/bloc/them_bloc.dart';

Future<void> main() async {
  // Bloc.observer = const AppBlocObserver();
  final result = await AppGetter.userController.getUserFromLocal();
  AppGetter.appLogger.showLogger(
      result.error != null ? LogLevel.error : LogLevel.info,
      'get user in main');
  runApp(MyApp());
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
        BlocProvider<LoginBloc>(create: (_) => LoginBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (_, theme) {
          return MaterialApp.router(
            title: 'Dealer System Mangment',
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
