import 'package:flutter/foundation.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/util/shared_preference.dart';

class UserProvider {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    UserPreferences().saveUser(user);
  }
}
