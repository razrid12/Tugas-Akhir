class User {
  final String username;
  final String email;
  final String phone;
  final String password;

  User(
      {required this.username,
      required this.email,
      required this.phone,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }
}
