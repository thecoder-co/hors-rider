import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<ProcessBooking> processBooking({
  required String? pickupPoint,
  required String? pickupDate,
  required String? dropoffPoint,
  required String? distance,
  String? taskDescription,
  required String? weight,
  required String? pickupLatitude,
  required String? pickupLongitude,
  required String? dropoffLatitude,
  required String? droppffLongitude,
  required String? packageDetails,
}) async {
  Uri url = Uri.parse(AppUrl.processBooking);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  distance = "${double.parse(distance!) * 1000}";
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
        'pickup_point': pickupPoint.toString(),
        'pickup_date': pickupDate.toString(),
        'dropoff_point': dropoffPoint.toString(),
        'distance': distance,
        'task_description': taskDescription ?? null,
        'weight': weight!,
        'pickup_latitude': pickupLatitude.toString(),
        'pickup_longitude': pickupLongitude.toString(),
        'dropoff_latitude': dropoffLatitude.toString(),
        'dropoff_longitude': droppffLongitude.toString(),
        'package_details': packageDetails.toString(),
      },
    ),
  );
  Get.back();
  if (response.statusCode == 200) {
    return processBookingFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ProcessBooking processBookingFromJson(String str) =>
    ProcessBooking.fromJson(json.decode(str));

String processBookingToJson(ProcessBooking data) => json.encode(data.toJson());

class ProcessBooking {
  ProcessBooking({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamps,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;
  int? timestamps;

  factory ProcessBooking.fromJson(Map<String, dynamic> json) => ProcessBooking(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamps: json["timestamps"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data!.toJson(),
        "timestamps": timestamps,
      };
}

class Data {
  Data({
    this.bookingCode,
    this.serviceFee,
    this.paymentWithWallet,
    this.paymentWithCard,
    this.paymentAtDelivery,
  });

  String? bookingCode;
  String? serviceFee;
  bool? paymentWithWallet;
  bool? paymentWithCard;
  bool? paymentAtDelivery;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingCode: json["booking_code"],
        serviceFee: json["service_fee"],
        paymentWithWallet: json["payment_with_wallet"],
        paymentWithCard: json["payment_with_card"],
        paymentAtDelivery: json["payment_at_delivery"],
      );

  Map<String, dynamic> toJson() => {
        "booking_code": bookingCode,
        "service_fee": serviceFee,
        "payment_with_wallet": paymentWithWallet,
        "payment_with_card": paymentWithCard,
        "payment_at_delivery": paymentAtDelivery,
      };
}
