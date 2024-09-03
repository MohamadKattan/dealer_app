class User {
  String? userName;
  String? passWord;
  String? per;
  String? token;
  int? userId;

  User({this.userName, this.per, this.userId, this.passWord, this.token});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        userId: map['user_id'],
        userName: map['user_name'],
        per: map['per'],
        token: map['token']);
  }
  Map<String, dynamic> toJson() {
    return {"userName": userName, "passWord": passWord};
  }
}
