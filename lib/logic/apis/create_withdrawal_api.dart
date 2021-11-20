import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/screens/client/components/wallet_components/initiate_withdrawal_page.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future createWithdrawal({
  required String? bankCode,
  required String? accountNumber,
}) async {
  Uri url = Uri.parse(AppUrl.createWithdrawal);
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
        'bank_code': bankCode,
        'account_number': accountNumber,
      },
    ),
  );
  Get.back();
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['status']) {
      Get.to(
        () => InitiateWithdrawalPage(
          withdrawal: createWithdrawalFromJson(response.body),
          bankCode: bankCode,
        ),
      );
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.GROUNDED,
          message: data['message'],
          duration: Duration(milliseconds: 3000),
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
        message: 'Unable to create withdrawal',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}

CreateWithdrawal createWithdrawalFromJson(String str) =>
    CreateWithdrawal.fromJson(json.decode(str));

String createWithdrawalToJson(CreateWithdrawal data) =>
    json.encode(data.toJson());

class CreateWithdrawal {
  CreateWithdrawal({
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

  factory CreateWithdrawal.fromJson(Map<String, dynamic> json) =>
      CreateWithdrawal(
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
    this.accountName,
    this.accountNumber,
    this.receipientCode,
    this.bankName,
  });

  String? accountName;
  String? accountNumber;
  String? receipientCode;
  String? bankName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        receipientCode: json["receipient_code"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "account_number": accountNumber,
        "receipient_code": receipientCode,
        "bank_name": bankName,
      };
}
