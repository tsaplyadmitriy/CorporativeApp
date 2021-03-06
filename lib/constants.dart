
import 'package:flutter/cupertino.dart';
typedef Future<bool> ConfirmFunction(String token, String code);
class constants{


  static final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff2700fd), Color(0xff6900ff)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 70, 200));

  static const Color kPrimaryColor = Color(0xffb056fc);
  static const Color accentColor = Color(0xffFF00F2);
  static const Color kBackgroundColor = Color(0xffD6E6FF);
  static const baseUrl = 'https://api.tronic.show';
  static const bigTextSize = 18.0;

}