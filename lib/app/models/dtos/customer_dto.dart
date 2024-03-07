import 'package:dio/dio.dart';

class CustomerDto {
  CustomerDto(
      {this.userId,
      this.name,
      this.lastName,
      this.phone,
      this.sex,
      this.birthdate,
      this.image});

  final int? userId;
  final String? name;
  final String? lastName;
  final String? phone;
  final int? sex;
  final DateTime? birthdate;
  final MultipartFile? image;

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "lastName": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "sex": sex == null ? null : sex,
        "image": image == null ? null : image,
        "birthdate": birthdate == null
            ? null
            : "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
      };

  CustomerDto copyWith({
    int? userId,
    String? name,
    String? lastName,
    String? phone,
    int? sex,
    MultipartFile? image,
    DateTime? birthdate,
  }) =>
      CustomerDto(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        sex: sex ?? this.sex,
        image: image ?? this.image,
        birthdate: birthdate ?? this.birthdate,
      );
}
