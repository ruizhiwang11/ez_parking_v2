import 'package:ezparking/Boundary/CarparkInfoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Entity/Carpark.dart';
import '../Entity/Review.dart';
import 'MapPage.dart';
import 'LoginPage.dart';
import 'package:ezparking/Services/Auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return LoginPage(
              auth: auth,
            );
          }
          return CarparkInfoPage(
            auth: auth,
            carpark: Carpark.simple(13, "asc"),
            review: Review(13,"asc",0,0,0,0),

          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}