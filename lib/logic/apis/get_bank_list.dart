import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<BankList> getBankList() async {
  Uri url = Uri.parse(AppUrl.getBankList);
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
    return bankListFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

BankList bankListFromJson(String str) => BankList.fromJson(json.decode(str));

String bankListToJson(BankList data) => json.encode(data.toJson());

class BankList {
  BankList({
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

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
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
    this.id,
    this.name,
    this.code,
  });

  String? id;
  String? name;
  String? code;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
