import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<UpdateProfile> updateProfile({
  String? lastName,
  String? firstName,
  String? maritalStatus,
  String? address,
  String? gender,
}) async {
  Uri url = Uri.parse(AppUrl.updateProfile);
  User user = await UserPreferences().getUser();
  String token = user.token!;
  Get.defaultDialog(
    content: CircularProgressIndicator(),
    radius: 10,
    title: 'Loading',
    titleStyle: GoogleFonts.getFont(
      'Overlock',
      textStyle: TextStyle(
        fontSize: 16,
        color: kDarkGreen,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: json.encode(
      {
        'surname': lastName,
        'first_name': firstName,
        'gender': gender,
        'marital_status': maritalStatus,
        'address': address,
      },
    ),
  );
  if (response.statusCode == 200) {
    return updateProfileFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

// To parse this JSON data, do
//

UpdateProfile updateProfileFromJson(String str) =>
    UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? status;
  int? code;
  String? message;
  dynamic data;
  int? timestamp;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data,
        "timestamp": timestamp,
      };
}
