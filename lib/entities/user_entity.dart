import 'authorities.dart';

class UserEntity{

  String email;
  bool emailVerified;
  String id;
  String username;
  List<Authority> authorities;
  int respcode;

  UserEntity({this.email,this.id,this.username,this.respcode,this.emailVerified,this.authorities});

  factory UserEntity.fromJson(Map<String,dynamic> json,int code){

    print(json['authorities']);
    return new UserEntity(
      emailVerified: json['emailVerified'],
      email: json['email'],
      id: json['id'],
      authorities:(json['authorities']!=null)? (json['authorities'] as List).map((i){
        print("check"+i+" "+Authority.ADMIN.toString());
        if(i=="ADMIN"){
          print("check"+i);
          return Authority.ADMIN;
        }
      }).toList():<Authority>[],


      username: json['username'],
        respcode:code



    );

  }


}