import 'dart:convert';

import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/models/results_controller.dart';
import 'package:dealer/views/admin/create_user/bloc/create_user_event.dart';
import 'package:dealer/views/admin/create_user/bloc/create_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignUpUserSuburl {
  createUser('createUser');

  final String url;
  const SignUpUserSuburl(this.url);
}

class CreateUserBloc extends Bloc<UserSettingsEvents, UserSettingsStates> {
  CreateUserBloc() : super(InitialState()) {
    on<ShowHidePassWordEvent>(_showHidePassWord);
    on<SginUpUserEvent>(_signUpNewUser);
  }

  bool _isPasswordStrong(String password) {
    final strongPasswordRegExp = RegExp(
      r'^(?=.*[A-Za-z\u0400-\u04FFÇĞİÖŞÜçğıöşü])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );

    return strongPasswordRegExp.hasMatch(password);
  }

  _showHidePassWord(
      ShowHidePassWordEvent event, Emitter<UserSettingsStates> emit) {
    emit(ShowHidePassWordState(!event.show));
  }

  _signUpNewUser(
      SginUpUserEvent event, Emitter<UserSettingsStates> emit) async {
    try {
      if (event.userName.isEmpty) {
        emit(SignUpUserState(msg: 'Username is required'));
        return;
      }
      if (event.passWord.isEmpty) {
        emit(SignUpUserState(msg: 'PassWord is required'));
        return;
      }
      if (!_isPasswordStrong(event.passWord)) {
        emit(SignUpUserState(msg: 'PassWord is Not Strong'));
        return;
      }
      if (event.per.isEmpty) {
        emit(SignUpUserState(msg: 'Permissions is required'));
        return;
      }
      if (event.address!.length <= 1) {
        event.address = 'No address provided';
      }
      emit(SignUpUserState(isLouding: true));
      final user = User(
          userName: event.userName,
          passWord: event.passWord,
          address: event.address,
          per: event.per);
      final body = user.toJson(UserJsonType.sginUp);
      final res = await AppGetter.httpSrv
          .postData(SignUpUserSuburl.createUser.url, body, isAuth: true);
      final data = jsonDecode(res.data);
      final result = ResultController.fromMap(data);
      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger
            .showLogger(LogLevel.error, result.msg ?? 'null error msg');
      }
      emit(SignUpUserState(isLouding: false, msg: result.msg ?? 'null data'));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(SignUpUserState(msg: e.toString()));
    }
  }
}
