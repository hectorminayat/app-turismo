// To parse this JSON data, do
//
//     final tour = tourFromJson(jsonString);

import 'dart:convert';

Invoice tourFromJson(String str) => Invoice.fromJson(json.decode(str));

String tourToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  Invoice(
      {this.id,
      this.userId,
      this.tourId,
      this.paymentIntent,
      this.adults,
      this.kids,
      this.amount,
      this.date,
      this.date2,
      this.statusId,
      this.createdAt});

  final int? id;
  final int? userId;
  final int? tourId;
  final String? paymentIntent;
  final int? adults;
  final int? kids;
  final double? amount;
  final int? statusId;
  final DateTime? date;
  final DateTime? date2;
  final DateTime? createdAt;

  Invoice copyWith(
          {int? id,
          int? userId,
          int? tourId,
          String? paymentIntent,
          int? adults,
          int? kids,
          double? amount,
          int? statusId,
          DateTime? date,
          DateTime? date2,
          DateTime? createdAt}) =>
      Invoice(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          tourId: tourId ?? this.tourId,
          paymentIntent: paymentIntent ?? this.paymentIntent,
          adults: adults ?? this.adults,
          kids: kids ?? this.kids,
          amount: amount ?? this.amount,
          statusId: statusId ?? this.statusId,
          date: date ?? this.date,
          date2: date2 ?? this.date2,
          createdAt: createdAt ?? this.createdAt);

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json["id"] == null ? null : json["id"],
      userId: json["userId"] == null ? null : json["userId"],
      tourId: json["tourId"] == null ? null : json["tourId"],
      paymentIntent:
          json["paymentIntent"] == null ? null : json["paymentIntent"],
      adults: json["adults"] == null ? null : json["adults"],
      kids: json["kids"] == null ? null : json["kids"],
      amount: json["amount"] == null ? null : json["amount"].toDouble(),
      statusId: json["statusId"] == null ? null : json["statusId"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      date2: json["date2"] == null ? null : DateTime.parse(json["date2"]),
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "tourId": tourId == null ? null : tourId,
        "paymentIntent": paymentIntent == null ? null : paymentIntent,
        "adults": adults == null ? null : adults,
        "kids": kids == null ? null : kids,
        "amount": amount == null ? null : amount,
        "statusId": statusId == null ? null : statusId,
        "date": date == null ? null : date!.toIso8601String(),
        "date2": date2 == null ? null : date2!.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
