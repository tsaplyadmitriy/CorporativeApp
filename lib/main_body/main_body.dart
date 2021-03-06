

import 'package:async_loader/async_loader.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:like_button/like_button.dart';
import 'package:lipsar_app/api_requests/api_requests.dart';
import 'package:lipsar_app/comments/comment_field.dart';
import 'package:lipsar_app/components/better_player_material_clickable_widget.dart';
import 'package:lipsar_app/components/logout_button.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/stream_entity.dart';
import 'package:lipsar_app/my_flutter_app_icons.dart';
import 'package:lipsar_app/widgets/login/login_screen.dart';
import 'package:lipsar_app/widgets/splash_flags.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yoyo_player/yoyo_player.dart';






class MainBody extends StatefulWidget{
  String token;
  List<String>initBanMessage;
  List<String>initBanUsers;


  final StreamEntity stream;
  MainBody({this.token,this.stream,this.initBanUsers,this.initBanMessage});




  @override
  State<StatefulWidget> createState() => _MainBody(token:token,stream: stream,initBanMessage:initBanMessage,initBanUsers:initBanUsers);



}

 YoYoPlayer _betterPlayerController;
// = BetterPlayerController(
//
//
//     BetterPlayerConfiguration(
//
//
//
//         controlsConfiguration: BetterPlayerControlsConfiguration (
//             controlBarColor:Colors.black,
//             enablePlayPause: false,
//
//             overflowMenuCustomItems:<BetterPlayerOverflowMenuItem>[
//               BetterPlayerOverflowMenuItem(Icons.style,"check",(){})
//
//             ],
//             enableSkips:false,
//             liveTextColor: constants.accentColor
//         ),
//         autoPlay: true
//     ),
//
//     betterPlayerDataSource: BetterPlayerDataSource(
//       BetterPlayerDataSourceType.NETWORK,
//       //stream.sources[0].url+"?access_token="+this.token,
//       //"https://video.tronic.show/hls/123_480p1128kbs/index.m3u8",
//       "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
//       liveStream: true,
//
//       subtitles: BetterPlayerSubtitlesSource.single(
//         type: BetterPlayerSubtitlesSourceType.NETWORK,
//
//       ),
//     ));

class _MainBody extends State<MainBody>{
  bool liked;
  String token;
  final StreamEntity stream;
  List<String>initBanMessage;
  List<String>initBanUsers;
  int views;
  int comments;
  bool isActive ;
  int likedNumber;
  bool fullscreen = false;
  _MainBody({this.token,this.stream,this.initBanMessage,this.initBanUsers});




  @override
  void initState() {

 // print(_betterPlayerController)


    isActive = true;
    views = stream.viewCount;
    comments  = stream.comments;
    super.initState();
    initObjects();

  }


  void initObjects(){


    _betterPlayerController =  YoYoPlayer(
      aspectRatio: 16 / 9,
      url:  stream.sources[0].url+"?access_token="+this.token,
      videoStyle: VideoStyle(),

      videoLoadingStyle: VideoLoadingStyle(),
    );
    // _betterPlayerController = BetterPlayerController(
    //
    //
    //     BetterPlayerConfiguration(
    //
    //
    //
    //         fullScreenAspectRatio: 16.0/9.0,
    //
    //         errorBuilder: (context, message)
    //         {
    //           if (message.contains("BehindLiveWindowException")) {
    //
    //
    //             initObjects();
    //             return Container(alignment:Alignment.center,child:Text("Reloading..."));
    //           }else{
    //
    //             print("ERROR" + message);
    //
    //
    //             // YoutubePlayerController _controller = YoutubePlayerController(
    //             //   initialVideoId: 'Dx5qFachd3A',
    //             //   //stream.sources[1].url.split("v=")[1],//stream.sources[1].url
    //             //   flags: YoutubePlayerFlags(
    //             //     isLive: true,
    //             //     autoPlay: true,
    //             //     mute: false,
    //             //   ),
    //             // );
    //
    //
    //             return  Container(alignment:Alignment.center,child:Text("startsoon".tr()));
    //             // return YoutubePlayer(
    //             //
    //             //   controller: _controller,
    //             //   liveUIColor: constants.accentColor                );
    //           }
    //         },
    //
    //         controlsConfiguration: BetterPlayerControlsConfiguration (
    //             controlBarColor:Colors.black,
    //
    //             enablePlayPause: true,
    //
    //             enableOverflowMenu:false,
    //             enableSkips:false,
    //             liveTextColor: constants.accentColor
    //         ),
    //         autoPlay: true
    //     ),
    //
    //     betterPlayerDataSource: BetterPlayerDataSource(
    //
    //       BetterPlayerDataSourceType.network,
    //       stream.sources[0].url+"?access_token="+this.token,
    //       //'https://www.youtube.com/watch?v=LVHOEGyKkrw',
    //       //"https://video.tronic.show/hls/123_480p1128kbs/index.m3u8",
    //       //"https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
    //       liveStream: true,
    //
    //
    //
    //       subtitles: BetterPlayerSubtitlesSource.single(
    //         type: BetterPlayerSubtitlesSourceType.network,
    //
    //       ),
    //     ));


    print("init"+stream.likesCount.toString());
    liked = stream.liked;
    likedNumber = stream.likesCount;
  }




