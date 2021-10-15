import 'package:http/http.dart' as http;
import 'package:rider/util/app_url.dart';
import 'dart:convert';

Future<VerifyOtp> verifyOtpForPasswordReset({
  required String? otp,
  required String? email,
}) async {
  Uri url = Uri.parse(AppUrl.verifyOtpForPasswordReset);

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode(
      {
        'email': email!,
        'otp': otp!,
      },
    ),
  );
  if (response.statusCode == 200) {
    return verifyOtpFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));

String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
  VerifyOtp({
    this.status,
    this.code,
    this.message,
    this.timestamp,
  });

  bool? status;
  int? code;
  String? message;
  int? timestamp;

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "timestamp": timestamp,
      };
}
