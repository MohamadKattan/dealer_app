abstract class UserSettingsEvents {}

class InitialEvent extends UserSettingsEvents {}

class ShowHidePassWordEvent extends UserSettingsEvents {
  bool show;
  ShowHidePassWordEvent(this.show);
}

class ShowFormSignUpEvent extends UserSettingsEvents {
  String? name;
  String? per;
  String? address;
  bool? isForEidet = false;
  ShowFormSignUpEvent({this.name, this.address, this.per, this.isForEidet});
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

class GetAllUsersEvent extends UserSettingsEvents {}

class DeleteOneUserEvent extends UserSettingsEvents {
  int id;
  DeleteOneUserEvent({required this.id});
}

class EditeUserEvents extends UserSettingsEvents {
  String name;
  String? pass;
  String address;
  String per;
  EditeUserEvents({required this.name,required this.address,required this.per,this.pass});
}
