// A singleton, like a global variable
class AuthenticationManager {
  bool isLoggedIn = false;
  String error = '';

  AuthenticationManager._privateConstructor();

  static final AuthenticationManager _instance =
      AuthenticationManager._privateConstructor();

  static AuthenticationManager get instance => _instance;
}
