import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/router/router_app.gr.dart';
import 'package:dealer/utilities/style_app/app_them/bloc/them_bloc.dart';
import 'package:dealer/utilities/style_app/config/style_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String txt = '';
    StackRouter router = context.router;
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is Inite) {
            context.read<ThemeBloc>().getTheme();
            context.read<SplashBloc>().add(GetDataUserAndConfigEvent());
          }
          if (state is Louding) {
            txt = AppLocalizations.of(context)!.loudingUserInfo;
          }
          if (state is GetDataAndConfigState) {
            txt = state.newTxet ?? 'okay';
            if (state.user == null) {
              router.push(const LoginRoute());
            }
            return const SizedBox();
          }
          if (state is ErrorGetDate) {
            txt = state.errorMsg ?? 'ErrorGetDate';
            // return _body(txtError);
          }
          return _body(txt, context);
        },
      ),
    );
  }

  Widget _body(String txt, BuildContext context) {
    return SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Image.memory(
                base64Decode(DefaultValuse.defaultSplashImg),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 200, child: AppIndicators.loadingLinearIndicator),
            ),
            AppText.normalTxet(txt)
          ],
        ),
      )),
    );
  }
}
