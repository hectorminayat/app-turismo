import 'dart:convert';

import 'package:discoverrd/app/models/tour_dates.dart';

class TourRating {
  TourRating({this.id, this.tourId, this.userId, this.rating, this.comment});

  int? id;
  int? tourId;
  int? userId;
  double? rating;
  String? comment;

  factory TourRating.fromRawJson(String str) =>
      TourRating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  TourRating copyWith(
          {int? id,
          int? tourId,
          int? userId,
          double? rating,
          String? comment}) =>
      TourRating(
          id: id ?? this.id,
          tourId: tourId ?? this.tourId,
          userId: userId ?? this.userId,
          rating: rating ?? this.rating,
          comment: comment ?? this.comment);

  factory TourRating.fromJson(Map<String, dynamic> json) => TourRating(
        id: json["id"],
        tourId: json["tourId"],
        userId: json["userId"],
        rating: json["rating"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourId": tourId,
        "userId": userId,
        "rating": rating,
        "comment": comment,
      };
}
