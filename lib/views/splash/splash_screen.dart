import 'dart:convert';

import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_text.dart';
import 'package:dealer/utilities/stayle_app/stayle_config.dart';
import 'package:dealer/views/splash/bloc/splash_bloc.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String txt = '';
    return Scaffold(
      backgroundColor: bgroundColor,
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is Inite) {
            context.read<SplashBloc>().add(GetDataUserAndConfigEvent());
          }
          if (state is Louding) {
            txt = state.txt ?? 'louding';
          }
          if (state is GetDataAndConfigState) {
            txt = state.newTxet ?? 'okay';
            return const SizedBox();
          }
          if (state is ErrorGetDate) {
            txt = state.errorMsg ?? 'ErrorGetDate';
            // return _body(txtError);
          }
          return _body(txt);
        },
      ),
    );
  }

  Widget _body(String txt) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(child: Image.memory(base64Decode(defaultSplashImg))),
        SizedBox(
            width: 100, child: AppIndicators().loudingLinearProgressIndicator),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText().normalTxet(txt),
        )
      ],
    ));
  }
}
