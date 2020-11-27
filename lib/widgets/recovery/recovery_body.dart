

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
import 'package:lipsar_app/widgets/signup/signup_screen.dart';

class RecoveryBody extends StatelessWidget{

  List<FocusNode> nodes = [FocusNode()];
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

                child: Text("ВОССТАНОВЛЕНИЕ",
                    style: Theme.of(context)
                        .textTheme
                        .headline1),
              ),


              SizedBox(height: size.height*0.1,),
              RoundedPhoneField(

                hintText: "Введите ваш телефон",
                keyboard: TextInputType.phone,
                width: 0.85,
                maxHeight: 0.07,
                maxCharacters: 30,

                current: nodes[0],

              ),


              SizedBox(height: size.height*0.01,),
              RoundedButton(
                text: "ОТПРАВИТЬ",
                textColor: Colors.white,

                press: () async{


                },
              ),



            ],

          )),

    );
  }




}