import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';

import '../custom_material_page_route.dart';

class LogoutButton extends StatelessWidget{
  final Function onPress;
  final String token;

  const LogoutButton({this.onPress,this.token});

  @override
  Widget build(BuildContext context) {

   return    Align(
       alignment: Alignment.centerRight,
       child:Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children:[

             IconButton(

               onPressed: ()async {
                 onPress.call();
                 await APIRequests().logoutUser(token);

                 Navigator.pushReplacement(context,CustomMaterialPageRoute(
                     builder: (context) => LoginScreen(isLogout:true)
                 ));

               },

               icon:Icon(Icons.logout),
               color: constants.accentColor,
             )
           ]
       )

   );
  }




}