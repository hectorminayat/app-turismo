import 'dart:convert';

class TourDatesRage {
  TourDatesRage({
    this.id,
    this.tourId,
    this.startDate,
    this.endDate,
  });

  final int? id;
  final int? tourId;
  final DateTime? startDate;
  final DateTime? endDate;

  TourDatesRage copyWith({
    int? id,
    int? tourId,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      TourDatesRage(
        id: id ?? this.id,
        tourId: tourId ?? this.tourId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory TourDatesRage.fromRawJson(String str) =>
      TourDatesRage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourDatesRage.fromJson(Map<String, dynamic> json) => TourDatesRage(
        id: json["id"] == null ? null : json["id"],
        tourId: json["tourId"] == null ? null : json["tourId"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tourId": tourId == null ? null : tourId,
        "startDate": startDate == null
            ? null
            : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate": endDate == null
            ? null
            : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}
