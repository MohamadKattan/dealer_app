abstract class UserSettingsEvents {}

class InitialEvent extends UserSettingsEvents {}

class ShowHidePassWordEvent extends UserSettingsEvents {
  bool show;
  ShowHidePassWordEvent(this.show);
}

class ShowFormSignUpEvent extends UserSettingsEvents {}

class SginUpUserEvent extends UserSettingsEvents {
  String userName;
  String passWord;
  String? address;
  String per;
  SginUpUserEvent(
      {required this.userName,
      required this.passWord,
      required this.per,
      this.address});
}

class GetAllUsersEvent extends UserSettingsEvents {}
