// To parse this JSON data, do
//
//     final tour = tourFromJson(jsonString);

import 'dart:convert';

import 'package:discoverrd/app/models/tour_dates.dart';
import 'package:discoverrd/app/models/tour_dates_rage.dart';
import 'package:discoverrd/app/models/tour_meeting_place.dart';
import 'package:discoverrd/app/models/tour_participants_requirements.dart';

Tour tourFromJson(String str) => Tour.fromJson(json.decode(str));

String tourToJson(Tour data) => json.encode(data.toJson());

class Tour {
  Tour(
      {this.id,
      this.title,
      this.description,
      this.location,
      this.durationType,
      this.duration,
      this.tourMeetingPlaceId,
      this.tourParticipantsRequirementsId,
      this.adultPrice,
      this.kidPrice,
      this.rating,
      this.enableKidPrice,
      this.agencyId,
      this.statusId,
      this.tourStatusId,
      this.status,
      this.tourStatus,
      this.tourMeetingPlace,
      this.tourParticipantsRequirements,
      this.tourDates,
      this.tourDatesRages,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.includesList,
      this.like});

  final int? id;
  final String? title;
  final String? description;
  final String? location;
  final int? durationType;
  final int? duration;
  final int? tourMeetingPlaceId;
  final int? tourParticipantsRequirementsId;
  final double? adultPrice;
  final double? kidPrice;
  final double? rating;
  final bool? enableKidPrice;
  final int? agencyId;
  final int? statusId;
  final int? tourStatusId;
  final int? status;
  final int? tourStatus;
  final TourMeetingPlace? tourMeetingPlace;
  final TourParticipantsRequirements? tourParticipantsRequirements;
  final List<TourDates>? tourDates;
  final List<TourDatesRage>? tourDatesRages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<int>? includesList;
  final bool? like;

  Tour copyWith(
          {int? id,
          String? title,
          String? description,
          String? location,
          int? durationType,
          int? duration,
          int? tourMeetingPlaceId,
          int? tourParticipantsRequirementsId,
          double? adultPrice,
          double? kidPrice,
          double? rating,
          bool? enableKidPrice,
          int? agencyId,
          int? statusId,
          int? tourStatusId,
          int? status,
          int? tourStatus,
          TourMeetingPlace? tourMeetingPlace,
          TourParticipantsRequirements? tourParticipantsRequirements,
          List<TourDates>? tourDates,
          List<TourDatesRage>? tourDatesRages,
          DateTime? createdAt,
          DateTime? updatedAt,
          DateTime? deletedAt,
          List<int>? includesList,
          bool? like}) =>
      Tour(
          title: title ?? this.title,
          description: description ?? this.description,
          location: location ?? this.location,
          durationType: durationType ?? this.durationType,
          duration: duration ?? this.duration,
          tourMeetingPlaceId: tourMeetingPlaceId ?? this.tourMeetingPlaceId,
          tourParticipantsRequirementsId: tourParticipantsRequirementsId ??
              this.tourParticipantsRequirementsId,
          adultPrice: adultPrice ?? this.adultPrice,
          kidPrice: kidPrice ?? this.kidPrice,
          rating: rating ?? this.rating,
          enableKidPrice: enableKidPrice ?? this.enableKidPrice,
          agencyId: agencyId ?? this.agencyId,
          statusId: statusId ?? this.statusId,
          tourStatusId: tourStatusId ?? this.tourStatusId,
          status: status ?? this.status,
          tourStatus: tourStatus ?? this.tourStatus,
          tourMeetingPlace: tourMeetingPlace ?? this.tourMeetingPlace,
          tourParticipantsRequirements:
              tourParticipantsRequirements ?? this.tourParticipantsRequirements,
          tourDates: tourDates ?? this.tourDates,
          tourDatesRages: tourDatesRages ?? this.tourDatesRages,
          id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          deletedAt: deletedAt ?? this.deletedAt,
          includesList: includesList ?? this.includesList,
          like: like ?? this.like);

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      location: json["location"] == null ? null : json["location"],
      durationType: json["durationType"] == null ? null : json["durationType"],
      duration: json["duration"] == null ? null : json["duration"],
      tourMeetingPlaceId: json["tourMeetingPlaceId"] == null
          ? null
          : json["tourMeetingPlaceId"],
      tourParticipantsRequirementsId:
          json["tourParticipantsRequirementsId"] == null
              ? null
              : json["tourParticipantsRequirementsId"],
      adultPrice:
          json["adultPrice"] == null ? null : json["adultPrice"].toDouble(),
      kidPrice: json["kidPrice"] == null ? null : json["kidPrice"].toDouble(),
      rating: json["rating"] == null ? null : json["rating"].toDouble(),
      enableKidPrice:
          json["enableKidPrice"] == null ? null : json["enableKidPrice"],
      agencyId: json["agencyId"] == null ? null : json["agencyId"],
      statusId: json["statusId"] == null ? null : json["statusId"],
      tourStatusId: json["tourStatusId"] == null ? null : json["tourStatusId"],
      status: json["status"] == null ? null : json["status"],
      tourStatus: json["tourStatus"] == null ? null : json["tourStatus"],
      tourMeetingPlace: json["tourMeetingPlace"] == null
          ? null
          : TourMeetingPlace.fromJson(json["tourMeetingPlace"]),
      tourParticipantsRequirements: json["tourParticipantsRequirements"] == null
          ? null
          : TourParticipantsRequirements.fromJson(
              json["tourParticipantsRequirements"]),
      tourDates: json["tourDates"] == null
          ? null
          : List<TourDates>.from(
              json["tourDates"].map((x) => TourDates.fromJson(x))),
      tourDatesRages: json["tourDatesRages"] == null
          ? null
          : List<TourDatesRage>.from(
              json["tourDatesRages"].map((x) => TourDatesRage.fromJson(x))),
      id: json["id"] == null ? null : json["id"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      deletedAt:
          json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
      includesList: json["includesList"] == null
          ? null
          : List<int>.from(json["includesList"]),
      like: json["like"] == null ? null : json["like"]);

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "location": location == null ? null : location,
        "durationType": durationType == null ? null : durationType,
        "duration": duration == null ? null : duration,
        "tourMeetingPlaceId":
            tourMeetingPlaceId == null ? null : tourMeetingPlaceId,
        "tourParticipantsRequirementsId": tourParticipantsRequirementsId == null
            ? null
            : tourParticipantsRequirementsId,
        "adultPrice": adultPrice == null ? null : adultPrice,
        "kidPrice": kidPrice == null ? null : kidPrice,
        "rating": rating == null ? null : rating,
        "enableKidPrice": enableKidPrice == null ? null : enableKidPrice,
        "agencyId": agencyId == null ? null : agencyId,
        "statusId": statusId == null ? null : statusId,
        "tourStatusId": tourStatusId == null ? null : tourStatusId,
        "status": status == null ? null : status,
        "tourStatus": tourStatus == null ? null : tourStatus,
        "tourMeetingPlace":
            tourMeetingPlace == null ? null : tourMeetingPlace!.toJson(),
        "tourParticipantsRequirements": tourParticipantsRequirements == null
            ? null
            : tourParticipantsRequirements!.toJson(),
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deletedAt": deletedAt == null ? null : deletedAt!.toIso8601String(),
      };
}
