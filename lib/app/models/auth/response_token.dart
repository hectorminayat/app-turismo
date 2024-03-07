import 'dart:convert';

class ResponseToken {
    ResponseToken({
        required this.token,
        required this.expiration,
    });

    final String token;
    final DateTime expiration;

    factory ResponseToken.fromRawJson(String str) => ResponseToken.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseToken.fromJson(Map<String, dynamic> json) => ResponseToken(
        token: json["token"],
        expiration: DateTime.parse(json["expiration"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
    };
}
