enum UserJsonType { sgine, logIn, edit, getUsers }

class UserModel {
  String? userName;
  String? passWord;
  String? per;
  String? address;
  String? token;
  int? userId;

  UserModel(
      {this.userName,
      this.per,
      this.userId,
      this.passWord,
      this.address,
      this.token});

  factory UserModel.fromMap(Map<String, dynamic> map, {UserJsonType? type}) {
    switch (type) {
      case UserJsonType.getUsers:
        return UserModel(
            userId: map['id'],
            passWord: map['pass_word'],
            userName: map['user_name'],
            per: map['per'],
            address: map['address'],
            token: map['token']);

      default:
        return UserModel(
            userId: map['user_id'],
            userName: map['user_name'],
            per: map['per'],
            address: map['address'],
            token: map['token']);
    }
  }

  Map<String, dynamic> toJson(UserJsonType type) {
    switch (type) {
      case UserJsonType.sgine:
        return {
          "userName": userName,
          "passWord": passWord,
          "address": address,
          "per": per
        };
      case UserJsonType.edit:
        return {
          "userId": userId,
          "userName": userName,
          "passWord": passWord,
          "address": address,
          "per": per
        };
      case UserJsonType.logIn:
        return {"userName": userName, "passWord": passWord};
      default:
        return {"userName": userName, "passWord": passWord};
    }
  }
}
