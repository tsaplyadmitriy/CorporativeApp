import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/main_body/stream_preview.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../custom_material_page_route.dart';

class NewPasswordScreen extends StatefulWidget{
  String passwordToken;
  NewPasswordScreen({this.passwordToken});

  @override
  State<StatefulWidget> createState() => _NewPasswordScreen(passwordToken: passwordToken);


}

class _NewPasswordScreen extends State<NewPasswordScreen>{
  List<FocusNode> nodes = [FocusNode(),FocusNode()];
  String password;
  String confPassword;
  String passwordToken;
  String errorLabel = "";
  _NewPasswordScreen({this.passwordToken});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseScreen(
      isReturnable: true,
      child: Container(
        child:Column(
          children: [
            RoundedPasswordField(

                hintText: "passhint".tr(),
                keyboard: TextInputType.visiblePassword,
                width: 0.85,
                maxHeight: 0.07,
                maxCharacters: 30,
                onChanged: (password){

                  this.password = password;
                },
                current: nodes[0],
                next:nodes[1]

            ),
            RoundedPasswordField(

              hintText: "repeatpass".tr(),
              keyboard: TextInputType.visiblePassword,
              width: 0.85,
              maxHeight: 0.07,
              maxCharacters: 30,
              current: nodes[1],

              onChanged: (password){

                this.confPassword = password;
              },
            ),

            Align(

                alignment: Alignment.centerLeft,
                child:Container(

                  margin: EdgeInsets.only(left: size.width*0.12,bottom: 5),
                  child:
                  Text(errorLabel,style: Theme.of(context).textTheme.headline6),
                )),


    RoundedButton(
    text: "continue".tr(),
    textColor: Colors.white,

    press: () async {
      if(confPassword==password){

      UserSession userSession= await APIRequests().requestPasswordChange(passwordToken,password);

       if(userSession.respcode==200){
         Navigator.push(context, CustomMaterialPageRoute(
             builder: (context) =>
                  StreamPreview(
                   token: userSession.token

                 )));

       }else{
         errorLabel = "generalerror".tr();
         setState(() {

         });
       }

      }else{

        errorLabel = "matchingpasserror".tr();
        setState(() {

        });
      }

    }

    )


          ],


        )



      ),

    );

  }


}