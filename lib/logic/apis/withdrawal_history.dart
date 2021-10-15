import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<WithdrawalHistory> getWithdrawHistory() async {
  Uri url = Uri.parse(AppUrl.withdrawalHistory);
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
    return withdrawalHistoryFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

WithdrawalHistory withdrawalHistoryFromJson(String str) =>
    WithdrawalHistory.fromJson(json.decode(str));

String withdrawalHistoryToJson(WithdrawalHistory data) =>
    json.encode(data.toJson());

class WithdrawalHistory {
  WithdrawalHistory({
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

  factory WithdrawalHistory.fromJson(Map<String, dynamic> json) =>
      WithdrawalHistory(
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
    this.withdrawalId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.receipientCode,
    this.amount,
    this.status,
    this.referenceNumber,
    this.date,
  });

  int? withdrawalId;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? amount;
  String? status;
  String? referenceNumber;
  String? date;
  dynamic receipientCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        withdrawalId: json["withdrawal_id"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        receipientCode: json["receipient_code"],
        amount: json["amount"],
        status: json["status"],
        referenceNumber: json["reference_number"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "withdrawal_id": withdrawalId,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "receipient_code": receipientCode,
        "amount": amount,
        "status": status,
        "reference_number": referenceNumber,
        "date": date,
      };
}
