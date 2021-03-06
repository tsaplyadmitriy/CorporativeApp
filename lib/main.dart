import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/regex.dart';
import 'package:lipsar_app/notifications.dart';
import 'package:lipsar_app/widgets/app_preview.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/splash_screen_login.dart';
import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;
Map<RegexType, String> regexes;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);

  List<Regex> regexList = await APIRequests().getRegexes();

  regexes = {
    RegexType.PASSWORD:regexList[0].regex,
    RegexType.EMAIL:regexList[1].regex,
    RegexType.NAME:regexList[2].regex,

  };

  print(regexList.toString());
  // for(int i = 0;i<regexList.length;i++){
  //   Regex reg = regexList[i];
  //   print(reg);
  //   regexes[reg.type] = reg.regex;
  // }
  print(regexes.values.toString());

  await Firebase.initializeApp();

  runApp(EasyLocalization(child: MyApp(), supportedLocales:  [Locale('ru'),Locale('en')], path: 'android/assets/translations',fallbackLocale: Locale('ru'),),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    return GestureDetector(
        onTap: () {

          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }

        },

    child:MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'TronicShow',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
        ),
        textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
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
            fontSize: 16,
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          headline6: TextStyle(

            color: constants.accentColor,
            fontSize: 12,
          ),

        ),

        primaryColor: constants.kPrimaryColor,
        accentColor: constants.kPrimaryColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppPreview(),
    ));
  }
}





