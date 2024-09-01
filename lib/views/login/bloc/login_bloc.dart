import 'dart:convert';

import 'package:dealer/local_db/secure_db_controller.dart';
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
    try {
      user = User(userName: name, passWord: passWord);
      final result = await AppInjector.httpSrv
          .postData(LoginSubApi.loginRoot.subRoute, user.toJson());
      if (result.status == ResultsLevel.fail) {
        // display some thing to user
        AppInjector.appLogger.showLogger(LogLevel.warning, '${result.data}');
        emit(0);
      } else {
        final map = jsonDecode(result.data) as Map<String, dynamic>;
        user = User.fromMap(map['data']);
        String token = map['token'];
        String convertUser = jsonEncode(
            {'name': user.userName, 'per': user.per, 'id': user.userId});
        await AppInjector.localeSecureStorag
            .writeNewItem(KeySecureStorage.user.keySecure, convertUser);
        final save = await AppInjector.localeSecureStorag
            .writeNewItem(KeySecureStorage.token.keySecure, token);
        AppInjector.appLogger.showLogger(LogLevel.info, save.status.toString());
        emit(2);
      }
    } catch (e) {
      emit(0);
      AppInjector.appLogger
          .showLogger(LogLevel.error, '*** ${e.toString()}***');
    }
  }

  Future<void> signOut() async {}
}
