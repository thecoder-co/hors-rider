import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<DepositDetails> getDepositDetails({required String? depositId}) async {
  Uri url = Uri.parse(AppUrl.depositDetails + '/$depositId');

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
    return depositDetailsFromJson(response.body);
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to get details',
        duration: Duration(milliseconds: 3000),
      ),
    );
    throw Exception();
  }
}

DepositDetails depositDetailsFromJson(String str) =>
    DepositDetails.fromJson(json.decode(str));

String depositDetailsToJson(DepositDetails data) => json.encode(data.toJson());

class DepositDetails {
  DepositDetails({
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

  factory DepositDetails.fromJson(Map<String, dynamic> json) => DepositDetails(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        timestamps: json["timestamps"] == null ? null : json["timestamps"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
        "timestamps": timestamps == null ? null : timestamps,
      };
}

class Data {
  Data({
    this.depositId,
    this.refId,
    this.amount,
    this.status,
    this.paymentType,
    this.transactionId,
    this.charges,
    this.paidAt,
    this.cardDetails,
  });

  int? depositId;
  String? refId;
  String? amount;
  String? status;
  String? paymentType;
  String? transactionId;
  String? charges;
  DateTime? paidAt;
  CardDetails? cardDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositId: json["deposit_id"] == null ? null : json["deposit_id"],
        refId: json["ref_id"] == null ? null : json["ref_id"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        charges: json["charges"] == null ? null : json["charges"],
        paidAt:
            json["paid_at"] == null ? null : DateTime.parse(json["paid_at"]),
        cardDetails: json["card_details"] == null
            ? null
            : CardDetails.fromJson(json["card_details"]),
      );

  Map<String, dynamic> toJson() => {
        "deposit_id": depositId == null ? null : depositId,
        "ref_id": refId == null ? null : refId,
        "amount": amount == null ? null : amount,
        "status": status == null ? null : status,
        "payment_type": paymentType == null ? null : paymentType,
        "transaction_id": transactionId == null ? null : transactionId,
        "charges": charges == null ? null : charges,
        "paid_at": paidAt == null ? null : paidAt!.toIso8601String(),
        "card_details": cardDetails == null ? null : cardDetails!.toJson(),
      };
}

class CardDetails {
  CardDetails({
    this.accountName,
    this.cardType,
    this.bank,
    this.lastFourDigit,
    this.expireDate,
  });

  String? accountName;
  String? cardType;
  String? bank;
  String? lastFourDigit;
  String? expireDate;

  factory CardDetails.fromJson(Map<String, dynamic> json) => CardDetails(
        accountName: json["account_name"],
        cardType: json["card_type"] == null ? null : json["card_type"],
        bank: json["bank"] == null ? null : json["bank"],
        lastFourDigit:
            json["last_four_digit"] == null ? null : json["last_four_digit"],
        expireDate: json["expire_date"] == null ? null : json["expire_date"],
      );

  Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "card_type": cardType == null ? null : cardType,
        "bank": bank == null ? null : bank,
        "last_four_digit": lastFourDigit == null ? null : lastFourDigit,
        "expire_date": expireDate == null ? null : expireDate,
      };
}
