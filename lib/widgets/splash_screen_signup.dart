import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/widgets/splash_flags.dart';

import 'confirm/confirm_screen.dart';

class SplashScreenSignUp extends StatelessWidget{

  Function onError;
  Function onSuccess;


  String email;
  String password;
  String name;

  SplashScreenSignUp({this.onError,this.onSuccess,this.email,this.password,this.name});

  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();




  Widget  loginLogic(UserSession userSession, BuildContext context){

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(SplashFlags.isSplashActive) {

        print(userSession.respcode);
        if(userSession.respcode==409 ){
          onError.call();
        }
        else if (userSession.respcode == 201) {

            onSuccess.call(userSession.token);

        }
      }
      Navigator.pop(context);
    });

    return Scaffold(body:Text("Вы успешно создали аккаунт"));

  }

  Widget getNoConnectionWidget(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        new Text("No Internet Connection"),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    );
  }
  @override
  Widget build(BuildContext context) {

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async =>   await APIRequests().signUpUser(this.email,
          this.name, this.password),
      renderLoad: () => WillPopScope(
          onWillPop: ()async=>false,
          child: Center(child: new CircularProgressIndicator())

      ),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({ data}) => loginLogic(data, context),
    );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: new Container(
          child:Center(
              child: _asyncLoader

          )),
      backgroundColor: constants.kBackgroundColor,



    );
  }


}