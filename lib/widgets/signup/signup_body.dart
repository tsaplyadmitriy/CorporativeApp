import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/components/rounded_phone_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/regex.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/widgets/confirm/confirm_screen.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_material_page_route.dart';
import '../../main.dart';
import '../../session_keeper.dart';




class SignUpBody extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _SignUpBody();

}

class _SignUpBody extends State<SignUpBody>{
  List<FocusNode> nodes = [FocusNode(),FocusNode(),FocusNode(),FocusNode(),FocusNode()];

  bool checkedValue=false;
  String nameSurname = "";

  String email = "";
  String password = "";
  String confPassword = "";
  String errorLabel = "";
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
     // padding: EdgeInsets.only(top: size.height*0.01),


      child: SingleChildScrollView(
      child: Column(

        children: <Widget>[
          Center(

            child: Text("signup".tr(),
                style: TextStyle(
                  fontFamily: "Baloo",
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                )),
          ),


          SizedBox(height: size.height*0.01,),

          RoundedInputField(

            hintText: "namehint".tr(),
            onChanged: (name){
              nameSurname = name;


            },
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            current: nodes[0],
            next:nodes[1]

          ),


          RoundedInputField(

            hintText: "emailhint".tr(),
            keyboard: TextInputType.emailAddress,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            onChanged: (email){
              this.email = email;
            },
              current: nodes[1],
              next:nodes[2]
          ),
          RoundedPasswordField(

            hintText: "passhint".tr(),
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            onChanged: (password){

              this.password = password;
            },
              current: nodes[2],
              next:nodes[3]

          ),
          RoundedPasswordField(

            hintText: "repeatpass".tr(),
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
              current: nodes[3],

            onChanged: (password){

              this.confPassword = password;
            },
          ),
          SizedBox(height: 5,),
          Container(
            //padding: EdgeInsets.only(left:size.width*0.15),

              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
              data: ThemeData(unselectedWidgetColor: constants.accentColor),
            child:Checkbox(value: checkedValue,
                  activeColor: constants.accentColor,
                  hoverColor: constants.accentColor,


                  onChanged: (state){

                  checkedValue = state;

                setState(() {

                });

              })),
              privacyPolicyLinkAndTermsOfService()

            ],)



          ),
          //SizedBox(height: size.height*0.01,),
      Align(

          alignment: Alignment.center,

          child:Container(

           // margin: EdgeInsets.only(top: size.width*0.01),
            child:
            Text(errorLabel,textAlign:TextAlign.center,style:TextStyle(
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
              errorLabel = "";
              isError = false;
              if(nameSurname.length==0  || email.length==0 || password.length==0 || confPassword.length==0){
                if(!isError){
                errorLabel +="emptyfielderror".tr();
                isError = true;
                }
              }


              if(!validateName(nameSurname)){

                if(!isError) {
                  errorLabel += "nameerror".tr();
                  isError = true;
                }
              }




              if(!validateEmail(email)){

              if(!isError) {
                errorLabel += "mailerror2".tr();
                isError = true;
              }
              }

              if(password.length<6){
                if(!isError) {
                  errorLabel += "passlenerror".tr();
                  isError = true;
                }
              }



              if(!validatePassword(password)){
                if(!isError) {
                  errorLabel += "passlettererror".tr();
                  isError = true;
                }

              }
              if(password.contains(" ")){
                if(!isError) {
                  errorLabel += "spaceserror".tr();
                  isError = true;
                }
              }



              if(this.confPassword != this.password){
                if(!isError) {


                  errorLabel += "matchingpasserror".tr();
                  isError = true;
                }
              }




                if(!isError ){
                  if(checkedValue){





                    UserSession entity =// UserSession(token:"123",emailVerified:"true",respcode: 201);

                    await APIRequests().signUpUser(this.email,
                         this.nameSurname, this.password);
                    print(entity.token);



                    if(entity.respcode==409 ){
                      errorLabel += "existingmailerror".tr();
                    }else if(entity.respcode==201 ) {
                      SessionKeeper.email = this.email;
                      SessionKeeper.password  = this.password;
                      await APIRequests().sendVerificationCode(entity.token);
                      Navigator.push(context, CustomMaterialPageRoute(
                          builder: (context) =>
                              ConfirmScreen(

                                email: this.email,
                                nameSurname: this.nameSurname,
                                password: this.password,

                                token: entity.token,


                              )
                      )
                      );
                    }
                        // print("phone: "+entity.phone);
                    }
                  else{
                    errorLabel += "personaldataerror".tr();
                  }

                }

                setState(() {

                });

            },
          ),


        RoundedButton(
          textColor: constants.accentColor,
          color: Colors.white,
          textSize: 14,
          text: "signup2".tr(),
          press: (){
            Navigator.pop(context,CustomMaterialPageRoute(
                builder: (context) => LoginScreen()
            )
            );
          },


        ),



        ],

      )),


    );
  }



  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      //padding: EdgeInsets.all(10),
      child: Center(
          child: Text.rich(

              TextSpan(
                  text: "agreewith".tr(), style: TextStyle(
                height: 1.25,
                  fontFamily: "Baloo",
                  fontSize: 14, color: Colors.black26
              ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "datapolicy".tr(), style: TextStyle(height: 1,
                      fontSize: 14, color: Colors.grey, fontFamily: "Baloo",
                      decoration: TextDecoration.underline,
                    ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async{
                            String link = await APIRequests().getDataAgreement();
                            launch(link);
                          }
                    ),
                    TextSpan(
                        text: "conditions".tr(), style: TextStyle(
                        fontSize: 14, color: Colors.black26 ,fontFamily: "Baloo",
                    ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "licenseagreement".tr(), style: TextStyle(
                              fontSize: 14, color: Colors.grey,
                              decoration: TextDecoration.underline, fontFamily: "Baloo",
                          ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async{
                                  String link = await APIRequests().getLicenseAgreement();
                                  launch(link);
                                }
                          )
                        ]
                    )
                  ]
              )
          )
      ),
    );
  }

bool validateEmail(String email){
 return  RegExp(r""+regexes[RegexType.EMAIL]).hasMatch(email);
}




bool validatePassword(String password){

    return RegExp(r""+regexes[RegexType.PASSWORD]).hasMatch(password);
}

  bool validateName(String name){

    return RegExp(r""+regexes[RegexType.NAME]).hasMatch(name);
  }
}