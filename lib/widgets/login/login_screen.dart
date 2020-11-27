import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:lipsar_app/widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    return BaseScreen(
      isReturnable: false,
      child: LoginBody(),
    );
  }





}