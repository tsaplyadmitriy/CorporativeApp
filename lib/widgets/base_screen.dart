import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/login/login_body.dart';

class BaseScreen extends StatelessWidget{


  final Widget child;
  final bool isReturnable ;

  const BaseScreen({this.child,this.isReturnable});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
     new WillPopScope(
        onWillPop: () async => isReturnable,
      child:
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: size.height*0.08,
          backgroundColor: constants.kBackgroundColor,
          title:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "android/assets/images/logosvg.svg",
                height: size.height * 0.05,
              ),
              SizedBox(width: 5,),
              SvgPicture.asset(
                "android/assets/images/logotext.svg",
                height: size.height * 0.02,
              ),


            ],

          ),),
        body:child
    ));
  }





}