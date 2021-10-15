import 'package:http/http.dart' as http;
import 'package:rider/util/app_url.dart';
import 'dart:convert';

Future<ResetPassword> resetPassword({
  required String? email,
  required String? token,
  required String? password,
}) async {
  Uri url = Uri.parse(AppUrl.resetPassword);
  print(email);
  print(token);
  print(password);

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode(
      {
        'email': email,
        'reset_token': token,
        'password': password,
        'password_confirmation': password,
      },
    ),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return resetPasswordFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ResetPassword resetPasswordFromJson(String str) =>
    ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  ResetPassword({
    this.status,
    this.code,
    this.message,
    this.timestamp,
  });

  bool? status;
  int? code;
  var message;
  int? timestamp;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "timestamp": timestamp,
      };
}
