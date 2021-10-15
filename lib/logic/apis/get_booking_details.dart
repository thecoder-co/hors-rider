import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
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
    print(response.body);
    return bookingDetailsFromJson(response.body);
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
  List<dynamic>? deliverDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDetails: BookingDetailsClass.fromJson(json["booking_details"]),
        deliverDetails:
            List<dynamic>.from(json["deliver_details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "booking_details": bookingDetails!.toJson(),
        "deliver_details": List<dynamic>.from(deliverDetails!.map((x) => x)),
      };
}

class BookingDetailsClass {
  BookingDetailsClass({
    this.bookingNumber,
    this.serviceFee,
    this.bookingStatus,
    this.pickupPoint,
    this.pickupDate,
    this.dropoffPoint,
    this.dropoffDate,
    this.paymentStatus,
    this.paymentMethod,
    this.distance,
    this.taskDescription,
    this.weight,
    this.date,
  });

  String? bookingNumber;
  String? serviceFee;
  String? bookingStatus;
  String? pickupPoint;
  String? pickupDate;
  String? dropoffPoint;
  String? dropoffDate;
  String? paymentStatus;
  String? paymentMethod;
  String? distance;
  String? taskDescription;
  String? weight;
  String? date;

  factory BookingDetailsClass.fromJson(Map<String, dynamic> json) =>
      BookingDetailsClass(
        bookingNumber: json["booking_number"],
        serviceFee: json["service_fee"],
        bookingStatus: json["booking_status"],
        pickupPoint: json["pickup_point"],
        pickupDate: json["pickup_date"],
        dropoffPoint: json["dropoff_point"],
        dropoffDate: json["dropoff_date"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        distance: json["distance"],
        taskDescription: json["task_description"],
        weight: json["weight"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "booking_number": bookingNumber,
        "service_fee": serviceFee,
        "booking_status": bookingStatus,
        "pickup_point": pickupPoint,
        "pickup_date": pickupDate,
        "dropoff_point": dropoffPoint,
        "dropoff_date": dropoffDate,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "distance": distance,
        "task_description": taskDescription,
        "weight": weight,
        "date": date,
      };
}
