import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future createReview({
  required String? jobId,
  required String? rating,
  required String? comment,
}) async {
  Uri url = Uri.parse(AppUrl.createReview);
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
        'job_id': jobId,
        'rating': rating,
        'comment': comment,
      },
    ),
  );
  Get.back();
  if (response.statusCode == 200) {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'reviewed successfully',
        duration: Duration(milliseconds: 3000),
      ),
    );
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to review',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}
