import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/logic/apis/create_review.dart';
import 'package:rider/screens/client/home.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future confirmBooking({
  required String? jobId,
}) async {
  Uri url = Uri.parse(AppUrl.confirmBooking);
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
    body: json.encode({'job_id': jobId}),
  );
  Get.back();
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    if (data['status']) {
      Get.offAll(() => Client());
      Get.dialog(
        RatingDialog(
          initialRating: 1.0,
          title: Text(
            'Booking confirmed sucessfully',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          message: Text(
            'Review your service',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          submitButtonText: 'Submit',
          commentHint: 'Leave a review',
          onCancelled: () => Get.back(),
          onSubmitted: (response) {
            createReview(
              jobId: jobId!.toString(),
              rating: response.rating.toString(),
              comment: response.comment,
            );
          },
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
        message: 'Unable to confirm booking',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}
