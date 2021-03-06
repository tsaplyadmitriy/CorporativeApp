

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';

import 'package:lipsar_app/widgets/confirm/confirm_password_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../custom_material_page_route.dart';

class RecoveryBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RecoveryBody();


}


class _RecoveryBody extends State<RecoveryBody>{

  String errorLabel = "";
  String email;

  List<FocusNode> nodes = [FocusNode()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.04),


      child: SingleChildScrollView(

          child: Column(

            children: <Widget>[
              Center(

                child: Text("recovery".tr(),
                    style: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    )),
              ),


              SizedBox(height: size.height*0.1,),
              RoundedInputField(

                hintText: "enteremailhint".tr(),
                keyboard: TextInputType.emailAddress,
                width: 0.85,
                maxHeight: 0.07,
                maxCharacters: 30,
                onChanged: (email){
                  setState(() {
                    this.email = email;
                  });

                },

                current: nodes[0],

              ),


              SizedBox(height: size.height*0.01,),
              Align(

                  alignment: Alignment.centerLeft,
                  child:Container(

                    margin: EdgeInsets.only(left: size.width*0.12,bottom: 5),
                    child:
                    Text(errorLabel,style: Theme.of(context).textTheme.headline6),
                  )),
              RoundedButton(
                text: "send".tr(),
                textColor: Colors.white,

                press: () async{

                  int respCode  = await APIRequests().applyPasswordRecovery(email);
                  print(respCode);
                  if(respCode==200 ){

                  Navigator.push(context, CustomMaterialPageRoute(
                      builder: (context) =>   ConfirmPasswordScreen(
                        email: email,


                  )));

                }

                  if(respCode==404){
                    errorLabel = "emailnotfound".tr();
                    setState(() {

                    });

                  }
                  if(respCode !=404 && respCode!=200){
                    errorLabel = "generalerror".tr();
                    setState(() {

                    });
                  }

                  },


              ),



            ],

          )),

    );
  }




}