import 'package:flutter/cupertino.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:lipsar_app/widgets/signup/signup_body.dart';

class SignUpScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return  BaseScreen(
      isReturnable: true,
      child: SignUpBody(),
    );

  }







}