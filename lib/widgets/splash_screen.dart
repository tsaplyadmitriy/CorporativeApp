import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/constants.dart';

class AppSplash extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: new Center(
        child: SvgPicture.asset(
        "android/assets/images/logosvg.svg",
        height: size.height * 0.1,
      ),),
      backgroundColor: constants.kBackgroundColor,



    );
  }


}