import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/main_body/stream_preview.dart';
import 'package:lipsar_app/session_keeper.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/splash_flags.dart';

import 'confirm/confirm_screen.dart';

class SplashScreenLogin extends StatelessWidget{

  Function onError;
  Function onSuccess;
  Function onVerify;
  String email;
  String password;

  SplashScreenLogin({this.onError,this.onSuccess,this.email,this.password,this.onVerify});

  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();




  Widget  loginLogic(UserSession userSession, BuildContext context) {


      if(SplashFlags.isSplashActive) {


        if (userSession.respcode == 401) {



          return LoginScreen(errorLabel: "Неправильный логин или пароль",);
        }
        else if (userSession.respcode == 200) {
          SessionKeeper.email = this.email;
          SessionKeeper.password  = this.password;


          if (userSession.emailVerified) {
            return new StreamPreview(token:userSession.token,);
          } else {


                   return   ConfirmScreen(token:userSession.token,);

          }
        }
      }
      Navigator.pop(context);



  }

  Widget getNoConnectionWidget(dynamic error){
    print("on error");
    print(error);
    return Scaffold(body:Container(child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child:
        new Text("No Internet Connection ")),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry ", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    )));
  }
  Future<UserSession> loginFuture()async {

    UserSession session = await APIRequests().loginUser(this.email, this.password);
    print("Session"+session.toString());
    return APIRequests().loginUser(this.email, this.password);

  }


  @override
  Widget build(BuildContext context) {

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await loginFuture().timeout(Duration(seconds: 30)) ,
      renderLoad: () => WillPopScope(
        onWillPop: ()async=>false,
          child: Scaffold(body:Container(child:Center(child: new CircularProgressIndicator())))

      ),
      renderError: ([error]) => getNoConnectionWidget(error),
      renderSuccess: ({ data}) => loginLogic(data, context),
    );

    Size size = MediaQuery.of(context).size;
    return _asyncLoader;
  }


}