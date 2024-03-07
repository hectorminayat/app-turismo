import 'dart:convert';
import 'package:discoverrd/app/models/invoice.dart';

import 'tour.dart';

List<TourReserveView> tourReserveViewFromJson(String str) =>
    List<TourReserveView>.from(
        json.decode(str).map((x) => TourReserveView.fromJson(x)));

String tourReserveViewToJson(List<TourReserveView> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourReserveView {
  TourReserveView({this.id, this.tour, this.images, this.invoice});

  final int? id;
  final Tour? tour;
  final Invoice? invoice;
  final List<String>? images;

  TourReserveView copyWith({
    int? id,
    Tour? tour,
    Invoice? invoice,
    List<String>? images,
  }) =>
      TourReserveView(
        id: id,
        tour: tour,
        invoice: invoice,
        images: images,
      );

  factory TourReserveView.fromJson(Map<String, dynamic> json) =>
      TourReserveView(
        id: json["id"] == null ? null : json["id"],
        tour: Tour.fromJson(json["tour"]),
        invoice: Invoice.fromJson(json["invoice"]),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tour": tour!.toJson(),
        "invoice": invoice!.toJson(),
        "images": List<String>.from(images!.map((x) => x)),
      };
}
