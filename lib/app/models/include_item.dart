import 'dart:convert';

class IncludeItem {
    IncludeItem({
        this.id,
        this.name,
        this.includeCategoryId
    });

    int? id;
    String? name;
    int? includeCategoryId;

    factory IncludeItem.fromRawJson(String str) => IncludeItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory IncludeItem.fromJson(Map<String, dynamic> json) => IncludeItem(
        id: json["id"],
        name: json["name"],
        includeCategoryId: json["includeCategoryId"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "includeCategoryId": includeCategoryId
    };
}
