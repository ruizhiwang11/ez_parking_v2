import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezparking/Services/Validation.dart';
String username,password;
GlobalKey<FormState> formKey = GlobalKey<FormState>();


class FormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: ScreenUtil.getInstance().setHeight(500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Login',
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: 'Poppins-Bold',
                      letterSpacing: .6,
                    )
                ),
                new TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(labelText: 'UserName',
                    icon: Icon(Icons.person),
                    suffixIcon:(true) ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){userNameController.clear();},) : null ,

                  ),
                  keyboardType: TextInputType.text,
                  validator: validatePassWord,

                  onSaved: (String value){
                    username = value;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'PassWord',
                    icon: Icon(Icons.lock),
                    suffixIcon:(true) ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){passwordController.clear();},) : null ,),
                  obscureText: true,
                  validator: validatePassWord,
                  onSaved: (String value)
                  {
                    password = value;
                  },
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Poppins-Medium',
                            fontSize: ScreenUtil.getInstance().setSp(28),
                          ),
                        ),
                      ),
                      onTap: (){print("lol");},
                    ),
                  ],
                ),

              ],
            ),
          ),
        )
    );
  }
}