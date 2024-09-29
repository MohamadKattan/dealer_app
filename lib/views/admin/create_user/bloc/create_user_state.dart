abstract class UserSettingsStates {}

class InitialState extends UserSettingsStates {}

class LoudingState extends UserSettingsStates {}

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

class GetAllUsersState<T> extends UserSettingsStates {
  T? data;
  GetAllUsersState({this.data});
}
