import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future getLatestOrder() async {
  Uri url = Uri.parse(AppUrl.latestOrderOnDelivery);
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
    var data = json.decode(response.body);
    if (data['status']) {
      return latestOrderFromJson(response.body);
    } else {
      throw Exception();
    }
  } else {
    throw Exception('Unable to load data');
  }
}

LatestOrder latestOrderFromJson(String str) =>
    LatestOrder.fromJson(json.decode(str));

String latestOrderToJson(LatestOrder data) => json.encode(data.toJson());

class LatestOrder {
  LatestOrder({
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

  factory LatestOrder.fromJson(Map<String, dynamic> json) => LatestOrder(
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
  });

  BookingDetails? bookingDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDetails: BookingDetails.fromJson(json["booking_details"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_details": bookingDetails!.toJson(),
      };
}

class BookingDetails {
  BookingDetails({
    this.bookingId,
    this.pickupLongitude,
    this.pickupLatitude,
    this.dropoffLongitude,
    this.dropoffLatitude,
  });

  int? bookingId;
  String? pickupLongitude;
  String? pickupLatitude;
  String? dropoffLongitude;
  String? dropoffLatitude;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        bookingId: json["booking_id"],
        pickupLongitude: json["pickup_longitude"],
        pickupLatitude: json["pickup_latitude"],
        dropoffLongitude: json["dropoff_longitude"],
        dropoffLatitude: json["dropoff_latitude"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "pickup_longitude": pickupLongitude,
        "pickup_latitude": pickupLatitude,
        "dropoff_longitude": dropoffLongitude,
        "dropoff_latitude": dropoffLatitude,
      };
}
