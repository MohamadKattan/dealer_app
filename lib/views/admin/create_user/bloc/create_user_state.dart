abstract class UserSettingsStates {}

class InitialState extends UserSettingsStates {}

class ShowHidePassWordState extends UserSettingsStates {
  bool isShow;
  ShowHidePassWordState(this.isShow);
}

class SignUpUserState extends UserSettingsStates {
  bool? isLouding;
  String? msg;
  SignUpUserState({this.isLouding, this.msg});
}
