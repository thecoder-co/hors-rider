import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

class APIs {
  Future<ProfileData> getProfileDetails() async {
    Uri url = Uri.parse(AppUrl.profileDetails);
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
      return profileFromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Unable to load data');
    }
  }
}

ProfileData profileFromJson(String str) =>
    ProfileData.fromJson(json.decode(str));

String profileToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;
  int? timestamp;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status!,
        "code": code!,
        "message": message!,
        "data": data!.toJson(),
        "timestamp": timestamp!,
      };
}

class Data {
  Data({
    this.userId,
    this.surname,
    this.firstName,
    this.gender,
    this.address,
    this.maritalStatus,
    this.profilePhoto,
    this.email,
    this.phone,
    this.walletBalance,
    this.accountStatus,
  });

  int? userId;
  String? surname;
  String? firstName;
  String? gender;
  String? address;
  String? maritalStatus;
  String? profilePhoto;
  String? email;
  String? phone;
  String? walletBalance;
  String? accountStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        surname: json["surname"],
        firstName: json["first_name"],
        gender: json["gender"],
        address: json["address"],
        maritalStatus: json["marital_status"],
        profilePhoto: json["profile_photo"],
        email: json["email"],
        phone: json["phone"],
        walletBalance: json["wallet_balance"],
        accountStatus: json["account_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId!,
        "surname": surname!,
        "first_name": firstName!,
        "gender": gender!,
        "address": address!,
        "marital_status": maritalStatus!,
        "profile_photo": profilePhoto!,
        "email": email!,
        "phone": phone!,
        "wallet_balance": walletBalance!,
        "account_status": accountStatus!,
      };
}
