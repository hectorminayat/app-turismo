class TourMeetingPlace {
  TourMeetingPlace({
    this.id,
    this.address,
    this.hour,
    this.description,
  });

  final int? id;
  final String? address;
  final String? hour;
  final String? description;

  TourMeetingPlace copyWith({
    int? id,
    String? address,
    String? hour,
    String? description,
  }) =>
      TourMeetingPlace(
        id: id ?? this.id,
        address: address ?? this.address,
        hour: hour ?? this.hour,
        description: description ?? this.description,
      );

  factory TourMeetingPlace.fromJson(Map<String, dynamic> json) =>
      TourMeetingPlace(
        id: json["id"] == null ? null : json["id"],
        address: json["address"] == null ? null : json["address"],
        hour: json["hour"] == null ? null : json["hour"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address": address == null ? null : address,
        "hour": hour == null ? null : hour,
        "description": description == null ? null : description,
      };
}
