import '../tour_dates_rage.dart';

class TourSeachDto {
  TourSeachDto(
      {this.location,
      this.minAge,
      this.tourDateRage,
      this.minPrice,
      this.maxPrice});

  final String? location;
  final int? minAge;
  final TourDatesRage? tourDateRage;
  final double? minPrice;
  final double? maxPrice;

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location,
        "duration": minAge == null ? null : minAge,
        "tourDateRage": tourDateRage == null ? null : tourDateRage!.toJson(),
        "minPrice": minPrice == null ? null : minPrice,
        "maxPrice": maxPrice == null ? null : maxPrice
      };
}
