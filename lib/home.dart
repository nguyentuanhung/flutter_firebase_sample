import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase_auth/auth.dart';
import 'package:flutter_app_firebase_auth/login.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<FirebaseUser>(
        future: AppAuth().currentUser,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              children: <Widget>[
                Text(
                    "Hello ${snapshot.data?.displayName ?? snapshot.data?.email}"),
                FlatButton(
                  child: Text("Log out"),
                  onPressed: () {
                    AppAuth().signOut().then((_) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
