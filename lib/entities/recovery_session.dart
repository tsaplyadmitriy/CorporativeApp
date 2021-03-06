class RecoverySession{

  String token;
  String date;

  int respcode;
  RecoverySession({this.token,this.date,this.respcode});

  factory RecoverySession.fromJson(Map<String,dynamic> json,int code){
    return new RecoverySession(
        token:json['passwordRecoveryToken'].toString(),
        date:json['expirationDate'].toString(),

        respcode: code
    );


  }

}