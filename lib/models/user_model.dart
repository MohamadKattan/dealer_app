enum UserJsonType { sginUp, logIn }

class User {
  String? userName;
  String? passWord;
  String? per;
  String? address;
  String? token;
  int? userId;

  User(
      {this.userName,
      this.per,
      this.userId,
      this.passWord,
      this.address,
      this.token});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        userId: map['user_id'],
        userName: map['user_name'],
        per: map['per'],
        address: map['address'],
        token: map['token']);
  }
  
  Map<String, dynamic> toJson(UserJsonType type) {
    switch (type) {
      case UserJsonType.sginUp:
        return {
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
