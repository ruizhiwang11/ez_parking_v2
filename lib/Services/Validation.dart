import 'package:flutter/material.dart';
import 'package:ezparking/Utils/FormCard.dart';
import 'package:ezparking/Utils/FormCardSignup.dart' as su;
import 'package:ezparking/Services/Auth.dart';



TextEditingController userNameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController confirmpasswordController = new TextEditingController();


bool loginState = false;
bool SignUpStatus = false;
String status;



Future<String> Signin()  async {
  if (formKey.currentState.validate()){
    formKey.currentState.save();
  }


  print ("login details: ");
  print("$username + $password");
  Auth().signInWithEmailAndPassword( username, password);
  //await Auth().checklogin(username, password);

}

Future<String> Signup() async {

  su.formKey.currentState.save();
  print ("sign up details: ");
  print(su.username + su.password);
  //await Auth().preCheckExist(su.username, su.password);
  //(status == 'success')? Auth().register( su.username, su.password): SignUpStatus=false;


}


Map<String,String> GetStatus (String mode, String status){
  Map <String,String> _StatusList = {'title':'','body':''};
  print ("status is : " );
  print (status);
  if (status == 'success' ){
    _StatusList['title'] = mode + ' to EzParking!';
    _StatusList['body']='You have successfully '+ mode + ' , Enjoy!';
    loginState = true;
    SignUpStatus = true;

  } else if (status == 'fail' ){
    _StatusList['title'] = 'Sorry';
    _StatusList['body']= mode + ' unsuccessful, Try again !';
    loginState = false;
    SignUpStatus = false;
  }
  else if (status == 'error' ){
    _StatusList['title'] =  mode + ' Error';
    _StatusList['body']='Could not '+ mode + ' at the moment';
    SignUpStatus = false;
    loginState = false;

  }else{
    _StatusList['title'] =  mode + ' GG';
    _StatusList['body']='Could not '+ mode + ' at the moment';
    loginState = false;
    SignUpStatus = false;

  }
  return _StatusList;
}



String validateUserName( String value){
  if (value.isEmpty) {
    return 'username can not be empty';
  }else if (value.length <4) {
    return 'username < 4 digits';
  }
  return null;
}
String validatePassWord(String value){
  if (value.isEmpty) {
    return 'password can not be none';
  }else if(value.trim().length<4 || value.trim().length>18){
    return 'password < 4 digits';
  }
  return null;
}

String validateConfirmPassWord(String value){
  if (value.isEmpty) {
    return 'password can not be none';
  }else if(value.trim().length<4 || value.trim().length>18){
    return 'password < 4 digits';
  }
  return null;
}

