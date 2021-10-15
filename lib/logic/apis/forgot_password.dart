import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<ForgotPassword> forgotPassword({required String? email}) async {
  Uri url = Uri.parse(AppUrl.forgotPassword);

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode(
      {
        'email': email!,
      },
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return forgotPasswordFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ForgotPassword forgotPasswordFromJson(String str) =>
    ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  ForgotPassword({
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

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data!.toJson(),
        "timestamp": timestamp,
      };
}

class Data {
  Data({
    this.token,
    this.email,
  });

  String? token;
  String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["reset_token"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
      };
}
