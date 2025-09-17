import 'dart:convert';

import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/models/results_controller.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_event.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignUpUserSuburl {
  createUser('createUser'),
  getAllUsers('getAllUsers'),
  deleteOneUser('deleteOneUser'),
  editeOneUser('editeOneUser');

  final String url;
  const SignUpUserSuburl(this.url);
}

enum LevelUserSettingsMsg {
  errorcreateNewUser,
  createdNewUser,
  getAllUsers,
  nameRequired,
  passWordRequired,
  weakPassWord,
  permissionsRequired,
  catchError,
  errorDeleteUser,
  deletedUser,
  errorEditeUser,
  editedUser
}

class UserSettingsBloc extends Bloc<UserSettingsEvents, UserSettingsStates> {
  UserSettingsBloc() : super(InitialState()) {
    on<InitialEvent>(_initialSettings);
    on<ShowFormSignUpEvent>(_showFormSginUp);
    on<ShowHidePassWordEvent>(_showHidePassWord);
    on<SginUpUserEvent>(_signUpNewUser);
    on<GetAllUsersEvent>(_getAllUsers);
    on<DeleteOneUserEvent>(_deleteOneUser);
    on<EditeUserEvents>(_editeUserDate);
  }

  bool _isPasswordStrong(String password) {
    final strongPasswordRegExp = RegExp(
      r'^(?=.*[A-Za-z\u0400-\u04FFÇĞİÖŞÜçğıöşü])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );

    return strongPasswordRegExp.hasMatch(password);
  }

  void _initialSettings(InitialEvent event, Emitter<UserSettingsStates> emit) {
    emit(InitialState());
  }

  void _showHidePassWord(
      ShowHidePassWordEvent event, Emitter<UserSettingsStates> emit) {
    emit(ShowFormSginUpState(showPass: !event.show));
  }

  void _showFormSginUp(
      ShowFormSignUpEvent event, Emitter<UserSettingsStates> emit) {
    if (event.isForEidet == true) {
      emit(ShowFormSginUpState(
          userName: event.name,
          address: event.address,
          per: event.per,
          userId: event.id,
          passWord: event.passWord,
          isForEidet: true));
    } else {
      emit(ShowFormSginUpState(isForEidet: false));
    }
  }

  void _signUpNewUser(
      SginUpUserEvent event, Emitter<UserSettingsStates> emit) async {
    try {
      if (event.userName.isEmpty) {
        emit(ShowFormSginUpState(
            msgInfo: '', level: LevelUserSettingsMsg.nameRequired));
        return;
      }
      if (event.passWord.isEmpty) {
        emit(ShowFormSginUpState(
            msgInfo: '', level: LevelUserSettingsMsg.passWordRequired));
        return;
      }
      if (!_isPasswordStrong(event.passWord)) {
        emit(ShowFormSginUpState(
            msgInfo: '', level: LevelUserSettingsMsg.weakPassWord));
        return;
      }
      if (event.per.isEmpty) {
        emit(ShowFormSginUpState(
            msgInfo: '', level: LevelUserSettingsMsg.permissionsRequired));
        return;
      }
      if (event.address!.length <= 1) {
        event.address = 'No address provided';
      }
      emit(LoudingState());
      final user = UserModel(
          userName: event.userName,
          passWord: event.passWord,
          address: event.address,
          per: event.per);
      final body = user.toJson(UserJsonType.sgine);
      final res = await AppGetter.httpSrv
          .postData(SignUpUserSuburl.createUser.url, body, isAuth: true);
      final data = jsonDecode(res.data);
      final result = ResultController.fromMap(data);
      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger
            .showLogger(LogLevel.error, result.msg ?? 'null error msg');
        return emit(MessagesState(
            msgInfo: result.msg ?? 'null data',
            level: LevelUserSettingsMsg.errorcreateNewUser));
      }
      emit(MessagesState(
          title: 'Msg',
          msgInfo: result.msg ?? 'null data',
          level: LevelUserSettingsMsg.createdNewUser));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(MessagesState(
          msgInfo: e.toString(), level: LevelUserSettingsMsg.catchError));
    }
  }

  void _getAllUsers(
      GetAllUsersEvent event, Emitter<UserSettingsStates> emit) async {
    List<UserModel>? listOfUsers = [];
    try {
      emit(LoudingState());

      ResultController res = await AppGetter.httpSrv
          .getData(SignUpUserSuburl.getAllUsers.url, isAuth: true);

      final decodeRes = jsonDecode(res.data);
      ResultController newObj = ResultController.fromMap(decodeRes);

      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger
            .showLogger(LogLevel.error, newObj.msg ?? 'error to get all users');
        emit(MessagesState(
            msgInfo: newObj.msg, level: LevelUserSettingsMsg.getAllUsers));
        return;
      }
      // List resultUsers = newObj.data;
      for (var usr in newObj.data) {
        UserModel user = UserModel.fromMap(usr, type: UserJsonType.getUsers);
        listOfUsers.add(user);
      }
      emit(GetAllUsersState(data: listOfUsers));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(MessagesState(
          msgInfo: e.toString(), level: LevelUserSettingsMsg.catchError));
    }
  }

  void _deleteOneUser(
      DeleteOneUserEvent event, Emitter<UserSettingsStates> emit) async {
    try {
      emit(LoudingState());
      final result = await AppGetter.httpSrv
          .deleteData(SignUpUserSuburl.deleteOneUser.url, {"id": event.id});
      final decodeData = jsonDecode(result.data);
      final data = ResultController.fromMap(decodeData);
      if (result.status == ResultsLevel.fail) {
        AppGetter.appLogger.showLogger(LogLevel.error, data.msg ?? 'error');
        emit(MessagesState(
            msgInfo: data.msg, level: LevelUserSettingsMsg.errorDeleteUser));
        return;
      }
      emit(MessagesState(
          msgInfo: data.msg,
          title: 'Msg',
          level: LevelUserSettingsMsg.deletedUser));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(MessagesState(
          msgInfo: e.toString(), level: LevelUserSettingsMsg.catchError));
    }
  }

  void _editeUserDate(
      EditeUserEvents event, Emitter<UserSettingsStates> emit) async {
    try {
      if (event.pass!.length > 1) {
        if (!_isPasswordStrong(event.pass!)) {
          emit(ShowFormSginUpState(
              msgInfo: '', level: LevelUserSettingsMsg.weakPassWord));
          return;
        }
      }

      emit(LoudingState());

      final editeUser = UserModel(
          userId: event.id,
          userName: event.name,
          passWord: event.pass,
          address: event.address,
          per: event.per);

      final body = editeUser.toJson(UserJsonType.edit);
      ResultController res = await AppGetter.httpSrv
          .putData(SignUpUserSuburl.editeOneUser.url, body, isAuth: true);
      final decode = jsonDecode(res.data);
      final data = ResultController.fromMap(decode);
      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger.showLogger(LogLevel.error, data.msg ?? 'error');
        emit(MessagesState(
            msgInfo: data.msg, level: LevelUserSettingsMsg.errorEditeUser));
        return;
      }
      emit(MessagesState(
          msgInfo: data.msg, title: '',level: LevelUserSettingsMsg.editedUser));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(MessagesState(
          level: LevelUserSettingsMsg.catchError, msgInfo: e.toString()));
    }
  }
}
