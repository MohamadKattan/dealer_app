import 'dart:convert';
import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/models/results_controller.dart';
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
  failLogin(3),
  errorName(4),
  errorPassword(5),
  weakPassword(6),
  showPass(7),
  hide(8);

  const LoginStateLavel(this.state);
  final int state;
}

class LoginBloc extends Cubit<int> {
  LoginBloc() : super(LoginStateLavel.initLogin.state);

  isShowPassword(bool show) {
    if (show) {
      return emit(LoginStateLavel.showPass.state);
    }
    emit(LoginStateLavel.hide.state);
  }

  Future<void> login(
      TextEditingController name, TextEditingController passWord) async {
    if (name.text.isEmpty) {
      emit(LoginStateLavel.errorName.state);
      await Future.delayed(const Duration(seconds: 2));
      return emit(LoginStateLavel.initLogin.state);
    }

    if (passWord.text.isEmpty) {
      emit(LoginStateLavel.errorPassword.state);
      await Future.delayed(const Duration(seconds: 2));
      return emit(LoginStateLavel.initLogin.state);
    }

    emit(LoginStateLavel.startLogin.state);
    try {
      final user = UserModel(userName: name.text, passWord: passWord.text.trim());
      final res = await AppGetter.httpSrv.postData(
          LoginSubUrl.loginRoot.subRoute, user.toJson(UserJsonType.logIn));
      if (res.status == ResultsLevel.fail) {
        emit(LoginStateLavel.failLogin.state);
        AppGetter.appLogger.showLogger(LogLevel.warning, '${res.data}');
      } else {
        final map = jsonDecode(res.data) as Map<String, dynamic>;
        final saveUserToLocalDB = await AppGetter.userController.setUserToLocal(map);
        if (saveUserToLocalDB.error != null) {
          AppGetter.appLogger.showLogger(LogLevel.warning, '${saveUserToLocalDB.error}');
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
