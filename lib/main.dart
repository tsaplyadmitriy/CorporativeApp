import 'package:flutter/material.dart';
import 'package:lipsar_app/constants.dart';
import 'file:///C:/Users/Dmitriy/Desktop/FSERepo/lipsar_app/lib/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'ProductSans',

        textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: constants.bigTextSize,
          fontWeight: FontWeight.w700,
         ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            fontSize: 18,
          ),
          headline3: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,

          ),
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),

        ),

        primaryColor: constants.kPrimaryColor,
        accentColor: constants.kPrimaryColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}





