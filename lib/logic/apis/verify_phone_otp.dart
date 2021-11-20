import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/screens/client/components/profile_components/verify_otp_page.dart';
import 'package:rider/screens/client/home.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future verifyPhoneOtp({
  required String? otp,
}) async {
  Uri url = Uri.parse(AppUrl.verifyPhoneOtp);
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
    body: json.encode({'otp': otp}),
  );
  Get.back();
  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    if (data['status']) {
      Get.offAll(() => Client());
      Get.defaultDialog(
        content: Text(
          'OTP Verified Successfully',
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(
              fontSize: 16,
              color: kDarkGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        radius: 10,
        title: 'Alert',
        titleStyle: GoogleFonts.getFont(
          'Overlock',
          textStyle: TextStyle(
            fontSize: 16,
            color: kDarkGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.GROUNDED,
          message: data['message'],
          duration: Duration(milliseconds: 3000),
        ),
      );
    }
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to verify otp',
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}

Future verifyEmailOtp({
  required String? otp,
}) async {
  Uri url = Uri.parse(AppUrl.verifyEmailOtp);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: json.encode({'otp': otp}),
  );
  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    if (data['status']) {
      Get.offAll(() => Client());
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.GROUNDED,
          message: data['message'],
          duration: Duration(milliseconds: 3000),
        ),
      );
    } else {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.GROUNDED,
          message: data['message'],
          duration: Duration(milliseconds: 3000),
        ),
      );
    }
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to verify otp',
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}
