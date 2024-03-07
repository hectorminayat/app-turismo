// To parse this JSON data, do
//
//     final customerView = customerViewFromJson(jsonString);

import 'dart:convert';

CustomerView customerViewFromJson(String str) =>
    CustomerView.fromJson(json.decode(str));

String customerViewToJson(CustomerView data) => json.encode(data.toJson());

class CustomerView {
  CustomerView({
    this.userId,
    this.name,
    this.email,
    this.lastName,
    this.phone,
    this.sex,
    this.image,
    this.birthdate,
  });

  final int? userId;
  final String? name;
  final String? email;
  final String? lastName;
  final String? phone;
  final int? sex;
  final String? image;
  final DateTime? birthdate;

  CustomerView copyWith({
    int? userId,
    String? name,
    String? email,
    String? lastName,
    String? phone,
    int? sex,
    String? image,
    DateTime? birthdate,
  }) =>
      CustomerView(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        sex: sex ?? this.sex,
        image: image ?? this.image,
        birthdate: birthdate ?? this.birthdate,
      );

  factory CustomerView.fromJson(Map<String, dynamic> json) => CustomerView(
        userId: json["userId"] == null ? null : json["userId"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phone: json["phone"] == null ? null : json["phone"],
        sex: json["sex"] == null ? null : json["sex"],
        image: json["image"] == null ? null : json["image"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "lastName": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "sex": sex == null ? null : sex,
        "image": image == null ? null : image,
        "birthdate": birthdate == null
            ? null
            : "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
      };
}
