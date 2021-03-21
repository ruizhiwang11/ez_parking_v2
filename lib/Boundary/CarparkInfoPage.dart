import 'package:ezparking/Services/Auth.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:flutter/material.dart';

import 'package:ezparking/Entity/Carpark.dart';
import 'package:ezparking/Entity/Review.dart';

import '../Entity/Carpark.dart';


Column buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

class CarparkInfoPage extends StatelessWidget{
  CarparkInfoPage({Key key, @required this.auth, @required this.carpark, @required this.review}) : super(key: key);
  final AuthBase auth;
  final Carpark carpark;
  final Review review;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(auth: auth),
        appBar: AppBar(
          title: Text('Car parks'),
          backgroundColor: Colors.amber.shade300,
        ),
        body: Column(
          children: [
            titleSection(),
            buttonSection,
          ],
        )
      ),
    );
  }
  Widget titleSection(){
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    carpark.carParkNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  carpark.address,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );
  }

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildButtonColumn(Colors.blue.shade300, Icons.call, 'CALL'),
        buildButtonColumn(Colors.blue.shade300, Icons.near_me, 'ROUTE'),
        buildButtonColumn(Colors.blue.shade300, Icons.share, 'SHARE'),
      ],
    ),
  );
}