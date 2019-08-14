import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_firebase_auth/google_auth.dart';

import 'facebook_auth.dart';

class AppAuth {
  AppAuth._internal();

  static final AppAuth _instance = AppAuth._internal();

  factory AppAuth() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> get currentUser => _auth.currentUser();
  Future<bool> get isSignedIn => currentUser.then((value) => value != null);

  Future<AuthResult> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthResult> signInWithGoogle() async {
    var authentication = await GoogleAuth().signIn();
    if (authentication == null) {
      return null;
    }
    var credential = GoogleAuthProvider.getCredential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  Future<AuthResult> signInWithFacebook() async {
    var token = await FacebookAuth().signIn();
    if (token == null) {
      return null;
    }
    var credential = FacebookAuthProvider.getCredential(accessToken: token);

    return _auth.signInWithCredential(credential);
  }

  Future signOut() async {
    FirebaseUser user = await currentUser;
    _auth.signOut().then((_) {
      switch (user.providerData[0].providerId) {
        case GoogleAuthProvider.providerId:
          GoogleAuth().signOut();
          break;
        case FacebookAuthProvider.providerId:
          FacebookAuth().signOut();
          break;
      }
    });
    return;
  }
}
