import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future getSavedAccounts() async {
  Uri url = Uri.parse(AppUrl.savedBankAccounts);
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
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: data['message'],
        duration: Duration(milliseconds: 3000),
      ),
    );
    return savedAccountsFromJson(response.body);
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to view accounts',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}

SavedAccounts savedAccountsFromJson(String str) =>
    SavedAccounts.fromJson(json.decode(str));

String savedAccountsToJson(SavedAccounts data) => json.encode(data.toJson());

class SavedAccounts {
  SavedAccounts({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamps,
  });

  bool? status;
  int? code;
  String? message;
  List<Datum>? data;
  int? timestamps;

  factory SavedAccounts.fromJson(Map<String, dynamic> json) => SavedAccounts(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        timestamps: json["timestamps"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "timestamps": timestamps,
      };
}

class Datum {
  Datum({
    this.accountId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.receipientCode,
    this.bankCode,
    this.date,
  });

  int? accountId;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? receipientCode;
  String? bankCode;
  String? date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accountId: json["account_id"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        receipientCode: json["receipient_code"],
        bankCode: json["bank_code"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "receipient_code": receipientCode,
        "bank_code": bankCode,
        "date": date,
      };
}
