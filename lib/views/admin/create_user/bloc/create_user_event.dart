abstract class UserSettingsEvents {}

class ShowHidePassWordEvent extends UserSettingsEvents {
  bool show;
  ShowHidePassWordEvent(this.show);
}

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
