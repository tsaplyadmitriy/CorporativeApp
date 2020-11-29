

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/components/rounded_phone_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/widgets/recovery/recovery_screen.dart';
import 'package:lipsar_app/widgets/signup/signup_screen.dart';



class LoginBody extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_LoginBody();


}

class _LoginBody extends State<LoginBody>{

  String phone = "DefaultPhone";
  String password = "DefaultPassword";
  String errorLabel = "";
  List<FocusNode> nodes = [FocusNode(),FocusNode()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.04),
     height: double.maxFinite,

      child: SingleChildScrollView(

      child: Column(

        children: <Widget>[
          Center(

              child: Text("ДОБРО ПОЖАЛОВАТЬ!",
                  style: Theme.of(context)
                  .textTheme
                  .headline1),
          ),


          SizedBox(height: size.height*0.1,),
          RoundedPhoneField(

            hintText: "Телефон",
            keyboard: TextInputType.phone,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            next: nodes[1],
            current: nodes[0],
            onChanged: (phone){
              this.phone = phone;
            },

          ),
          RoundedPasswordField(

            hintText: "Пароль",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            current: nodes[1],
            onChanged: (pass){
              this.password = pass;
            },

          ),

          SizedBox(height: size.height*0.01,),
          Align(

              alignment: Alignment.centerLeft,
              child:Container(

                margin: EdgeInsets.only(left: size.width*0.08),
                child:
                Text(errorLabel,style: Theme.of(context).textTheme.headline6),
              )),
          RoundedButton(
            text: "ВОЙТИ",
            textColor: Colors.white,

            press: () async{

              UserSession userSession = await APIRequests().loginUser(this.phone, this.password);
              print(userSession.respcode);
              if(userSession.respcode==401){
                errorLabel = "Неправильный логин или пароль";
                setState(() {

                });
              }
              if(userSession.respcode==200){
                errorLabel="";
                print("token: "+userSession.token);
                setState(() {

                });
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        MainBody()));
              }

            },
          ),

          Align(

            alignment: Alignment.centerLeft,
              child:Container(
                margin: EdgeInsets.only(left: size.width*0.1),
                child:
                InkWell(
                onTap: (){


                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) => RecoveryScreen()
                  )
                  );


                },
                 child: Text("Забыли пароль?",

                    style: Theme.of(context)
                      .textTheme
                      .headline3,)
              ))
          ),
          SizedBox(height: size.height*0.015,),

          Align(

              alignment: Alignment.centerLeft,
              child:Container(

                  margin: EdgeInsets.only(left: size.width*0.1),
                  child:
                  InkWell(
                    onTap: (){
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context) => SignUpScreen()
                         )
                        );

                    },
                  child:Text("Регистрация",

                    style: Theme.of(context)
                        .textTheme
                        .headline3,)
              ))
          ),

        ],

      )),

    );
  }




}