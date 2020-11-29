

import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/components/rounded_phone_field.dart';
import 'package:lipsar_app/components/rounded_pin_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/widgets/confirm/recovery_hint_dialog.dart';

class ConfirmBody extends StatefulWidget{
  String email;
  String phone;
  String nameSurname;
  String password;
  String token;

  ConfirmBody({this.email,this.phone,this.nameSurname,this.password,this.token});

  @override
  State<StatefulWidget> createState() =>  _ConfirmBody (email,phone,nameSurname,password,token);

}




class _ConfirmBody extends State<ConfirmBody>{

  String email;
  String phone;
  String nameSurname;
  String password;
  String token;
  String code;
  String errorLabel = "";

  _ConfirmBody(this.email,this.phone,this.nameSurname,this.password,this.token):super();

  List<FocusNode> nodes = [FocusNode()];
  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  bool wasSendBefore = false;



  int timeRemaining = 30;


  String formatTimeString(int timer){

    if(timer>=5 ){
      return timer.toString()+" секунд";
    }else if(timer >1){
      return timer.toString()+" секунды";
    }else{
      return timer.toString()+" секунду";
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async  {
        while(timeRemaining>0){
          await  Future.delayed(const Duration(seconds: 1), () {
            timeRemaining--;
            setState(() {

            });


          });
        }
        timeRemaining = 30;
        return timeRemaining;
        }
       ,
      renderLoad: () => Center(child:

      Text("Отправить код повторно через "+formatTimeString(timeRemaining))),

      renderSuccess: ({data}) =>
          Center(
            child:
            InkWell(
              onTap: (){

                this.asyncLoaderState.currentState.reloadState();
              },
              child:  Text("Отправить код ещё раз",style: TextStyle(
                color: constants.kPrimaryColor,
                decoration: TextDecoration.underline,),)

            ),
      )
     ,
    );

    return Container(

      padding: EdgeInsets.only(top: size.height*0.04),
      height: double.maxFinite,

      child: SingleChildScrollView(

        child: Column(

            children: <Widget>[
        Center(

          child: Text("ПОДТВЕРЖДЕНИЕ",
              style: Theme.of(context)
                  .textTheme
                  .headline1),
         ),
        Align(
            alignment: Alignment.center,
                child:Container(
                  margin: EdgeInsets.only(top: size.width*0.05),
                  child:

                     Text("Мы отправили уникальный 6-значный код на вашу почту",
                        textAlign: TextAlign.center,
                        style:  TextStyle(

                          color: Colors.black,
                          fontSize: 16,
                        ),),
      )),
              SizedBox(height: size.height*0.05,),
      Container(

        child:   _asyncLoader

      ),

      SizedBox(height: size.height*0.02,),

      RoundedPinField(

        hintText: "Пин-код",
        keyboard: TextInputType.phone,
        width: 0.85,
        maxHeight: 0.07,
        maxCharacters: 30,

        current: nodes[0],
        onChanged: (code){
          this.code = code;
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
        text: "ПРОДОЛЖИТЬ",
        textColor: Colors.white,

        press: () async{

          if(await APIRequests().verifyEmail(code,token)){

          errorLabel = "";
          setState(() {

          });
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  MainBody()));
          }else{

            errorLabel = "Неправильный пин-код";
            setState(() {

            });

          }
        },
      ),

      Align(

          alignment: Alignment.centerLeft,
          child:Container(
              margin: EdgeInsets.only(left: size.width*0.1),
              child:
              InkWell(
                  onTap: ()async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext buildContext) =>
                            RecoveryHintDialog());



                  },
                  child: Text("Не приходит код подтверждения?",

                    style: Theme.of(context)
                        .textTheme
                        .headline3,)
              ))
      ),
    ])));
  }



}