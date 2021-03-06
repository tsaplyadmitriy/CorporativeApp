import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:lipsar_app/widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget{


  String errorLabel = " ";
  bool isLogout;
  LoginScreen({this.errorLabel,this.isLogout});
  @override
  Widget build(BuildContext context) {

    return BaseScreen(
      isLogout: this.isLogout,
      isReturnable: true,
      child: LoginBody(errorLabel: (errorLabel!=null)?errorLabel:" ",),
    );
  }





}