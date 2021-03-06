import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class RecoveryHintDialog extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),

        child:Dialog(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        )
    );
  }

  dialogContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        children: <Widget>[
          Container(
            height: 300,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin:  EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: 0),

              decoration: new BoxDecoration(

              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(

                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("Обратитесь в горячую линию нашего call-центра",textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline1),
                  ),
                  SizedBox(height: size.height*0.02,),
                  Align(
                    alignment: Alignment.center,
                    child: Text("+7 (937) 005-17-35\nsales.callcenter@mail.ru",textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline1),
                  ),
                  SizedBox(height: size.height*0.06,),
                  RoundedButton(
                    text: "Позвонить",
                    press: (){
                      print("text");
                      launch('tel://+79370000000');

                    },

                  )
                ],


              )
          )
        ]
    );



  }




}