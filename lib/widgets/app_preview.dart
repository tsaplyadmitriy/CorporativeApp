import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/signup/signup_body.dart';
import 'package:lipsar_app/widgets/signup/signup_screen.dart';

import '../custom_material_page_route.dart';

class AppPreview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context).locale=Locale('ru');

    Size size = MediaQuery.of(context).size;
   return WillPopScope(
       child: Scaffold(
         body: Container(
           height: size.height,
           width: size.width,
           decoration: BoxDecoration(
               gradient: LinearGradient(

                   begin: Alignment.topLeft,
                   end: Alignment.bottomCenter,
              //stops: [0.3,0.3],

              //Color(0xff4128b1),Color(0xff6129b1),
                   colors: [Color(0xff222ac3),Color(0xff8230c5)])),
           alignment: Alignment.center,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               Container(
                 margin: EdgeInsets.only(top: 40),
               child:Column(
                 children:[
                   Image.asset(

                     'android/assets/images/logowhite.png',
                      height: size.height *0.4,
                     width: size.height *0.4,
                     //scale:size.height*0.0027 ,
                     ),
                      Text("appmoto",style: TextStyle(color: Colors.white,fontFamily: "Baloo",fontSize: 36),).tr(context: context),
                   Text("appsubscript",style: TextStyle(color:Colors.white,fontFamily: "Montserrat",fontSize: 14,fontWeight: FontWeight.normal),).tr(context: context)


                 ],

               )),


               Container(
                 margin: EdgeInsets.only(bottom: 40),
                 child:Column(children: [
                   RoundedButton(
                     text: "login",
                     textColor: Colors.white,
                     press: (){
                       Navigator.push(context, CustomMaterialPageRoute(
                           builder: (context) => LoginScreen(isLogout:false,errorLabel: " ",)));
                     },

                   ),
                   SizedBox(height: 5,),
                   RoundedButton(
                     text: "signup",
                      color: Colors.white,
                     textColor: constants.accentColor,
                     press: (){
                       Navigator.push(context, CustomMaterialPageRoute(
                           builder: (context) => SignUpScreen()));
                     },
                   )
                 ],)
         )

             ],
           ),
         ),
       ),

       onWillPop: ()async{return false;});
  }



}