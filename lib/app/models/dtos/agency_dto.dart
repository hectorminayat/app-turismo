import 'package:dio/dio.dart';

class AgencyDto {
  AgencyDto(
      {this.userId,
      this.name,
      this.rnc,
      this.phone,
      this.address,
      this.website,
      this.image});

  final int? userId;
  final String? name;
  final String? rnc;
  final String? address;
  final String? website;
  final String? phone;
  final MultipartFile? image;

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "rnc": rnc == null ? null : rnc,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "website": website == null ? null : website,
        "image": image == null ? null : image,
      };

  AgencyDto copyWith({
    int? userId,
    String? name,
    String? rnc,
    String? phone,
    String? address,
    MultipartFile? image,
    String? website,
  }) =>
      AgencyDto(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        rnc: rnc ?? this.rnc,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        image: image ?? this.image,
        website: website ?? this.website,
      );
}
