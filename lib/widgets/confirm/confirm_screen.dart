import 'package:flutter/cupertino.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:lipsar_app/widgets/confirm/confirm_body.dart';
import 'package:lipsar_app/widgets/signup/signup_body.dart';

class ConfirmScreen extends StatelessWidget{

  String email;
  String phone;
  String nameSurname;
  String password;
  String token;
  ConfirmScreen({this.email,this.phone,this.nameSurname,this.password,this.token});

  @override
  Widget build(BuildContext context) {

    return new BaseScreen(
      isReturnable: true,
      child: new ConfirmBody(

        email: this.email,
        nameSurname: this.nameSurname,
        password: this.password,
        phone: this.phone,
        token:this.token

      ),
    );

  }







}