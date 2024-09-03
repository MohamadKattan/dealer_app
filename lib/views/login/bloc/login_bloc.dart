import 'dart:convert';
import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginSubUrl {
  loginRoot('logIn');

  const LoginSubUrl(this.subRoute);
  final String subRoute;
}

enum LoginStateLavel {
  initLogin(0),
  startLogin(1),
  successLogin(2),
  failLogin(3);

  const LoginStateLavel(this.state);
  final int state;
}

class LoginBloc extends Cubit<int> {
  LoginBloc() : super(LoginStateLavel.initLogin.state);

  Future<void> newLogin(
      TextEditingController name, TextEditingController passWord) async {
    emit(LoginStateLavel.startLogin.state);
    try {
      final user = User(userName: name.text, passWord: passWord.text.trim());
      final res = await AppGetter.httpSrv
          .postData(LoginSubUrl.loginRoot.subRoute, user.toJson());
      if (res.status == ResultsLevel.fail) {
        emit(LoginStateLavel.failLogin.state);
        AppGetter.appLogger.showLogger(LogLevel.warning, '${res.data}');
      } else {
        final map = jsonDecode(res.data) as Map<String, dynamic>;
        final resLocal = await AppGetter.userController.setUserToLocal(map);
        if (resLocal.error != null) {
          AppGetter.appLogger.showLogger(LogLevel.warning, '${resLocal.error}');
          emit(LoginStateLavel.failLogin.state);
        } else {
          name.clear();
          passWord.clear();
          emit(LoginStateLavel.successLogin.state);
        }
      }
    } catch (e) {
      emit(LoginStateLavel.failLogin.state);
      AppGetter.appLogger.showLogger(LogLevel.error, '*** ${e.toString()}***');
    }
  }

  Future<void> signOut() async {}
}
