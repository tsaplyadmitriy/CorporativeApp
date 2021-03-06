import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/recovery_session.dart';
import 'package:lipsar_app/entities/regex.dart';
import 'package:lipsar_app/entities/stream_entity.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lipsar_app/entities/user_session.dart';



class APIRequests {
  static final APIRequests _singleton = APIRequests._internal();

  factory APIRequests() {
    return _singleton;
  }

  APIRequests._internal(){
  } //private constructor

  Future<UserSession> loginUser(String email,String password)async {

    print("logging in");
    var url = constants.baseUrl+"/api/v1/auth/login";
    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'password': password,'login':email}));

    print("Resp: "+response.body);

    final responseJson = jsonDecode(response.body);

    return UserSession.fromJson(responseJson,response.statusCode);


  }

  Future<bool> logoutUser(String token)async {
    var url = constants.baseUrl+"/api/v1/auth/logout";
    var response = await http.post(url,
        headers:{HttpHeaders.authorizationHeader:token},
        );

    print(response.body);

    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }


  Future<String> getLicenseAgreement()async{
    var url = constants.baseUrl+"/api/v1/license-agreement";
    var response = await http.get(url);
    print("License agreement:"+utf8.decode(response.bodyBytes).toString());
    return utf8.decode(response.bodyBytes).toString();
  }
  Future<String> getDataAgreement()async{
    var url = constants.baseUrl+"/api/v1/data-processing-policy";
    var response = await http.get(url);
    print("License agreement:"+utf8.decode(response.bodyBytes).toString());
    return utf8.decode(response.bodyBytes).toString();
  }

  Future<UserEntity> getProfile(String token)async {
    var url = constants.baseUrl+'/api/v1/profile';
    var response = await http.get(url,headers: {HttpHeaders.authorizationHeader:token});
    print("Resp2:"+response.body);

    return UserEntity.fromJson(json.decode(utf8.decode(response.bodyBytes)), response.statusCode);


  }

  Future<UserSession> signUpUser(String email,   String name,String password)async {

    var url = constants.baseUrl+"/api/v1/auth/register";

    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'email':email,'password': password,'username':name}));

    print("re"+response.body.toString()+"/");
    final responseJson = jsonDecode(response.body);

    return UserSession.fromJson(responseJson,response.statusCode);


  }

  Future<bool> verifyEmail(String code,String token)async {
    var url = constants.baseUrl + "/api/v1/verify/email";
    print(token);
    var response = await http.post(url,
        headers: {'Content-type': 'application/json',HttpHeaders.authorizationHeader: token},
        body: jsonEncode({
         'verificationCode':int.parse(code)
        }));

    int respCode = response.statusCode;
    print(respCode);
   if(respCode==200){
     return true;
   }else{
     return false;
   }




  }
  Future<bool> sendVerificationCode(String token)async {
      print("start");
      var url = constants.baseUrl+'/api/v1/verify/email/send-code';
      var response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: token},
         );

      int respCode = response.statusCode;
      print("end");
      print(respCode);
      if(respCode==200){
        return true;
      }else{
        return false;
      }

  }

  Future<int> applyPasswordRecovery( String email)async {

    print(email);
    var url = constants.baseUrl + "/api/v1/auth/password/recover";

    var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'email':email
        }));

    return  response.statusCode;

  }

  Future<RecoverySession> requestPasswordRecovery(String email, String code)async{
    var url = constants.baseUrl + "/api/v1/auth/password/recover/verify";


    var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'email':email,
          'verificationCode':int.parse(code)
        }));
    print(response.body.toString());

    return  RecoverySession.fromJson(jsonDecode(response.body), response.statusCode);


  }

  Future<UserSession> requestPasswordChange(String passwordToken, String newPassword) async {

    var url = constants.baseUrl + "/api/v1/auth/password";

    var response = await http.put(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'newPassword':newPassword,
          'passwordRecoveryToken':passwordToken
        }));
    print(response.body.toString());

    return  UserSession.fromJson(jsonDecode(response.body), response.statusCode);


  }

  Future<List<StreamEntity>> getOngoing(String token)async{
    var url = constants.baseUrl+'/api/v1/stream/video/ongoing';
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader:token,HttpHeaders.acceptCharsetHeader:"utf-8"});

    List<dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));


    print(responseJson.toString());
    List<StreamEntity>list = (responseJson).map((i) =>StreamEntity.fromJson(i,response.statusCode)).toList();
    return  list;

  }

  Future<MemoryImage> getStreamImage({String token, String id})async{

    var url = constants.baseUrl+'/api/v1/stream/video/'+id+'/preview/image';
    final response = await http.get(url,headers: {HttpHeaders.authorizationHeader:token});

    return MemoryImage(response.bodyBytes);

  }

  Future<bool> sendStreamNotificationByEmail({String token, String id})async {
    var url = constants.baseUrl+'/api/v1/stream/video/$id/notify/email';
    final response = await http.put(url,headers: {HttpHeaders.authorizationHeader:token});

    if(response.statusCode==200){
      return true;
    }
    return false;

  }

  Future<bool> cancelStreamNotificationByEmail({String token, String id})async {
    var url = constants.baseUrl+'/api/v1/stream/video/$id/notify/email';
    final response = await http.delete(url,headers: {HttpHeaders.authorizationHeader:token});

    if(response.statusCode==200){
      return true;
    }
    return false;

  }
  Future<int> likeStream({String token, String id})async {
    var url = constants.baseUrl+'/api/v1/stream/video/$id/like';
    final response = await http.put(url,headers: {HttpHeaders.authorizationHeader:token});

    print(response.body);
    int likes = int.parse(response.body);
    print (likes);
    if(response.statusCode==200){
      return likes;
    }
    return 0;

  }
  Future<int> unlikeStream({String token, String id})async {
    var url = constants.baseUrl+'/api/v1/stream/video/$id/like';
    final response = await http.delete(url,headers: {HttpHeaders.authorizationHeader:token});
    print(response.body);
    int likes =  int.parse(response.body);
    print (likes);
    if(response.statusCode==200){
      return likes;
    }
    return 0;

  }
  Future<int> heartbeatStreamViews({String token, String id})async{
    var url = constants.baseUrl+'/api/v1/stream/video/ongoing/$id/heartbeat';
    final response = await http.post(url,headers: {HttpHeaders.authorizationHeader:token});


    int views =  jsonDecode(response.body)['viewersCount'];
    print (views);
    if(response.statusCode==200){
      return views;
    }
    return 0;


  }

  Future<bool> changeUserAccess(String token, String userID)async {
    print(token);

    var url = constants.baseUrl + "/api/v1/profile/$userID/enabled/false";

    var response = await http.put(url,
        headers: {HttpHeaders.authorizationHeader: token},
       );
    print("Ban user"+response.body.toString());

    return  true;
  }




  Future<List<Regex>> getRegexes()async{
    var url = constants.baseUrl+'/api/v1/data-restrictions';
    final response = await http.get(url);
    List<dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));


    print("Regex"+responseJson.toString());
    List<Regex>list = (responseJson).map((i) =>Regex.fromJson(i)).toList();
    return  list;

  }

  Future<int> heartbeatStreamLikes({String token, String id})async{
    var url = constants.baseUrl+'/api/v1/stream/video/ongoing/$id/heartbeat';
    final response = await http.post(url,headers: {HttpHeaders.authorizationHeader:token});


    int views =  jsonDecode(response.body)['likesCount'];
    print (views);
    if(response.statusCode==200){
      return views;
    }
    return 0;


  }








}