import 'dart:convert';

class TourDates {
  TourDates({
    this.id,
    this.tourId,
    this.date,
  });

  final int? id;
  final int? tourId;
  final DateTime? date;

  TourDates copyWith({
    int? id,
    int? tourId,
    DateTime? date,
  }) =>
      TourDates(
        id: id ?? this.id,
        tourId: tourId ?? this.tourId,
        date: date ?? this.date,
      );

  factory TourDates.fromRawJson(String str) =>
      TourDates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourDates.fromJson(Map<String, dynamic> json) => TourDates(
        id: json["id"] == null ? null : json["id"],
        tourId: json["tourId"] == null ? null : json["tourId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tourId": tourId == null ? null : tourId,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
