class UserSession{

  String token;
  String date;

  UserSession({this.token,this.date});

  factory UserSession.fromJson(Map<String,dynamic> json){
    return new UserSession(
    token:json['accessToken'].toString(),
     date:json['expirationDate'].toString()
  );


  }

}