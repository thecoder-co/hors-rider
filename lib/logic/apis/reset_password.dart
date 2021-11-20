import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/util/app_url.dart';
import 'dart:convert';

Future<ResetPassword> resetPassword({
  required String? email,
  required String? token,
  required String? password,
}) async {
  Uri url = Uri.parse(AppUrl.resetPassword);

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
    },
    body: json.encode(
      {
        'email': email,
        'reset_token': token,
        'password': password,
        'password_confirmation': password,
      },
    ),
  );
  Get.back();
  if (response.statusCode == 200) {
    return resetPasswordFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ResetPassword resetPasswordFromJson(String str) =>
    ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  ResetPassword({
    this.status,
    this.code,
    this.message,
    this.timestamp,
  });

  bool? status;
  int? code;
  var message;
  int? timestamp;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
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
