
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/FormCard_RU.dart';
// import 'package:ezparking/Utils/FormCardSignup.dart' as su;
import 'package:ezparking/Services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ezparking/Boundary/SignUpPage.dart';
import 'package:ezparking/Boundary/LoginPage.dart';





abstract class validBase{
  Future<bool> Signin();
  Future<bool> Signup();
  bool validateSignin();
  bool validateUser(String email, String password);
  Map<String, String> GetStatus(String mode, bool status);
  String validateUserName(String value);
  String validatePassWord(String value);
  String validateConfirmPassWord(String value);
}



class Validation {

  bool validationstate = false;
  String status;
  User user;

  Future<void> Signin() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await Auth().signInWithEmailAndPassword(username, password);
      return validateUser(username, password);
    } else {
      print('Sign in validation fail');
    }

    print("login details: ");
    print("$username + $password");

    //await Auth().checklogin(username, password);

  }

  Future<void> Signup() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print("sign up details: ");
      print(username + "    " + password + "    " + confpassword);
      await Auth().createUserWithEmailAndPassword(username, password);
      return validateUser(username, password);
    } else {
      print('Sign up validation fail');
    }
  }

  bool validateSignin() {
    validationstate ?  Auth().currentUser.email == username : false ;
  }


  // wrap to authStateChanges(), to set login state for initial debuging purples
  bool validateUser(String email, String password) {
    Auth().authStateChanges().listen((User user) {
      try {
        // use aaaaaa as test
        if (user != null || (email == 'aaaa' && password == 'aaaa')) {
          print('sign In successful');
          print(user.toString());
          return 1;
        }
        else {
          print('fail');
          return 0;
        }
        print("check sign In");
        print(status);
      } catch (e) {
        status = 'error';
        print("Opz, error !!");
        return 0;
      }
    });
  }


  Map<String, String> GetStatus(String mode, bool status) {
    Map <String, String> _StatusList = {'mode':'', 'title': '', 'body': ''};
    print("GetStatus status is : ");
    print(status);
    _StatusList['mode'] = mode;
    if (status == true) {
      _StatusList['title'] = mode + ' to EzParking!';
      _StatusList['body'] = 'You have successfully ' + mode + ' , \n Enjoy!';
    } else {
      _StatusList['title'] = 'Sorry';
      _StatusList['body'] = mode + ' unsuccessful, Try again !';
    }
    return _StatusList;
  }


  String validateUserName(String value) {
    if (value.isEmpty) {
      validationstate = false;
      return 'username can not be empty';
    } else if (value.length < 4) {
      validationstate = false;
      return 'username < 4 digits';
    }
    validationstate = true;
    return null;
  }

  String validatePassWord(String value) {
    if (value.isEmpty) {
      validationstate = false;
      return 'password can not be none';
    } else if (value
        .trim()
        .length < 4) {
      validationstate = false;
      return 'password < 4 digits';
    }
    validationstate = true;
    return null;
  }

  String validateConfirmPassWord(String value) {
    if (value.isEmpty) {
      validationstate = false;
      return 'password can not be none';
    } else if (value
        .trim()
        .length < 4) {
      validationstate = false;
      return 'password < 4 digits';
    }
    else if (value != passwordController.text) {
      validationstate = false;
      return 'password not the same';
    }
    validationstate = true;
    return null;
  }

}
