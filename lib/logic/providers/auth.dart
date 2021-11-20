import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<dynamic> getdev() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isLinux) {
        var info = await deviceInfo.linuxInfo;
        return info.prettyName;
      } else {
        var info = await deviceInfo.androidInfo;
        return info.model;
      }
    } catch (e) {
      return 'Google Chrome';
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    String device = await getdev();

    final Map<String, dynamic> loginData = {
      'user_type': 0,
      'device_name': device,
      'password': password,
      'email': email,
    };

    _loggedInStatus = Status.Authenticating;

    Response response = await post(
      Uri.parse(AppUrl.login),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var status = responseData['status'];

      if (status) {
        var userData = responseData['data']['api_token'];

        User authUser = User.fromJson(responseData: userData, email: email);

        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else {
        _loggedInStatus = Status.NotLoggedIn;

        result = {
          'status': false,
          'message': json.decode(response.body)['message']
        };
      }
    } else {
      _loggedInStatus = Status.NotLoggedIn;

      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      {String? email,
      String? password,
      String? passwordConfirmation,
      String? surname,
      String? firstName,
      String? phone,
      String? address}) async {
    var result;
    String device = await getdev();
    final Map<String, dynamic> registrationData = {
      'surname': surname,
      'first_name': firstName,
      'email': email,
      'phone_number': phone,
      'address': address,
      'device_name': device,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    _loggedInStatus = Status.Authenticating;

    Response response = await post(
      Uri.parse(AppUrl.register),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(registrationData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var status = responseData['status'];

      if (status) {
        var userData = responseData['data']['api_token'];
        User authUser = User.fromJson(responseData: userData, email: email);

        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else {
        _loggedInStatus = Status.NotLoggedIn;

        result = {
          'status': false,
          'message': json.decode(response.body)['message']
        };
      }
    } else {
      _loggedInStatus = Status.NotLoggedIn;

      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }

  void logout() async {
    _loggedInStatus = Status.NotLoggedIn;
    UserPreferences().removeUser();
  }
}
