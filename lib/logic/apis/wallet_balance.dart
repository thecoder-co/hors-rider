import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';

Future<String?> getWalletBalance() async {
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
    WalletBalance wallet = walletBalanceFromJson(response.body);
    return wallet.data!.walletBalance;
  } else {
    print(response.body);
    throw Exception('Unable to load data');
  }
}

WalletBalance walletBalanceFromJson(String str) =>
    WalletBalance.fromJson(json.decode(str));

String walletBalanceToJson(WalletBalance data) => json.encode(data.toJson());

class WalletBalance {
  WalletBalance({
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

  factory WalletBalance.fromJson(Map<String, dynamic> json) => WalletBalance(
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
    this.walletBalance,
  });

  String? walletBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        walletBalance: json["wallet_balance"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_balance": walletBalance,
      };
}
