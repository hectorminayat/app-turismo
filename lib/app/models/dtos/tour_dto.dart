import 'package:dio/dio.dart';

import '../tour_dates.dart';
import '../tour_dates_rage.dart';
import '../tour_meeting_place.dart';
import '../tour_participants_requirements.dart';

class TourDto {
  TourDto(
      {this.id,
      this.agencyId,
      required this.title,
      required this.description,
      required this.imageFiles,
      required this.imagesSource,
      this.location,
      this.durationType,
      this.duration,
      this.tourStatusId,
      this.tourMeetingPlace,
      this.tourParticipantsRequirements,
      this.includes,
      this.tourDates,
      this.tourDatesRage,
      this.adultPrice,
      this.kidPrice,
      this.enableKidPrice});

  final int? id;
  final String title;
  final int? agencyId;
  final String description;
  final String? location;
  final int? tourStatusId;
  final int? durationType;
  final int? duration;
  final List<MultipartFile> imageFiles;
  final List<String?> imagesSource;
  final TourMeetingPlace? tourMeetingPlace;
  final TourParticipantsRequirements? tourParticipantsRequirements;
  final List<int>? includes;
  final List<TourDates?>? tourDates;
  final List<TourDatesRage?>? tourDatesRage;
  final double? adultPrice;
  final double? kidPrice;
  final bool? enableKidPrice;

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "agencyId": agencyId == null ? null : agencyId,
        "title": title,
        "description": description,
        "imageFiles": imageFiles == null ? null : imageFiles,
        "imagesSource":
            imagesSource == null ? null : imagesSource.map((e) => e).toList(),
        "location": location == null ? null : location,
        "tourStatusId": tourStatusId == null ? null : tourStatusId,
        "durationType": durationType == null ? null : durationType,
        "duration": duration == null ? null : duration,
        "tourMeetingPlace":
            tourMeetingPlace == null ? null : tourMeetingPlace!.toJson(),
        "tourParticipantsRequirements": tourParticipantsRequirements == null
            ? null
            : tourParticipantsRequirements!.toJson(),
        "tourDates": tourDates == null
            ? null
            : tourDates != null
                ? tourDates!.map((i) => i!.toJson()).toList()
                : null,
        "tourDatesRage": tourDatesRage == null
            ? null
            : tourDatesRage != null
                ? tourDatesRage!.map((i) => i!.toJson()).toList()
                : null,
        "adultPrice": adultPrice == null ? null : adultPrice,
        "kidPrice": kidPrice == null ? null : kidPrice,
        "enableKidPrice": enableKidPrice == null ? false : enableKidPrice,
        "includes": includes == null ? null : includes!.map((e) => e).toList()
      };
}
