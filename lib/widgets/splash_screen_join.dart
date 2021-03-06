import 'package:async_loader/async_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/comments/comment_field.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/stream_entity.dart';
import 'package:lipsar_app/entities/user_session.dart';
import 'package:lipsar_app/main.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/main_body/stream_preview.dart';
import 'package:lipsar_app/session_keeper.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/splash_flags.dart';

import 'confirm/confirm_screen.dart';

class SplashScreenJoin extends StatelessWidget{

  Function onError;
  Function onSuccess;
  Function onVerify;

  String token;
  StreamEntity stream;

  SplashScreenJoin({this.onError,this.onSuccess,this.token,this.stream});

  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();




  Widget  joinLogic(Widget mainBody, BuildContext context) {


   return mainBody;


  }

  Widget getNoConnectionWidget(){
    return Scaffold(body:Container(child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child:
            new Text("No Internet Connection")),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    )));
  }
  Future<Widget> loadFuture()async {

    var banUsers =  bannedUsers();
    var banMessages =  bannedMessages() ;





    var respectsQuery = FirebaseFirestore.instance.
    collection('streams').doc(stream.id).collection('messages');

    var querySnapshot = await respectsQuery.get();
    stream.comments = querySnapshot.docs.length;
   return MainBody(stream: stream,token: this.token,initBanMessage: banMessages
          ,initBanUsers: banUsers,);


  }


  @override
  Widget build(BuildContext context) {

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await loadFuture().timeout(Duration(seconds: 30)) ,
      renderLoad: () => WillPopScope(
          onWillPop: ()async=>false,
          child: Scaffold(body:Container(child:Center(child: new CircularProgressIndicator())))

      ),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({ data}) => joinLogic(data, context),
    );

    Size size = MediaQuery.of(context).size;
    return _asyncLoader;
  }


}