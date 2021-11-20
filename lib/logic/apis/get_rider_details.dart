import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<RiderDetails> getRiderDetails({required String riderId}) async {
  Uri url = Uri.parse(AppUrl.riderDetails + riderId);
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
    return riderDetailsFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

RiderDetails riderDetailsFromJson(String str) =>
    RiderDetails.fromJson(json.decode(str));

String riderDetailsToJson(RiderDetails data) => json.encode(data.toJson());

class RiderDetails {
  RiderDetails({
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

  factory RiderDetails.fromJson(Map<String, dynamic> json) => RiderDetails(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
        "timestamp": timestamp == null ? null : timestamp,
      };
}

class Data {
  Data({
    this.surname,
    this.firstName,
    this.gender,
    this.maritalStatus,
    this.email,
    this.phoneNumber,
    this.profilePhoto,
    this.address,
    this.trustScore,
    this.totalReview,
    this.performance,
    this.rating,
    this.totalJobCompleted,
  });

  String? surname;
  String? firstName;
  String? gender;
  String? maritalStatus;
  String? email;
  String? phoneNumber;
  String? profilePhoto;
  String? address;
  String? trustScore;
  String? performance;
  String? rating;
  int? totalReview;
  int? totalJobCompleted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surname: json["surname"] == null ? null : json["surname"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        profilePhoto: json["profile_photo"],
        address: json["address"] == null ? null : json["address"],
        trustScore: json["trust_score"] == null ? null : json["trust_score"],
        totalReview: json["total_review"] == null ? null : json["total_review"],
        performance: json["performance"] == null ? null : json["performance"],
        rating: json["rating"] == null ? null : json["rating"],
        totalJobCompleted: json["total_job_completed"] == null
            ? null
            : json["total_job_completed"],
      );

  Map<String, dynamic> toJson() => {
        "surname": surname == null ? null : surname,
        "first_name": firstName == null ? null : firstName,
        "gender": gender,
        "marital_status": maritalStatus,
        "email": email == null ? null : email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "profile_photo": profilePhoto,
        "address": address == null ? null : address,
        "trust_score": trustScore == null ? null : trustScore,
        "total_review": totalReview == null ? null : totalReview,
        "performance": performance == null ? null : performance,
        "rating": rating == null ? null : rating,
        "total_job_completed":
            totalJobCompleted == null ? null : totalJobCompleted,
      };
}
