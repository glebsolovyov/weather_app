final class User {
  const User(  {
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.isLogin,
  });

  final int id;
  final String email;
  final String password;
  final String name;
  final String surname;
  final int isLogin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
        isLogin: json["isLogin"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "password": password,
      "name": name,
      "surname": surname,
      "isLogin": isLogin,
    };
  }
}
