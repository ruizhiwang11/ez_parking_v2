import 'package:ezparking/Controller/ReviewDatabse.dart';
import 'package:ezparking/Utils/StarDisplay.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:ezparking/Entity/Carpark.dart';
import 'package:ezparking/Entity/Review.dart';

class CarparkInfoPage extends StatefulWidget {
  @override
  CarparkInfoPage({Key key, @required this.carpark, @required this.review})
      : super(key: key);
  final Carpark carpark;
  final Review review;
  _CarparkInfoPageState createState() => _CarparkInfoPageState();
}

class _CarparkInfoPageState extends State<CarparkInfoPage> {
  var reviewDB = ReviewDataBase();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text('Carpark Infomation'),
              backgroundColor: Colors.amber.shade300,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.of(context).pop(),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                titleSection(
                  "Carpark Number",
                  widget.carpark.carParkNo,
                  Icon(
                    Icons.car_rental,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark address",
                  widget.carpark.address,
                  Icon(
                    Icons.home,
                    color: Colors.red[500],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Current Slot",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.carpark.currentSlot.toString(),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Total capacity",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.carpark.maxSlot.toString(),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                titleSection(
                  "Carpark Type",
                  widget.carpark.carParkType,
                  Icon(
                    Icons.merge_type,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Short Term Parking",
                  widget.carpark.shortTermParking,
                  Icon(
                    Icons.terrain,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Free Parking",
                  widget.carpark.freeParking,
                  Icon(
                    Icons.money_off,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Night Parking",
                  widget.carpark.nightParking,
                  Icon(
                    Icons.nightlight_round,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark Decks",
                  widget.carpark.carParkDecks.toString() + " layers",
                  Icon(
                    Icons.stairs_rounded,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Gantry height",
                  widget.carpark.gantryHeight.toString() + "m",
                  Icon(
                    Icons.height,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                  "Carpark basement",
                  widget.carpark.carParkBasement,
                  Icon(
                    Icons.stairs_sharp,
                    color: Colors.red[500],
                  ),
                ),
                titleSection(
                    "Review", "Cost", buildStarReview(widget.review.cost, "Cost")),
                titleSection("Review", "Convenience",
                    buildStarReview(widget.review.convenience, "Convenience")),
                titleSection("Review", "Security",
                    buildStarReview(widget.review.security, "Security")),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.call, 'CALL', () {}),
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.near_me, 'ROUTE', () {}),
                      buildButtonColumn(
                          Colors.blue.shade300, Icons.share, 'SHARE', () {}),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget titleSection(String title, String displaytext, Widget icon) {
    return Container(
      padding: const EdgeInsets.all(15),
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
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  displaytext,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          icon,
        ],
      ),
    );
  }

  Widget buildStarReview(int mark, String reviewType) {
    return  SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) async{
            if(reviewType == "Cost"){
              int total = widget.review.cost * widget.review.numOfReviewCost;
              widget.review.numOfReviewCost++;
              widget.review.cost = ((total +v.toInt()) / widget.review.numOfReviewCost).toInt();
              reviewDB.updateReviewById(widget.review);
            }
            if(reviewType == "Convenience"){
              int total = widget.review.convenience * widget.review.numOfReviewConvenience;
              widget.review.numOfReviewConvenience++;
              widget.review.convenience = ((total +v.toInt()) / widget.review.numOfReviewConvenience).toInt();
              reviewDB.updateReviewById(widget.review);
            }
            if(reviewType == "Security"){
              int total = widget.review.security * widget.review.numOfReviewSecurity;
              widget.review.numOfReviewSecurity++;
              widget.review.security = ((total +v.toInt()) / widget.review.numOfReviewSecurity).toInt();
              reviewDB.updateReviewById(widget.review);
            }
          },
          starCount: 5,
          rating: mark.toDouble(),
          size: 40.0,
          isReadOnly: false,
          color: Colors.amber.shade300,
          borderColor: Colors.amber.shade300,
          spacing: 0.0);
  }

  Column buildButtonColumn(
      Color color, IconData icon, String label, VoidCallback onPress) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(icon), color: color, onPressed: onPress),
        Container(
          margin: const EdgeInsets.only(top: 0),
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
}
