import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/screens/client/home.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future sendReport({
  required String? subject,
  required String? body,
}) async {
  Uri url = Uri.parse(AppUrl.clientReport);
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
    body: json.encode({'subject': subject, "body": body}),
  );
  Get.back();
  if (response.statusCode == 200) {
    Get.offAll(() => Client());
    Get.defaultDialog(
      content: Text(
        'Report Sent Successfully',
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
        message: 'Unable to send report',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}
