import 'package:flutter/widgets.dart';
import 'package:flutter_navigation_practice_1/core/authentication/authentication_manager.dart';

class AuthViewModel extends ChangeNotifier {
  Future<bool> login() {
    AuthenticationManager.instance.isLoggedIn = true;
    return Future.value(true);
  }

  Future<void> logout() {
    AuthenticationManager.instance.isLoggedIn = false;
    return Future.value();
  }
}