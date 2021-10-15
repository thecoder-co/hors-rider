import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<VerificationStatus> checkVerified() async {
  Uri url = Uri.parse(AppUrl.verificationStatus);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  http.Response response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    return verificationStatusFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

VerificationStatus verificationStatusFromJson(String str) =>
    VerificationStatus.fromJson(json.decode(str));

String verificationStatusToJson(VerificationStatus data) =>
    json.encode(data.toJson());

class VerificationStatus {
  VerificationStatus({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;
  int? timestamp;

  factory VerificationStatus.fromJson(Map<String, dynamic> json) =>
      VerificationStatus(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data!.toJson(),
        "timestamp": timestamp,
      };
}

class Data {
  Data({
    this.phoneVerificationStatus,
    this.emailVerificationStatus,
  });

  int? phoneVerificationStatus;
  int? emailVerificationStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneVerificationStatus: json["phone_verification_status"],
        emailVerificationStatus: json["email_verification_status"],
      );

  Map<String, dynamic> toJson() => {
        "phone_verification_status": phoneVerificationStatus,
        "email_verification_status": emailVerificationStatus,
      };
}
