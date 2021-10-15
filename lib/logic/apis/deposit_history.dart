import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<DepositHistory> getDepositHistory({String? nextUrl}) async {
  Uri url = Uri.parse(nextUrl ?? AppUrl.depositHistory);
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
    return depositHistoryFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

DepositHistory depositHistoryFromJson(String str) =>
    DepositHistory.fromJson(json.decode(str));

String depositHistoryToJson(DepositHistory data) => json.encode(data.toJson());

class DepositHistory {
  DepositHistory({
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

  factory DepositHistory.fromJson(Map<String, dynamic> json) => DepositHistory(
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
    this.deposits,
    this.currentPage,
    this.prevPageUrl,
    this.nextPageUrl,
    this.resultDescription,
    this.pageDescription,
    this.total,
    this.lastPage,
  });

  List<Deposit>? deposits;
  int? currentPage;
  String? prevPageUrl;
  String? nextPageUrl;
  String? resultDescription;
  String? pageDescription;
  int? total;
  int? lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deposits: List<Deposit>.from(
            json["deposits"].map((x) => Deposit.fromJson(x))),
        currentPage: json["current_page"],
        prevPageUrl: json["prev_page_url"],
        nextPageUrl: json["next_page_url"],
        resultDescription: json["result_description"],
        pageDescription: json["page_description"],
        total: json["total"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "deposits": List<dynamic>.from(deposits!.map((x) => x.toJson())),
        "current_page": currentPage,
        "prev_page_url": prevPageUrl,
        "next_page_url": nextPageUrl,
        "result_description": resultDescription,
        "page_description": pageDescription,
        "total": total,
        "last_page": lastPage,
      };
}

class Deposit {
  Deposit({
    this.depositId,
    this.refId,
    this.amount,
    this.status,
    this.paymentType,
  });

  int? depositId;
  String? refId;
  String? amount;
  String? status;
  String? paymentType;

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        depositId: json["deposit_id"],
        refId: json["ref_id"],
        amount: json["amount"],
        status: json["status"],
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "deposit_id": depositId,
        "ref_id": refId,
        "amount": amount,
        "status": status,
        "payment_type": paymentType,
      };
}
