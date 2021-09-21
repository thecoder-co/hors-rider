class User {
  String? email;

  String? token;

  User({
    this.email,
    this.token,
  });

  factory User.fromJson({String? responseData, String? email}) {
    return User(
      email: email,
      token: responseData,
    );
  }
}
