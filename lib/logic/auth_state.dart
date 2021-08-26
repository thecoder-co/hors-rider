import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {
  
  void logIn(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('loggedIn', true);
    _prefs.setString('token', token);
    notifyListeners();
  }

  void logOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('loggedIn', false);
    _prefs.setString('token', '');
    notifyListeners();
  }

  Future<bool> get isLoggedIn async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool login = _prefs.getBool('loggedIn') ?? false;
    notifyListeners();
    return login;
  }

  Future<String> get getToken async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('token') ?? "";
    return token;
  }
}
