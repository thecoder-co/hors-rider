import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/logic/apis/create_review.dart';
import 'package:rider/util/app_url.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<BookingDetails> getBookingsDetails({String? bookingId}) async {
  Uri url = Uri.parse(AppUrl.getBookingDetails + bookingId!);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  http.Response response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    BookingDetails _data = bookingDetailsFromJson(response.body);
    print(response.body);
    for (var i in _data.data!.deliverDetails!) {
      if (!i.reviewStatus! &&
          (i.jobStatus == 'Received' &&
              _data.data!.bookingDetails!.bookingStatus == 'Completed')) {
        double? rating;
        String? comment = '';

        Get.dialog(
          RatingDialog(
            initialRating: 1.0,
            title: Text(
              'Rate your service',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            message: Text(
              'Review rider: ${i.firstName! + ' ' + i.surname!}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            submitButtonText: 'Submit',
            commentHint: 'Leave a review',
            onCancelled: () => Get.back(),
            onSubmitted: (response) {
              rating = response.rating;
              comment = response.comment;
              createReview(
                jobId: i.jobId!.toString(),
                rating: rating.toString(),
                comment: comment,
              );
            },
          ),
        );
      } else {}
    }
    return _data;
  } else {
    throw Exception('Unable to load data');
  }
}

BookingDetails bookingDetailsFromJson(String str) =>
    BookingDetails.fromJson(json.decode(str));

String bookingDetailsToJson(BookingDetails data) => json.encode(data.toJson());

class BookingDetails {
  BookingDetails({
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

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
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
    this.bookingDetails,
    this.deliverDetails,
  });

  BookingDetailsClass? bookingDetails;
  List<DeliverDetail>? deliverDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDetails: BookingDetailsClass.fromJson(json["booking_details"]),
        deliverDetails: List<DeliverDetail>.from(
            json["deliver_details"].map((x) => DeliverDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking_details": bookingDetails!.toJson(),
        "deliver_details":
            List<dynamic>.from(deliverDetails!.map((x) => x.toJson())),
      };
}

class BookingDetailsClass {
  BookingDetailsClass({
    this.bookingId,
    this.bookingNumber,
    this.serviceFee,
    this.bookingStatus,
    this.pickupPoint,
    this.pickupName,
    this.pickupPhoneNumber,
    this.deliveryName,
    this.deliveryPhoneNumber,
    this.pickupDate,
    this.dropoffPoint,
    this.dropoffDate,
    this.pickupLongitude,
    this.pickupLatitude,
    this.dropoffLongitude,
    this.dropoffLatitude,
    this.paymentStatus,
    this.paymentMethod,
    this.distance,
    this.taskDescription,
    this.packageImage,
    this.packageDetails,
    this.weight,
    this.date,
  });

  int? bookingId;
  String? bookingNumber;
  String? serviceFee;
  String? bookingStatus;
  String? pickupPoint;
  String? pickupName;
  String? pickupPhoneNumber;
  String? deliveryName;
  String? deliveryPhoneNumber;
  String? dropoffPoint;
  String? pickupLongitude;
  String? pickupLatitude;
  String? dropoffLongitude;
  String? dropoffLatitude;
  String? paymentStatus;
  String? paymentMethod;
  String? distance;
  String? taskDescription;
  String? packageDetails;
  String? weight;
  String? date;
  DateTime? pickupDate;
  DateTime? dropoffDate;
  String? packageImage;

  factory BookingDetailsClass.fromJson(Map<String, dynamic> json) =>
      BookingDetailsClass(
        bookingId: json["booking_id"],
        bookingNumber: json["booking_number"],
        serviceFee: json["service_fee"],
        bookingStatus: json["booking_status"],
        pickupPoint: json["pickup_point"],
        pickupName: json["pickup_name"],
        pickupPhoneNumber: json["pickup_phone_number"],
        deliveryName: json["delivery_name"],
        deliveryPhoneNumber: json["delivery_phone_number"],
        pickupDate: DateTime.parse(json["pickup_date"]),
        dropoffPoint: json["dropoff_point"],
        dropoffDate: DateTime.parse(json["dropoff_date"]),
        pickupLongitude: json["pickup_longitude"],
        pickupLatitude: json["pickup_latitude"],
        dropoffLongitude: json["dropoff_longitude"],
        dropoffLatitude: json["dropoff_latitude"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        distance: json["distance"],
        taskDescription: json["task_description"],
        packageImage: json["package_image"],
        packageDetails: json["package_details"],
        weight: json["weight"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "booking_number": bookingNumber,
        "service_fee": serviceFee,
        "booking_status": bookingStatus,
        "pickup_point": pickupPoint,
        "pickup_name": pickupName,
        "pickup_phone_number": pickupPhoneNumber,
        "delivery_name": deliveryName,
        "delivery_phone_number": deliveryPhoneNumber,
        "pickup_date": pickupDate!.toIso8601String(),
        "dropoff_point": dropoffPoint,
        "dropoff_date": dropoffDate!.toIso8601String(),
        "pickup_longitude": pickupLongitude,
        "pickup_latitude": pickupLatitude,
        "dropoff_longitude": dropoffLongitude,
        "dropoff_latitude": dropoffLatitude,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "distance": distance,
        "task_description": taskDescription,
        "package_image": packageImage,
        "package_details": packageDetails,
        "weight": weight,
        "date": date,
      };
}

class DeliverDetail {
  DeliverDetail({
    this.jobId,
    this.riderId,
    this.surname,
    this.firstName,
    this.profilePhoto,
    this.email,
    this.riderCurrentLocation,
    this.riderCurrentLatitude,
    this.riderCurrentLongitude,
    this.phoneNumber,
    this.motocycleLicenceNumber,
    this.motocycleBrand,
    this.motocycleColor,
    this.motocycleModel,
    this.jobStatus,
    this.reviewStatus,
  });

  int? jobId;
  String? riderId;
  String? surname;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? motocycleLicenceNumber;
  String? motocycleBrand;
  String? motocycleColor;
  String? motocycleModel;
  String? jobStatus;
  bool? reviewStatus;
  dynamic riderCurrentLocation;
  dynamic riderCurrentLatitude;
  dynamic profilePhoto;
  dynamic riderCurrentLongitude;

  factory DeliverDetail.fromJson(Map<String, dynamic> json) => DeliverDetail(
        jobId: json["job_id"],
        riderId: json["rider_id"],
        surname: json["surname"],
        firstName: json["first_name"],
        profilePhoto: json["profile_photo"],
        email: json["email"],
        riderCurrentLocation: json["rider_current_location"],
        riderCurrentLatitude: json["rider_current_latitude"],
        riderCurrentLongitude: json["rider_current_longitude"],
        phoneNumber: json["phone_number"],
        motocycleLicenceNumber: json["motocycle_licence_number"],
        motocycleBrand: json["motocycle_brand"],
        motocycleColor: json["motocycle_color"],
        motocycleModel: json["motocycle_model"],
        jobStatus: json["job_status"],
        reviewStatus: json["review_status"],
      );

  Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "rider_id": riderId,
        "surname": surname,
        "first_name": firstName,
        "profile_photo": profilePhoto,
        "email": email,
        "rider_current_location": riderCurrentLocation,
        "rider_current_latitude": riderCurrentLatitude,
        "rider_current_longitude": riderCurrentLongitude,
        "phone_number": phoneNumber,
        "motocycle_licence_number": motocycleLicenceNumber,
        "motocycle_brand": motocycleBrand,
        "motocycle_color": motocycleColor,
        "motocycle_model": motocycleModel,
        "job_status": jobStatus,
        "review_status": reviewStatus,
      };
}
