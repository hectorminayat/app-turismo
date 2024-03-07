import 'dart:convert';
import 'tour.dart';

List<TourView> tourViewFromJson(String str) =>
    List<TourView>.from(json.decode(str).map((x) => TourView.fromJson(x)));

String tourViewToJson(List<TourView> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourView {
  TourView({
    this.tour,
    this.images,
  });

  final Tour? tour;
  final List<String>? images;

  TourView copyWith({
    Tour? tour,
    List<String>? images,
  }) =>
      TourView(
        tour: tour,
        images: images,
      );

  factory TourView.fromJson(Map<String, dynamic> json) => TourView(
        tour: Tour.fromJson(json["tour"]),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tour": tour!.toJson(),
        "images": List<String>.from(images!.map((x) => x)),
      };
}
