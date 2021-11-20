import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<FundWallet> fundWallet({String? amount}) async {
  Uri url = Uri.parse(AppUrl.fundWallet);
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
  http.Response response = await http.post(url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'amount': amount!, 'payment_type': 0}));
  Get.back();
  if (response.statusCode == 200) {
    return fundWalletFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

FundWallet fundWalletFromJson(String str) =>
    FundWallet.fromJson(json.decode(str));

String fundWalletToJson(FundWallet data) => json.encode(data.toJson());

class FundWallet {
  FundWallet({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamps,
  });

  bool? status;
  int? code;
  String? message;
  String? data;
  int? timestamps;

  factory FundWallet.fromJson(Map<String, dynamic> json) => FundWallet(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"],
        timestamps: json["timestamps"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data,
        "timestamps": timestamps,
      };
}
