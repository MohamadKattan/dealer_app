import 'dart:convert';

import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginSubApi {
  loginRoot('logIn');

  const LoginSubApi(this.subRoute);
  final String subRoute;
}

class LoginBloc extends Cubit<int> {
  LoginBloc() : super(0);
  User user = User();

  Future<void> newLogin(String name, String passWord) async {
    emit(1);
    await Future.delayed(const Duration(seconds: 3));
    emit(0);
    try {
      user = User(userName: name, passWord: passWord);
      final result = await AppInjector.httpSrv
          .postData(LoginSubApi.loginRoot.subRoute, user.toJson());
      if (result.status == ResultsLevel.fail) {
        // display some thing to user
        AppInjector.appLogger.showLogger(LogLevel.warning, '${result.data}');
      } else {
        final data = jsonDecode(result.data) as Map<String, dynamic>;
        user = User.fromMap(data['data']);
        AppInjector.appLogger.showLogger(LogLevel.info, '${result.data}');
      }
    } catch (e) {
      AppInjector.appLogger.showLogger(LogLevel.error, '*** ${e.toString()}');
    }
  }

  Future<void> signOut() async {}
}
