import 'dart:convert';

AgencyView agencyViewFromJson(String str) =>
    AgencyView.fromJson(json.decode(str));

String agencyViewToJson(AgencyView data) => json.encode(data.toJson());

class AgencyView {
  AgencyView({
    this.userId,
    this.name,
    this.rnc,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.image,
  });

  final int? userId;
  final String? name;
  final String? rnc;
  final String? address;
  final String? website;
  final String? email;
  final String? phone;
  final String? image;

  AgencyView copyWith(
          {int? userId,
          String? name,
          String? rnc,
          String? address,
          String? website,
          String? email,
          String? phone,
          String? image}) =>
      AgencyView(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        rnc: rnc ?? this.rnc,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        image: image ?? this.image,
        website: website ?? this.website,
      );

  factory AgencyView.fromJson(Map<String, dynamic> json) => AgencyView(
        userId: json["userId"] == null ? null : json["userId"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        rnc: json["rnc"] == null ? null : json["rnc"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        image: json["image"] == null ? null : json["image"],
        website: json["website"] == null ? null : json["website"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "rnc": rnc == null ? null : rnc,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "image": image == null ? null : image,
        "website": website == null ? null : website,
      };
}
