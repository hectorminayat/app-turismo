import 'dart:convert';

class CustomerUser {
    CustomerUser({
        required this.name,
        this.lastName,
        required this.email,
        required this.password,
    });

    final String name;
    final String? lastName;
    final String email;
    final String password;

    factory CustomerUser.fromRawJson(String str) => CustomerUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CustomerUser.fromJson(Map<String, dynamic> json) => CustomerUser(
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "password": password,
    };
}
