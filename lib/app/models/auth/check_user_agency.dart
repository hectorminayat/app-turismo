import 'dart:convert';

class CheckUserAgency {
    CheckUserAgency({
        required this.email,
        required this.rnc,
    });

    final String email;
    final String rnc;

    factory CheckUserAgency.fromRawJson(String str) => CheckUserAgency.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CheckUserAgency.fromJson(Map<String, dynamic> json) => CheckUserAgency(
        email: json["email"],
        rnc: json["rnc"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "rnc": rnc,
    };
}
