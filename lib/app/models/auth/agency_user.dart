import 'dart:convert';
import 'package:dio/dio.dart';

class AgencyUser {
    AgencyUser({
        required this.name,
        required this.rnc,
        required this.email,
        required this.password,
        this.address,
        this.city,
        this.phone,
        this.website,
        this.document,
        this.image
    });

    final String name;
    final String rnc;
    final String email;
    final String password;
    final String? address;
    final String? city;
    final String? phone;
    final String? website;
    final MultipartFile? document;
    final MultipartFile? image;

    factory AgencyUser.fromRawJson(String str) => AgencyUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AgencyUser.fromJson(Map<String, dynamic> json) => AgencyUser(
        name: json["name"],
        rnc: json["rnc"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        city: json["city"],
        phone: json["phone"],
        website: json["website"],
        document: json["document"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "rnc": rnc,
        "email": email,
        "password": password,
        "address": address,
        "city": city,
        "phone": phone,
        "website": website,
        'document': document,
        'image': image
    };
}
