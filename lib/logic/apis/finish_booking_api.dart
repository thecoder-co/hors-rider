import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';

import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<FinishBooking> finishBooking({
  required String? paymentMethod,
  required String? bookingCode,
  required String? pickupName,
  required String? pickupPhoneNumber,
  required String? deliveryName,
  required String? deliveryPhoneNumber,
  String? imagePath,
}) async {
  Uri url = Uri.parse(AppUrl.finishBooking);

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
  var request = http.MultipartRequest('POST', url);

  imagePath != null
      ? request.files
          .add(await http.MultipartFile.fromPath('package_image', imagePath))
      : 0;

  request.headers.addAll({
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });

  request.fields.addAll({
    'payment_method': paymentMethod!,
    'booking_code': bookingCode!,
    'pickup_name': pickupName!,
    'pickup_phone_number': pickupPhoneNumber!,
    'delivery_name': deliveryName!,
    'delivery_phone_number': deliveryPhoneNumber!,
  });

  http.StreamedResponse response = await request.send();
  Get.back();
  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();
    return finishBookingFromJson(data);
  } else {
    throw Exception('Unable to load data');
  }

  /* http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    
    return finishBookingFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  } */
}

FinishBooking finishBookingFromJson(String str) =>
    FinishBooking.fromJson(json.decode(str));

String finishBookingToJson(FinishBooking data) => json.encode(data.toJson());

class FinishBooking {
  FinishBooking({
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

  factory FinishBooking.fromJson(Map<String, dynamic> json) => FinishBooking(
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
