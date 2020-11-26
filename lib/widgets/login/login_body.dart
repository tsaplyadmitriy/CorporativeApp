

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/signup/signup_screen.dart';

class LoginBody extends StatelessWidget{

  String phone = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.04),
     height: double.maxFinite,
      child: Column(

        children: <Widget>[
          Center(

              child: Text("ДОБРО ПОЖАЛОВАТЬ!",
                  style: Theme.of(context)
                  .textTheme
                  .headline1),
          ),


          SizedBox(height: size.height*0.1,),
          RoundedInputField(

            hintText: "Телефон",
            keyboard: TextInputType.phone,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,

          ),
          RoundedInputField(

            hintText: "Пароль",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,

          ),

          SizedBox(height: size.height*0.01,),
          RoundedButton(
            text: "ВОЙТИ",
            textColor: Colors.white,

            press: (){


            },
          ),

          Align(

            alignment: Alignment.centerLeft,
              child:Container(
                margin: EdgeInsets.only(left: size.width*0.1),
                child:
                InkWell(
                onTap: (){


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

      ),

    );
  }




}