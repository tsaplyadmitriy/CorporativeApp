import 'dart:convert';

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

    var url = constants.baseUrl+"/api/v1/auth/login";
    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'password': password,'phone':phone}));

    final responseJson = jsonDecode(response.body);

    return UserSession.fromJson(responseJson);


  }

  Future<UserEntity> signUpUser(String email, String id, String phone, String name,String password)async {

    var url = constants.baseUrl+" /api/v1/auth/register";
    var response = await http.post(url,
        headers:{'Content-type':'application/json'},
        body:jsonEncode({'password': password,'phone':phone,'id':id,'email':email,'name':name}));

    final responseJson = jsonDecode(response.body);

    return UserEntity.fromJson(responseJson);


  }



}