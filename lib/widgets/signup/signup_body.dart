import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/components/rounded_input_field.dart';
import 'package:lipsar_app/components/rounded_password_field.dart';
import 'package:lipsar_app/components/rounded_phone_field.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';



class SignUpBody extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _SignUpBody();

}

class _SignUpBody extends State<SignUpBody>{
  List<FocusNode> nodes = [FocusNode(),FocusNode(),FocusNode(),FocusNode(),FocusNode()];

  bool checkedValue=false;
  String nameSurname = "";
  String phone = "";
  String email = "";
  String password = "";
  String confPassword = "";
  String errorLabel = "";
  bool isError = false;
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

            child: Text("РЕГИСТРАЦИЯ",
                style: Theme.of(context)
                    .textTheme
                    .headline1),
          ),


          SizedBox(height: size.height*0.03,),

          RoundedInputField(

            hintText: "ФИО",
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
          RoundedPhoneField(

            hintText: "Телефон",
            keyboard: TextInputType.phone,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            onChanged: (phone){
              this.phone = phone;
            },
              current: nodes[1],
              next:nodes[2]
          ),

          RoundedInputField(

            hintText: "Эл. Почта",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            onChanged: (email){
              this.email = email;
            },
              current: nodes[2],
              next:nodes[3]
          ),
          RoundedPasswordField(

            hintText: "Пароль",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
            onChanged: (password){

              this.password = password;
            },
              current: nodes[3],
              next:nodes[4]

          ),
          RoundedPasswordField(

            hintText: "Повторите пароль",
            keyboard: TextInputType.visiblePassword,
            width: 0.85,
            maxHeight: 0.07,
            maxCharacters: 30,
              current: nodes[4],

            onChanged: (password){

              this.confPassword = password;
            },
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
              errorLabel = "";
              isError = false;
              if(nameSurname.length==0 || phone.length==0 || email.length==0 || password.length==0 || confPassword.length==0){
                if(!isError){
                errorLabel +="Все поля должны быть заполнены ";
                isError = true;
                }
              }

              if(phone.length<18){
                if(!isError){
                  errorLabel +="Убедитесь, что вы правильно указали телефон";
                  isError = true;
                }
              }

              if(!validateEmail(email)){

              if(!isError) {
                errorLabel += "Убедитесь, что вы правильно указали почту";
                isError = true;
              }
              }

              if(password.length<6){
                if(!isError) {
                  errorLabel += "Длина пароля должна быть больше 6 знаков";
                  isError = true;
                }
              }
              if(!validatePassword(password)){
                if(!isError) {
                  errorLabel += "Убедитесь что пароль содержит хотя бы одну букву и одну цифру";
                  isError = true;
                }

              }



              if(this.confPassword != this.password){
                if(!isError) {


                  errorLabel += "Убедитесь, что пароли совпадают";
                  isError = true;
                }
              }



                if(!isError ){
                  if(checkedValue){
                        UserEntity entity = await APIRequests().signUpUser(this.email,
                            "0", this.phone, this.nameSurname, this.password);
                        print("phone: "+entity.phone);
                    }
                  else{
                    errorLabel += "Необходимо дать согласие на обратоку персональных данных";
                  }

                }

                setState(() {

                });

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
                            builder: (context) => LoginScreen()
                        )
                        );

                      },
                      child:Text("Уже с нами? Войти",

                        style: Theme.of(context)
                            .textTheme
                            .headline3,)
                  ))
          ),


        ],

      )),


    );
  }

bool validateEmail(String email){
 return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool validatePassword(String password){

    return RegExp(r"^(?=.*[0-9])(?=.*[a-z]).{6,32}$").hasMatch(password);
}


}