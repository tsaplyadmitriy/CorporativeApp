

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
import 'package:lipsar_app/main_body/stream_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lipsar_app/widgets/confirm/recovery_hint_dialog.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';

import '../../custom_material_page_route.dart';

class ConfirmBody extends StatefulWidget{
  String email;

  String nameSurname;
  String password;
  String token;


  ConfirmBody({this.email,this.nameSurname,this.password,this.token});

  @override
  State<StatefulWidget> createState() =>  _ConfirmBody (email,nameSurname,password,token);

}




class _ConfirmBody extends State<ConfirmBody>{

  String email;

  String nameSurname;
  String password;
  String token;
  String code;

  String errorLabel = "";


  _ConfirmBody(this.email,this.nameSurname,this.password,this.token):super();

  List<FocusNode> nodes = [FocusNode()];
  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  bool wasSendBefore = false;



  int timeRemaining = 30;


  String formatTimeString(int timer){

    if(timer>=5 ){
      return timer.toString()+" "+"seconds1".tr();
    }else if(timer >1){
      return timer.toString()+" "+"seconds2".tr();
    }else{
      return timer.toString()+" "+ "seconds3".tr();
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

      Text("sendagain".tr()+ formatTimeString(timeRemaining))),

      renderSuccess: ({data}) =>
          Center(
            child:
            InkWell(
              onTap: ()async {
                await APIRequests().sendVerificationCode(this.token);
                this.asyncLoaderState.currentState.reloadState();
              },
              child:  Text("sendagain2".tr(),style: TextStyle(
                color: constants.kPrimaryColor,
                decoration: TextDecoration.underline,),)

            ),
      )
     ,
    );

    return
      WillPopScope(
          onWillPop: ()async{
            pinFormatter.clear();
            //TODO false flag
            await Navigator.push(context, CustomMaterialPageRoute(
                builder: (context) =>
                    LoginScreen()));

          },
      child: Container(

      padding: EdgeInsets.only(top: size.height*0.04),


      child: SingleChildScrollView(

        child: Column(

            children: <Widget>[
        Center(

          child: Text("ПОДТВЕРЖДЕНИЕ",
              style: TextStyle(
                fontFamily: "Baloo",
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )),
         ),
        Align(
            alignment: Alignment.center,
                child:Container(
                  margin: EdgeInsets.only(top: size.width*0.05,right: 10,left: 10),
                  child:

                     Text("codesendhint".tr(),
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

        hintText: "confirmcode".tr(),
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

                    margin: EdgeInsets.only(left: size.width*0.12,bottom: 5),
                    child:
                    Text(errorLabel,style: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.black26,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                  )),
      RoundedButton(
        text: "continue".tr(),
        textColor: Colors.white,

        press: () async{




          if(code == null || code.length!=7  ){
            errorLabel = "fullcodeerror".tr();
            setState(() {

            });

          }

          else{
            var numpin = code.substring(0,3)+code.substring(4,code.length);
            print(numpin);
            if(!validatePin(numpin)){
              errorLabel = "wrongformaterror".tr();
              setState(() {

              });

            }
            else{





          if(await APIRequests().verifyEmail(numpin,token)){

                errorLabel = "";
                pinFormatter.clear();
                code  ="";
                setState(() {

                });

            Navigator.push(context, CustomMaterialPageRoute(
                builder: (context) =>
                    new StreamPreview(
                      token: token,
                    )));
          }

          else{

            errorLabel = "wrongcode".tr();
            setState(() {

            });

          }


        }

        }
        },
      ),

      // Align(
      //
      //     alignment: Alignment.centerLeft,
      //     child:Container(
      //         margin: EdgeInsets.only(left: size.width*0.1),
      //         child:
      //         InkWell(
      //             onTap: ()async {
      //               await showDialog(
      //                   context: context,
      //                   builder: (BuildContext buildContext) =>
      //                       RecoveryHintDialog());
      //
      //
      //
      //             },
      //             child: Text("Не приходит код подтверждения?",
      //
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .headline3,)
      //         ))
      // ),
    ]))));
  }


  bool validatePin(String pin){
    return RegExp(r"^\d+$").hasMatch(pin) ;


  }

}