import 'dart:convert';

class TourPrice {
  TourPrice({
    this.id,
    required this.adultPrice,
    required this.kidPrice,
    required this.enableKidPrice,
  });

  final double? id;
  final double adultPrice;
  final double kidPrice;
  final bool enableKidPrice;

  TourPrice copyWith({
    double? id,
    double? adultPrice,
    double? kidPrice,
    bool? enableKidPrice,
  }) =>
      TourPrice(
        id: id ?? this.id,
        adultPrice: adultPrice ?? this.adultPrice,
        kidPrice: kidPrice ?? this.kidPrice,
        enableKidPrice: enableKidPrice ?? this.enableKidPrice,
      );

  factory TourPrice.fromRawJson(String str) =>
      TourPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourPrice.fromJson(Map<String, dynamic> json) => TourPrice(
        id: json["id"] == null ? null : json["id"],
        adultPrice: json["adultPrice"] == null ? null : json["adultPrice"],
        kidPrice: json["kidPrice"] == null ? null : json["kidPrice"],
        enableKidPrice:
            json["enableKidPrice"] == null ? null : json["enableKidPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "adultPrice": adultPrice,
        "kidPrice": kidPrice,
        "enableKidPrice": enableKidPrice,
      };
}
