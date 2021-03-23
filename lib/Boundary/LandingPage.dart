import 'package:ezparking/Boundary/CarparkInfoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Controller/CarparkDatabase.dart';
import '../Controller/ReviewDatabse.dart';
import '../Entity/Carpark.dart';
import '../Entity/Review.dart';
import '../Entity/Review.dart';
import 'MapPage.dart';
import 'LoginPage.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:ezparking/Controller/ReviewDatabse.dart';

class LandingPage extends StatelessWidget {

  LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<Carpark> getCarpark() async{
    var carparkdb = CarparkDataBase();
    Carpark carpark = await carparkdb.getCarparkByCarparkNumber("AH1");
    carparkdb.close();
    return carpark;
  }
  Future<Review> getReview() async{
    var reviewdb = ReviewDataBase();
    Review review = await reviewdb.getReviewByCarparkNumber("AH1");
    reviewdb.close();
    return review;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          final carpark = getCarpark();
          final review = getReview();
          if (user == null) {
            return LoginPage(
              auth: auth,
            );
          }
            return CarparkInfoPage(
              auth: auth,
              carpark: carpark,
              review: review,
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