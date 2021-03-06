class UserSession{

  String token;
  String date;
  bool emailVerified;
  int respcode;
  UserSession({this.token,this.date,this.emailVerified,this.respcode});

  factory UserSession.fromJson(Map<String,dynamic> json,int code){
    return new UserSession(
    token:json['accessToken'].toString(),
      date:json['expirationDate'].toString(),
      emailVerified: json['emailVerified'],
      respcode: code
  );


  }

}