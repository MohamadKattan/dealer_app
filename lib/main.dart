import 'package:dealer/router/router_app.dart';
import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'utilities/style_app/app_them/bloc/them_bloc.dart';

void main() {
  // Bloc.observer = const AppBlocObserver();
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
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(builder: (_, theme) {
        return MaterialApp.router(
          title: 'Dealer system mangment',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: _appRouter.config(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      }),
    );
  }
}
