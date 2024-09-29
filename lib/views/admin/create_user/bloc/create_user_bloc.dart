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
    on<InitialEvent>(_initialSettings);
    on<ShowFormSignUpEvent>(_showFormSginUp);
    on<ShowHidePassWordEvent>(_showHidePassWord);
    on<SginUpUserEvent>(_signUpNewUser);
    on<GetAllUsersEvent>(_getAllUsers);
  }

  bool _isPasswordStrong(String password) {
    final strongPasswordRegExp = RegExp(
      r'^(?=.*[A-Za-z\u0400-\u04FFÇĞİÖŞÜçğıöşü])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );

    return strongPasswordRegExp.hasMatch(password);
  }

  _initialSettings(InitialEvent event, Emitter<UserSettingsStates> emit) {
    emit(InitialState());
  }

  _showFormSginUp(ShowFormSignUpEvent event, Emitter<UserSettingsStates> emit) {
    emit(ShowFormSginUpState());
  }

  _showHidePassWord(
      ShowHidePassWordEvent event, Emitter<UserSettingsStates> emit) {
    emit(ShowFormSginUpState(showPass: !event.show));
  }

  _signUpNewUser(
      SginUpUserEvent event, Emitter<UserSettingsStates> emit) async {
    try {
      if (event.userName.isEmpty) {
        emit(ShowFormSginUpState(
            titleMsg: 'Error', msg: 'Username is required'));
        return;
      }
      if (event.passWord.isEmpty) {
        emit(ShowFormSginUpState(
            titleMsg: 'Error', msg: 'PassWord is required'));
        return;
      }
      if (!_isPasswordStrong(event.passWord)) {
        emit(ShowFormSginUpState(
            titleMsg: 'Error', msg: 'PassWord is weak\n Example : Password99'));
        return;
      }
      if (event.per.isEmpty) {
        emit(ShowFormSginUpState(
            titleMsg: 'Error', msg: 'Permissions is required'));
        return;
      }
      if (event.address!.length <= 1) {
        event.address = 'No address provided';
      }
      emit(LoudingState());
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
        return emit(ShowFormSginUpState(
            titleMsg: 'Error', msg: result.msg ?? 'null data'));
      }
      emit(SignUpUserState(msg: result.msg ?? 'null data'));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(ShowFormSginUpState(titleMsg: 'Error', msg: e.toString()));
    }
  }

  _getAllUsers(GetAllUsersEvent event, Emitter<UserSettingsStates> emit) {}
}
