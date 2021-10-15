import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<AddProfilePhoto> updateProfilePicture({String? path}) async {
  Uri url = Uri.parse(AppUrl.addProfilePhoto);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  var request = http.MultipartRequest('POST', url);

  request.files.add(await http.MultipartFile.fromPath('profile_photo', path!));

  request.headers.addAll({
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();
    print(data);
    return addProfilePhotoFromJson(data);
  } else {
    throw Exception('Unable to load data');
  }
}

AddProfilePhoto addProfilePhotoFromJson(String str) =>
    AddProfilePhoto.fromJson(json.decode(str));

String addProfilePhotoToJson(AddProfilePhoto data) =>
    json.encode(data.toJson());

class AddProfilePhoto {
  AddProfilePhoto({
    required this.status,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  bool status;
  int? code;
  String? message;
  dynamic data;
  int? timestamp;

  factory AddProfilePhoto.fromJson(Map<String, dynamic> json) =>
      AddProfilePhoto(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data,
        "timestamp": timestamp,
      };
}
