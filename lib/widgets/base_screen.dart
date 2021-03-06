import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/custom_material_page_route.dart';
import 'package:lipsar_app/widgets/app_preview.dart';
import 'package:lipsar_app/widgets/login/login_body.dart';

class BaseScreen extends StatelessWidget{


  final Widget child;
  final bool isReturnable ;
  final bool isLogout;

  const BaseScreen({this.child,this.isReturnable = true,this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
     new WillPopScope(
        onWillPop: () async {
          if(!isLogout){
            if(isReturnable)Navigator.pop(context);
          }
          else{
            Navigator.push(context, CustomMaterialPageRoute(builder: (context)=>AppPreview()));
          }
          return isReturnable;
          },
      child:
      Scaffold(

          backgroundColor: Colors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   toolbarHeight: size.height*0.08,
        //   backgroundColor: constants.kBackgroundColor,
        //   title:Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       SvgPicture.asset(
        //         "android/assets/images/title.svg",
        //         height: size.height * 0.5,
        //       ),
        //       // SizedBox(width: 5,),
        //       // SvgPicture.asset(
        //       //   "android/assets/images/logotext.svg",
        //       //   height: size.height * 0.02,
        //       // ),
        //
        //
        //     ],
        //
        //   ),),
        body:Container(
          padding: EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
          child:Column(

              children: [
             isReturnable? Container(
                 height:size.height*0.03,
                 child:Align(
                alignment: Alignment.centerLeft,
                  child:IconButton(

              onPressed: (){
                if(!isLogout){
                  if(isReturnable)Navigator.pop(context);
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AppPreview()));
                }
                },
            icon:Icon(Icons.arrow_back_rounded,size: 30,),
            color: constants.accentColor,)
              )):SizedBox(height: size.height*0.03,),
                 Container(
                     child: Column(
                       children: [
                         Image.asset(
                           "android/assets/images/logosec.png",
                           // height: size.height *0.3,
                           scale:size.height*0.002 ,
                         ),
                         Text("В первый ряд!",style: TextStyle(foreground: Paint()..shader = constants.linearGradient,fontFamily: "Baloo",fontSize: 27),)

                       ],
                     )
                 ),



                SizedBox(height: 10,),

                  child
                ],
          )
    ))));
  }





}