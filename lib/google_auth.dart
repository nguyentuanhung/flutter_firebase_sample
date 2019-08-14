import 'package:google_sign_in/google_sign_in.dart';

/// google auth service
class GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  GoogleAuth._internal();

  static final GoogleAuth _instance = GoogleAuth._internal();

  factory GoogleAuth() {
    return _instance;
  }

  /// google sign in
  Future<GoogleSignInAuthentication> signIn() async {
    GoogleSignInAccount account = _googleSignIn.currentUser;
    if (account == null) {
      account = await _googleSignIn.signInSilently();
    }

    if (account == null) {
      account = await _googleSignIn.signIn();
    }

    return account?.authentication;
  }

  /// google sign out
  Future<GoogleSignInAccount> signOut() {
    return _googleSignIn.signOut();
  }
}
