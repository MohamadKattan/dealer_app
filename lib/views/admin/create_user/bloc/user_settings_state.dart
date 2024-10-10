import 'package:dealer/models/user_model.dart';
import 'package:dealer/views/admin/create_user/bloc/user_settings_bloc.dart';

abstract class UserSettingsStates {}

class InitialState extends UserSettingsStates {}

class LoudingState extends UserSettingsStates {}

class MessagesState extends UserSettingsStates {
  String? title;
  String? msgInfo;
  LevelUserSettingsMsg? level;
  MessagesState({this.msgInfo, this.level, this.title});
}

class ShowFormSginUpState extends UserSettingsStates {
  bool? showPass;
  String? title;
  String? msgInfo;
  String? userName;
  String? address;
  String? per;
  String? passWord;
  int? userId;
  bool? isForEidet = false;
  LevelUserSettingsMsg? level;
  ShowFormSginUpState(
      {this.showPass,
      this.title,
      this.msgInfo,
      this.level,
      this.userName,
      this.address,
      this.per,
      this.isForEidet,
      this.userId,
      this.passWord});
}

class SignUpUserState extends UserSettingsStates {
  String? msg;
  SignUpUserState({this.msg});
}

class GetAllUsersState extends UserSettingsStates {
  List<UserModel>? data;
  GetAllUsersState({this.data});
}

// class DeleteOneUserState extends UserSettingsStates {}
