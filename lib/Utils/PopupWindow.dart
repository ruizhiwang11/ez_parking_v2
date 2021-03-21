
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Boundary/LoginPage.dart';
import 'package:ezparking/Services/Validation.dart';
import 'package:ezparking/Boundary/MapPage.dart';

bool loginState = false;
bool SignUpStatus = false;

class Popupwindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container();
  }
  Widget PopupDialog(BuildContext context, String mode, String status) {

    var list = GetStatus(mode, status);

    return new AlertDialog(
      title:  Text( list['title']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(list['body']),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            print (status);
            (status == 'success')? Navigator.of(context).pushNamedAndRemoveUntil(MapPage.routeName,(Route<dynamic> route) => false):null ;
            },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

}




