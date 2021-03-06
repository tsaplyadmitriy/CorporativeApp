import 'package:async_loader/async_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/comments/comment_field.dart';
import 'package:lipsar_app/components/logout_button.dart';
import 'package:lipsar_app/components/rounded_button.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/custom_material_page_route.dart';
import 'package:lipsar_app/entities/stream_entity.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:lipsar_app/main_body/main_body.dart';
import 'package:lipsar_app/notifications.dart';
import 'package:lipsar_app/session_keeper.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lipsar_app/widgets/splash_screen_join.dart';

import '../main.dart';

class StreamPreview extends StatefulWidget{

  String token;
  StreamPreview({this.token});
  @override
  State<StatefulWidget> createState() => _StatePreview(token:token);


}



class _StatePreview extends State<StreamPreview>{
  StreamEntity stream;
  int millisecHour;
  int millisecMin;
  int days;
  int hours;
  int minutes;
  bool ongoing = false;
  String token;
  _StatePreview({this.token});
  bool checkedValue ;




  final  GlobalKey<AsyncLoaderState> asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  final  GlobalKey<AsyncLoaderState> imageAsyncLoaderState =
  new GlobalKey<AsyncLoaderState>();
  final  GlobalKey<AsyncLoaderState> counterAsyncLoaderState =
  new GlobalKey<AsyncLoaderState>();


  @override
  void initState(){

    super.initState();
  }


  @override
  void dispose(){


    super.dispose();
  }


