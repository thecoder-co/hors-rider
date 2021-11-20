import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';

import 'package:rider/util/app_url.dart';

import 'dart:convert';

Future<ForgotPassword> forgotPassword({required String? email}) async {
  Uri url = Uri.parse(AppUrl.forgotPassword);
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
      {'email': email!},
    ),
  );
  Get.back();

  if (response.statusCode == 200) {
    return forgotPasswordFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ForgotPassword forgotPasswordFromJson(String str) =>
    ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  ForgotPassword({
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

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
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
    this.token,
    this.email,
  });

  String? token;
  String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["reset_token"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
      };
}
