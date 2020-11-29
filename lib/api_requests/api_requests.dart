import 'dart:convert';
import 'dart:io';

import 'package:lipsar_app/constants.dart';
import 'package:lipsar_app/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:lipsar_app/entities/user_session.dart';
class APIRequests {
  static final APIRequests _singleton = APIRequests._internal();

  factory APIRequests() {
    return _singleton;
  }

  APIRequests._internal(){
  } //private constructor

  Future<UserSession> loginUser(String phone,String password)async {

    print(phone+password);
    var url = constants.baseUrl+"/api/v1/auth/login";
    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'password': password,'phone':phone}));

    print(response.body);

    final responseJson = jsonDecode(response.body);

    return UserSession.fromJson(responseJson,response.statusCode);


  }

  Future<UserSession> signUpUser(String email,  String phone, String name,String password)async {

    var url = constants.baseUrl+"/api/v1/auth/register";
    print("t"+phone+"t");
    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'email':email,'password': password,'phone':phone,'username':name}));

    final responseJson = jsonDecode(response.body);

    return UserSession.fromJson(responseJson,response.statusCode);


  }

  Future<bool> verifyEmail(String code,String token)async {
    var url = constants.baseUrl + "/api/v1/verify/email";
    print(token);
    var response = await http.post(url,
        headers: {'Content-type': 'application/json',HttpHeaders.authorizationHeader: token},
        body: jsonEncode({
         'verificationCode':'123456'
        }));

    int respCode = response.statusCode;
    print(respCode);
   if(respCode==200){
     return true;
   }else{
     return false;
   }


  }

}