  Widget getNoConnectionWidget(dynamic error){
    print("on error");
    print(error);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(context, CustomMaterialPageRoute(
          builder: (context) =>
              LoginScreen(
                errorLabel: "Ваш аккаунт был добавлен в чёрный список",)));
    });
    return Scaffold(body:Container(child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child:
            new Text("nointernetconn".tr())),
        new FlatButton(
            color: Colors.red,
            child: new Text("retry".tr(), style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    )));
  }





  Widget previewLogic(List<StreamEntity> data, BuildContext context){

    Size size = MediaQuery.of(context).size;

    stream  = data[0];

    if(checkedValue==null)checkedValue = stream.markedToNotification;



    var imageAsyncLoader = new AsyncLoader(
      key: imageAsyncLoaderState,
      initState: () async => await APIRequests().getStreamImage(token:this.token,id:data[0].id).timeout(Duration(seconds: 10)) ,
      renderLoad: () => WillPopScope(
          onWillPop: ()async=>false,
          child: Container(child:Center(child: new CircularProgressIndicator()))
      ),
      renderError: ([error]) => getNoConnectionWidget(error),
      renderSuccess: ({ data}) {




        return Container(
          width: size.height*0.35,
          height: size.height*0.35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white,width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 18,
                blurRadius: 18,

                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            image: DecorationImage(

                image: data,
                fit: BoxFit.cover
            ),
          ),
        );


      },
    );




    if( data[0].date-DateTime.now().millisecondsSinceEpoch>0) {
      millisecHour = Duration(
          milliseconds: (data[0].date - Duration(hours: 1).inMilliseconds)
              .abs()).inMilliseconds;
      millisecMin = Duration(
          milliseconds: (data[0].date - Duration(minutes: 5).inMilliseconds)
              .abs()).inMilliseconds;
      days = Duration(milliseconds: (data[0].date - DateTime
          .now()
          .millisecondsSinceEpoch).abs()).inDays;
      hours = Duration(milliseconds: (data[0].date - DateTime
          .now()
          .millisecondsSinceEpoch).abs()).inHours - days * 24;

      minutes = Duration(milliseconds: (data[0].date - DateTime
          .now()
          .millisecondsSinceEpoch)).inMinutes - (hours * 60) - days*24*60;

      var t=hours*60;
      print(Duration(milliseconds: (data[0].date - DateTime
          .now()
          .millisecondsSinceEpoch)).inMinutes.toString()+"/"+t.toString());
      ongoing  =false;
    }else{
      days = 1;
      minutes = 1;
      hours = 1;
      ongoing  = true;
      millisecHour = Duration(
          milliseconds: (data[0].date - Duration(hours: 1).inMilliseconds)
              .abs()).inMilliseconds;
      millisecMin = Duration(
          milliseconds: (data[0].date - Duration(minutes: 5).inMilliseconds)
              .abs()).inMilliseconds;
    }
    print(Duration(milliseconds: ( data[0].date-DateTime.now().millisecondsSinceEpoch).abs()));


    String dayString = "";
    if(days%10<=4){
      if(days%10==1){
        dayString = "day1".tr();
      }else{
        if(days%10 ==0){
          dayString = "day2".tr();
        }else{
          dayString = "day3".tr();
        }

      }
    }else{
      dayString = "day2".tr();
    }
    String hourString = "";
    if(hours%10<=4){
      if(hours%10==1){
        hourString = "hour1".tr();
      }else{
        if(hours%10 ==0){
          hourString = "hour2".tr();
        }else{
          hourString = "hour3".tr();
        }

      }
    }else{
      hourString = "hour2".tr();
    }
    String minString = "";
    if(minutes%10<=4){
      if(minutes%10==1){
        minString = "mins1".tr();
      }else{
        if(minutes%10 ==0){
          minString = "mins2".tr();
        }else{
          minString = "mins3".tr();
        }

      }
    }else{
      minString = "mins2".tr();
    }


    var countDown = new AsyncLoader(
      key: counterAsyncLoaderState,
      initState: () async  {
        while(!(days==0 && hours == 0 && minutes ==0)){
          await  Future.delayed(const Duration(seconds: 10), () {
            if(data[0].date-DateTime.now().millisecondsSinceEpoch>0) {

              if((data[0].date - Duration(hours: 1).inMilliseconds)>=0){
              millisecHour = Duration(
                  milliseconds: (data[0].date - Duration(hours: 1).inMilliseconds)
                      ).inMilliseconds;
              }else{
                millisecHour = -1;
              }

              if((data[0].date - Duration(minutes: 5).inMilliseconds)>=0){
              millisecMin = Duration(
                  milliseconds: (data[0].date - Duration(minutes: 5).inMilliseconds)
                      ).inMilliseconds;
              }else{
                millisecMin = -1;
              }
              days = Duration(milliseconds: (data[0].date - DateTime
                  .now()
                  .millisecondsSinceEpoch).abs()).inDays;
              hours = Duration(milliseconds: (data[0].date - DateTime
                  .now()
                  .millisecondsSinceEpoch).abs()).inHours - days * 24;
              minutes = Duration(milliseconds: (data[0].date - DateTime
                  .now()
                  .millisecondsSinceEpoch).abs()).inMinutes - (hours * 60) - days*24*60;
              ongoing = false;
            }else{
              days = 1;
              minutes = 1;
              hours = 1;
              ongoing = true;
            }
            if(mounted)setState(() {});

          });
        }

        return 0;
      }
      ,
      renderLoad: () =>     ongoing?Text("streamhasstarted".tr(),style: TextStyle(fontFamily: "Baloo",fontStyle:FontStyle.normal,fontSize: 16,color: Colors.black26),):Container(
        child: Column(
          children: [


            Text("tillconcert".tr(),style: TextStyle(
              fontFamily: "Baloo",
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            )),
            SizedBox(height: 10,),
            Container(
                //padding: EdgeInsets.only(left: 20,right: 20),
                child:IntrinsicHeight
                  (

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Text(days.toString(),style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 36),),
                            Text(dayString,style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w700,fontSize: 18),),
                          ],
                        ),
                      ),

                      SizedBox(width: 10,),
                      VerticalDivider(color: Colors.black12,width: 2,thickness: 2),
                      SizedBox(width: 10,),
                      Container(
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Text(hours.toString(),style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 36),),
                            Text(hourString,style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w700,fontSize: 18),),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      VerticalDivider(color: Colors.black12,width: 2,thickness: 2,),
                      SizedBox(width: 10,),
                      Container(
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Text(minutes.toString(),style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 36),),
                            Text(minString,style: TextStyle(color:Colors.black26,fontFamily: 'Montserrat',fontWeight: FontWeight.w700,fontSize: 18),),
                          ],
                        ),
                      ),
                    ],
                  ),

                )

            ),

          ],
        ),
      ),

      renderSuccess: ({data}) =>
          Center(
            child:
           Text("streamhasstarted".tr(),style: TextStyle(
             fontFamily: "Baloo",
             color: Colors.grey,
             fontSize: 16,
             fontWeight: FontWeight.normal,
           ))
          )
      ,
    );




    return WillPopScope(

        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top:10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


                Container(
                  margin: EdgeInsets.only(right: 5,top: 5),

                 child:LogoutButton(
                   token: this.token,
                    onPress:()async{
                      asyncLoaderState.currentState.deactivate();
                      imageAsyncLoaderState.currentState.deactivate();
                      counterAsyncLoaderState.currentState.deactivate();
                    }
                )),

                imageAsyncLoader,
                Container(
                  child: Column(
                    children: [
                      Text(data[0].name.toUpperCase(),style:TextStyle(color:constants.accentColor,fontFamily: 'Montserrat',fontWeight: FontWeight.w900,fontSize: 36)),
                      Text(data[0].style,style: TextStyle(color: Colors.black26),),

                    ],
                  ),
                ),



                countDown,



                Container(
                  child: Column(children: [


                    Align(
                        alignment: Alignment.center,
                        child:
                    Container(
                        padding: EdgeInsets.only(left:size.width*0.1),

                        child:Row(
                          children: [
                            if( !ongoing)Checkbox(

                                value: checkedValue,
                                activeColor: constants.accentColor,

                                onChanged: (state)async{





                                  print(checkedValue);

                                  if(mounted)setState(() {
                                    checkedValue = state;
                                  });

                                  if(checkedValue){
                                    await APIRequests().sendStreamNotificationByEmail(token: this.token,id: stream.id);
                                  }else{
                                    await APIRequests().cancelStreamNotificationByEmail(token: this.token,id: stream.id);
                                  }

                                  print(checkedValue);

                                }),
                            if (!ongoing)Text("remindme".tr(),style: Theme.of(context).textTheme.headline4,)

                          ],

                        ))),
                    Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child:
                        RoundedButton(
                          text: "join".tr(),
                          textSize: 14,
                          textColor: Colors.white,

                          press:()async{


                            print("hour"+DateTime.fromMillisecondsSinceEpoch(
                                millisecHour).toString());
                            print("min"+DateTime.fromMillisecondsSinceEpoch(
                                millisecMin).toString());
                            print("now"+DateTime.now().toString());
                            if(millisecHour
                                >=DateTime.now().millisecondsSinceEpoch) {
                              print("hour notification has been sent");
                              await scheduleNotificationHour(
                                  flutterLocalNotificationsPlugin, "2",
                                  "hourreminder".tr(),
                                  DateTime.fromMillisecondsSinceEpoch(
                                      millisecHour));
                              print("hour notification has been sent2");

                            }
                               if( millisecMin
                                   >=DateTime.now().millisecondsSinceEpoch){
                                 print("time"+ (millisecMin
                                     >DateTime.now().millisecondsSinceEpoch).toString());
                               await scheduleNotification(
                                   flutterLocalNotificationsPlugin, "3",
                                   "minutereminder".tr(),
                                  DateTime.fromMillisecondsSinceEpoch(
                                       millisecMin));

                             }
                            // var banUsers =  bannedUsers();
                            // var banMessages =  bannedMessages() ;
                            //
                            //
                            // // stream.comments = await FirebaseFirestore.instance
                            // //     .collection('streams').doc(stream.id).collection('messages').snapshots()
                            //
                            //
                            // var respectsQuery = FirebaseFirestore.instance.
                            // collection('streams').doc(stream.id).collection('messages');
                            //
                            // var querySnapshot = await respectsQuery.get();
                            // stream.comments = querySnapshot.docs.length;
                            //
                            // print("comm"+stream.comments.toString());
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context) => SplashScreenJoin(stream: stream,token: this.token
                                  )));

                          } ,
                        )
                    ),
                  ],),
                ),


              ],
            ),

          ),

        ),

        onWillPop: ()async{
          return  false;
        }

    );
  }



  Future<List<StreamEntity>> streamLogic(String token)async {

    SessionKeeper.user = await APIRequests().getProfile(this.token).timeout(Duration(seconds: 10));






    return  APIRequests().getOngoing(this.token).timeout(Duration(seconds: 10));;
  }



  @override
  Widget build(BuildContext context) {


    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await streamLogic(this.token) ,
      renderLoad: () => WillPopScope(
          onWillPop: ()async=>false,
          child: Scaffold(body:Container(child:Center(child: new CircularProgressIndicator())))

      ),
      renderError: ([error]) => getNoConnectionWidget(error),
      renderSuccess: ({ data}) => previewLogic(data, context),
    );
    return _asyncLoader;
  }


}