  final  GlobalKey<AsyncLoaderState> viewsLoaderState =
  new GlobalKey<AsyncLoaderState>();


    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;

      print(size.height*0.57-(9.0/16.0)*size.width);

      var viewsLoader = new AsyncLoader(
        key: viewsLoaderState,
        initState: () async {



          print("views:  "+views.toString());
          print("comments:  "+comments.toString());

         // setState(() {});

          while(isActive){
            await  Future.delayed(const Duration(seconds: 20), () async{
              views = await APIRequests().heartbeatStreamViews(token: this.token,id: stream.id);
              likedNumber = await APIRequests().heartbeatStreamLikes(token: this.token,id: stream.id);
              var respectsQuery = FirebaseFirestore.instance.
              collection('streams').doc(stream.id).collection('messages');

              var querySnapshot = await respectsQuery.get();
              comments = querySnapshot.docs.length;
              print(comments.toString()+" comments");

              if(mounted)setState(() {});


            });
          }
          return true;
        } ,
        renderLoad: () => Container(
            child:Row(
              children: [
                Icon(Icons.play_arrow,size: 24,color: Colors.grey,),
                Text(views.toString(),
                    style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "Montserrat",fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 8,),
                Icon(MyFlutterApp.heart,size: 14,color: Colors.grey,),
                SizedBox(width: 5,),
                Text(likedNumber.toString(),
                  style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "Montserrat",fontWeight: FontWeight.normal),),
                SizedBox(width: 8,),
                Icon(Icons.message,size: 14,color: Colors.grey,),
                SizedBox(width: 5,),
                Text(comments.toString(),
                  style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "Montserrat",fontWeight: FontWeight.normal),)
              ],
            )
        ),
        renderError: ([error]) =>Container(child:Row(children: [Icon(Icons.play_arrow,size: 24,color: Colors.grey,),Text("--",
          style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: "Montserrat",fontWeight: FontWeight.normal),)],)),
        renderSuccess: ({data}) => Container(child:Row(children: [Icon(Icons.play_arrow,size: 24,color: Colors.grey,),Text(views.toString(),
          style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: "Montserrat",fontWeight: FontWeight.normal),)],)),
      );




        return WillPopScope(
            onWillPop: ()async {

             // viewsLoaderState.currentState.dispose();
              isActive = false;
              viewsLoaderState.currentState.deactivate();
              if(_betterPlayerController!=null){
               // _betterPlayerController.pause();
                //_betterPlayerController.


              }

              Navigator.pop(context);
                return true;
            },
            child:Scaffold(

              appBar: AppBar(backgroundColor: Colors.black,
                toolbarHeight: size.height*0.065,
                actions: [

                //    Align(
                //     alignment: Alignment.centerLeft,
                //     child:IconButton(
                //
                //       onPressed: (){
                //         Navigator.pop(context);
                //
                //       },
                //       icon:Icon(Icons.arrow_back_rounded),
                //       color: Colors.white,)
                // ),
              ],),
            body:
            SingleChildScrollView(child:Container(
              width: size.width,

             // margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

              Container(

                  height: (9.0/16.0)*size.width,

                 // margin: EdgeInsets.only(left: 15,right: 15),
                    child:(_betterPlayerController!=null)?AspectRatio(

                aspectRatio: 16 / 9,
                child: _betterPlayerController



              ):Text(" ")),




                Container(
                  margin:EdgeInsets.only(top: 10),
                    child:Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[



                        Align(

                         alignment: Alignment.centerRight,


                         child: Container(
                             margin: EdgeInsets.only(left: 15),

                            child:LikeButton(
                             onTap: (touched)async{


                               if(liked){

                                 liked = false;
                                 print(liked);

                                 likedNumber = await APIRequests().unlikeStream(token: this.token,id:stream.id);
                                 if(mounted)setState(() {});

                               }else{

                                  liked = true;
                                  print(liked);

                                  likedNumber = await APIRequests().likeStream(token: this.token,id:stream.id);

                                  if(mounted)setState(() {});
                               }
                               stream.liked = liked;
                               stream.likesCount = likedNumber;
                                return true;

                             },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                 isLiked ? MyFlutterApp.heart : MyFlutterApp.heart_empty,
                                  color: isLiked ? constants.accentColor : Colors.grey,
                                  size: size.height*0.04,
                                );
                              },
                             // likeCount:likedNumber,
                                isLiked: liked,

                            )

                        )),
                        Container(

                            margin: EdgeInsets.only(right: 15),
                            child:viewsLoader

                        ),



                      ])),



                 CommentField(
                   initBanMessage: initBanMessage,
                   initBanUsers: initBanUsers,
                   streamId: stream.id,
                   token: this.token,
                   onMessageSend: (){
                     comments++;
                     setState(() {

                     });
                   },
                 )



                ]
            )
            ))
            ));

    }







}