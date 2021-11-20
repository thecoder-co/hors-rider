import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<SendOtp> resendOtp() async {
  Uri url = Uri.parse(AppUrl.resendOTP);
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
  );
  Get.back();
  if (response.statusCode == 200) {
    return resendOtpFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

Future<SendOtp> resendEmailOtp() async {
  Uri url = Uri.parse(AppUrl.resendEmailOTP);
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
  );
  Get.back();
  if (response.statusCode == 200) {
    return resendOtpFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

SendOtp resendOtpFromJson(String str) => SendOtp.fromJson(json.decode(str));

String resendOtpToJson(SendOtp data) => json.encode(data.toJson());

class SendOtp {
  SendOtp({
    this.status,
    this.code,
  });

  bool? status;
  int? code;

  factory SendOtp.fromJson(Map<String, dynamic> json) => SendOtp(
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
      };
}
