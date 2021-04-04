import 'package:flutter/widgets.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
}