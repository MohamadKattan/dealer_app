import 'package:dealer/models/user_model.dart';

abstract class UserSettingsStates {}

class InitialState extends UserSettingsStates {}

class LoudingState extends UserSettingsStates {}

class ErrorState extends UserSettingsStates {
  String? msg;
  ErrorState(this.msg);
}

class ShowFormSginUpState extends UserSettingsStates {
  bool? showPass;
  String? titleMsg;
  String? msg;
  ShowFormSginUpState({this.showPass, this.titleMsg, this.msg});
}

class SignUpUserState extends UserSettingsStates {
  String? msg;
  SignUpUserState({this.msg});
}

class GetAllUsersState extends UserSettingsStates {
  List<UserModel>? data;
  GetAllUsersState({this.data});
}
