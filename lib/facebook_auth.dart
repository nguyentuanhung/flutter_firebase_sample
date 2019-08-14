import 'package:flutter_facebook_login/flutter_facebook_login.dart';

///
/// facebook auth service
///
class FacebookAuth {
  // Facebook login
  final FacebookLogin _facebookLogin = FacebookLogin();

  FacebookAuth._internal();

  static final FacebookAuth _instance = FacebookAuth._internal();

  factory FacebookAuth() {
    return _instance;
  }

  ///
  /// facebook sign in
  ///
  Future<String> signIn() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    var result = await _facebookLogin.logInWithReadPermissions(['email']);

    String token;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        token = result.accessToken.token;
        break;
      default:
        break;
    }
    return token;
  }

  ///
  /// facebook sign out
  ///
  Future<void> signOut() {
    return _facebookLogin.logOut();
  }
}
