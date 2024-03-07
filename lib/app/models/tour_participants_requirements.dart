import 'dart:convert';

class TourParticipantsRequirements {
    TourParticipantsRequirements({
        this.id,
        this.minAge,
        this.kidAge,
        this.optional,
    });

    final int? id;
    final int? minAge;
    final int? kidAge;
    final String? optional;

    TourParticipantsRequirements copyWith({
        int? id,
        int? minAge,
        int? kidAge,
        String? optional,
    }) => 
        TourParticipantsRequirements(
            id: id ?? this.id,
            minAge: minAge ?? this.minAge,
            kidAge: kidAge ?? this.kidAge,
            optional: optional ?? this.optional,
        );

    factory TourParticipantsRequirements.fromRawJson(String str) => TourParticipantsRequirements.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TourParticipantsRequirements.fromJson(Map<String, dynamic> json) => TourParticipantsRequirements(
        id: json["id"] == null ? null : json["id"],
        minAge: json["minAge"] == null ? null : json["minAge"],
        kidAge: json["kidAge"] == null ? null : json["kidAge"],
        optional: json["optional"] == null ? null : json["optional"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "minAge": minAge == null ? null : minAge,
        "kidAge": kidAge == null ? null : kidAge,
        "optional": optional == null ? null : optional,
    };
}
