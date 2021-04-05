import 'package:flutter/widgets.dart';
import 'package:flutter_navigation_practice_1/core/authentication/authentication_manager.dart';
import 'package:flutter_navigation_practice_1/resource/login_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginRepository _repository;

  AuthViewModel(this._repository);

  void login() async {
    final manager = AuthenticationManager.instance;

    final loginResult = await _repository.login();
    manager.isLoggedIn = loginResult;
    if (!loginResult) {
      manager.error = 'Login Failed';
    }

    notifyListeners();
  }

  void logout() async {
    final manager = AuthenticationManager.instance;
    await _repository.logout();
    manager.isLoggedIn = false;
    notifyListeners();
  }
}