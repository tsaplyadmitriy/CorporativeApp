

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/components/rounded_phone_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/regex.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/session_keeper.dart';
import 'package:lipsar_app/widgets/confirm/confirm_screen.dart';
import 'package:lipsar_app/widgets/recovery/recovery_screen.dart';
import 'package:lipsar_app/widgets/signup/signup_screen.dart';
import 'package:lipsar_app/widgets/splash_flags.dart';
import 'package:lipsar_app/widgets/splash_screen_login.dart';

import '../../custom_material_page_route.dart';
import '../../main.dart';



class LoginBody extends StatefulWidget{

  String errorLabel;
  LoginBody({this.errorLabel});
  @override
  State<StatefulWidget> createState() =>_LoginBody(errorLabel: errorLabel);


}

class _LoginBody extends State<LoginBody>{

  String email = "DefaultEmail";
  String password = "DefaultPassword";
  String errorLabel = "";
  var mailController = new TextEditingController();

  List<FocusNode> nodes = [FocusNode(),FocusNode()];

  _LoginBody({this.errorLabel});

  @override
  void initState() {
    super.initState();
    if(SessionKeeper.email!=""){
      mailController.text = SessionKeeper.email;
      email = SessionKeeper.email;
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //height: size.height,
     // padding: EdgeInsets.only(top: size.height*0.04),


      child: SingleChildScrollView(

      child: Column(

        children: <Widget>[
          Center(

              child: Text("hello",
                  style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  )).tr(context:context),
          ),


          //SizedBox(height: size.height*0.01,),
          RoundedInputField(

            hintText: "emailhint".tr(),

            keyboard: TextInputType.emailAddress,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            next: nodes[1],
            current: nodes[0],
            controller: mailController,
            onChanged: (email){
              setState(() {
                this.email = email;
              });

            },

          ),
          SizedBox(height: size.height*0.01,),
          RoundedPasswordField(

            hintText: "passhint".tr(),
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            current: nodes[1],

            onChanged: (pass){
              setState(() {
                this.password = pass;
              });
            },

          ),

          SizedBox(height: size.height*0.02,),

          Align(

              alignment: Alignment.center,
              child:Container(
                  //margin: EdgeInsets.only(bottom: size.width*0.03),
                  child:
                  InkWell(
                      onTap: (){


                        Navigator.push(context,CustomMaterialPageRoute(
                            builder: (context) => RecoveryScreen()
                        )
                        );


                      },
                      child: Text("forgotpass".tr(),

                        style:TextStyle(
                          fontFamily: "Baloo",
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,

                        ),)
                  ))
          ),
          //SizedBox(height: 5,),
          Align(

              alignment: Alignment.center,
              child:Container(

                margin: EdgeInsets.only(bottom: size.width*0.02),
                child:
                Text(errorLabel,style: TextStyle(
                  fontFamily: "Baloo",
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                )),
              )),

          //SizedBox(height: 5,),
          RoundedButton(
            text: "login".tr(),
            textColor: Colors.white,

            press: () async{
              SplashFlags.isSplashActive = true;

              if(validateEmail(this.email)) {
                SessionKeeper.email = this.email;
                Navigator.push(context, CustomMaterialPageRoute(
                    builder: (context) =>
                        SplashScreenLogin(
                          email: this.email,
                          password: this.password,
                          onSuccess: (token) {
                            errorLabel = " ";
                            setState(() {});
                          },
                          onVerify: (token) async{
                            await APIRequests().sendVerificationCode(token);
                            Navigator.push(context, CustomMaterialPageRoute(
                                builder: (context) =>
                                    ConfirmScreen(token: token,)));
                          },
                          onError: () {
                            errorLabel = "loginerror".tr();
                            setState(() {});
                          },

                        )));
              }else{
                errorLabel = "mailerror".tr();
                setState(() {});
              }


            },
          ),
          //SizedBox(height: 5),
          Align(

              alignment: Alignment.center,
              child:Container(

                margin: EdgeInsets.only(bottom: size.width*0.015),
                child:
                Text("firsttime".tr(),style: TextStyle(
                  fontFamily: "Baloo",
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 18,
                )),
              )),



          RoundedButton(
            text: "signup".tr(),
            textColor: constants.accentColor,
            color: Colors.white,
            press: (){
              Navigator.push(context,CustomMaterialPageRoute(
                  builder: (context) => SignUpScreen()
              )
              );
            },
          ),


        ],

      )),

    );
  }


  bool validateEmail(String email){
    return  RegExp(r""+regexes[RegexType.EMAIL]).hasMatch(email);
  }

}