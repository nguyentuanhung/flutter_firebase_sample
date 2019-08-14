import 'package:flutter/material.dart';
import 'package:flutter_app_firebase_auth/auth.dart';
import 'package:flutter_app_firebase_auth/home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "hung-nguyen@test.com";
  String pass = "123456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                AppAuth()
                    .signUpWithEmailAndPassword(email: email, password: pass)
                    .then((authResult) {
                  if (authResult.user != null) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }
                });
              },
              child: Text("Sign up with email and password"),
            ),
            FlatButton(
              onPressed: () {
                AppAuth()
                    .signInWithEmailAndPassword(email: email, password: pass)
                    .then((authResult) {
                  if (authResult.user != null) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }
                });
              },
              child: Text("Log in with email and password"),
            ),
            FlatButton(
                onPressed: () {
                  AppAuth().signInWithGoogle().then((authResult) {
                    if (authResult.user != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  });
                },
                child: Text("Login with Google")),
            FlatButton(
                onPressed: () {
                  AppAuth().signInWithFacebook().then((authResult) {
                    if (authResult.user != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  });
                },
                child: Text("Login with Facebook")),
          ],
        ),
      ),
    );
  }
}
