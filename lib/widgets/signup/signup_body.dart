import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';



class SignUpBody extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _SignUpBody();

}

class _SignUpBody extends State<SignUpBody>{


  bool checkedValue=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.04),
      height: double.maxFinite,
      child: Column(

        children: <Widget>[
          Center(

            child: Text("РЕГИСТРАЦИЯ",
                style: Theme.of(context)
                    .textTheme
                    .headline1),
          ),


          SizedBox(height: size.height*0.03,),

          RoundedInputField(

            hintText: "ФИО",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,

          ),
          RoundedInputField(

            hintText: "Телефон",
            keyboard: TextInputType.phone,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,

          ),

          RoundedInputField(

            hintText: "Эл. Почта",
            keyboard: TextInputType.visiblePassword,
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
          RoundedInputField(

            hintText: "Повторите пароль",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,

          ),

          Container(
            padding: EdgeInsets.only(left:size.width*0.05),

              child:Row(
            children: [
              Checkbox(value: checkedValue, onChanged: (state){

                  checkedValue = state;

                setState(() {

                });

              }),
              Text("Согласен на обработку персональных данных",style: Theme.of(context).textTheme.headline4,)

            ],

          )),
          SizedBox(height: size.height*0.01,),
          RoundedButton(
            text: "ВОЙТИ",
            textColor: Colors.white,

            press: (){


            },
          ),



        ],

      ),


    );
  }




}