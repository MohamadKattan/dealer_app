class User {
  String? userName;
  String? token;
  String? passWord;
  String? per;
  int? userId;

  User({this.userName, this.per, this.userId, this.token, this.passWord});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      token: map['token'],
      userName: map['user_name'],
      per: map['per'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"userName": userName, "passWord": passWord};
  }
}
