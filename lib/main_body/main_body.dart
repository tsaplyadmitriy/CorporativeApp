import 'package:flutter/cupertino.dart';
import 'package:lipsar_app/widgets/base_screen.dart';

class MainBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return BaseScreen(
     isReturnable: true,
     child: Container(
       child: Align(
         alignment: Alignment.center,
         child: Text("Вы успешно вошли в свой аккаунт!"),


       ),

     ),
   );
  }




}