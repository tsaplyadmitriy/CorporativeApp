import 'package:flutter/cupertino.dart';
import 'package:lipsar_app/widgets/base_screen.dart';
import 'package:lipsar_app/widgets/recovery/recovery_body.dart';
import 'package:lipsar_app/widgets/signup/signup_body.dart';

class RecoveryScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return new BaseScreen(
      isReturnable: true,
      child: new RecoveryBody(),
    );

  }







}