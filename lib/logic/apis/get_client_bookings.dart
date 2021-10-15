import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<ClientBookings> getBookings({String? amount}) async {
  Uri url = Uri.parse(AppUrl.getClientBookings);
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
    return getClientBookingsFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ClientBookings getClientBookingsFromJson(String str) =>
    ClientBookings.fromJson(json.decode(str));

String getClientBookingsToJson(ClientBookings data) =>
    json.encode(data.toJson());

class ClientBookings {
  ClientBookings({
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

  factory ClientBookings.fromJson(Map<String, dynamic> json) => ClientBookings(
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
    this.bookings,
    this.currentPage,
    this.prevPageUrl,
    this.nextPageUrl,
    this.resultDescription,
    this.pageDescription,
    this.total,
    this.lastPage,
  });

  List<Booking>? bookings;
  int? currentPage;
  String? prevPageUrl;
  String? nextPageUrl;
  String? resultDescription;
  String? pageDescription;
  int? total;
  int? lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookings: List<Booking>.from(
            json["bookings"].map((x) => Booking.fromJson(x))),
        currentPage: json["current_page"],
        prevPageUrl: json["prev_page_url"],
        nextPageUrl: json["next_page_url"],
        resultDescription: json["result_description"],
        pageDescription: json["page_description"],
        total: json["total"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "bookings": List<dynamic>.from(bookings!.map((x) => x.toJson())),
        "current_page": currentPage,
        "prev_page_url": prevPageUrl,
        "next_page_url": nextPageUrl,
        "result_description": resultDescription,
        "page_description": pageDescription,
        "total": total,
        "last_page": lastPage,
      };
}

class Booking {
  Booking({
    this.bookingId,
    this.bookingNumber,
    this.serviceFee,
    this.bookingStatus,
    this.date,
  });

  int? bookingId;
  String? bookingNumber;
  String? serviceFee;
  String? bookingStatus;
  String? date;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        bookingNumber: json["booking_number"],
        serviceFee: json["service_fee"],
        bookingStatus: json["booking_status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "booking_number": bookingNumber,
        "service_fee": serviceFee,
        "booking_status": bookingStatus,
        "date": date,
      };
}
