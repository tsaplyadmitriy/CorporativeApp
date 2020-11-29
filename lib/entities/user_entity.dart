class UserEntity{

  String email;
  String id;
  String password;
  String phone;
  String username;
  int respcode;

  UserEntity({this.email,this.id,this.password,this.phone,this.username,this.respcode});

  factory UserEntity.fromJson(Map<String,dynamic> json,int code){

    return new UserEntity(
      email: json['email'],
      id: json['id'],
      password: json['password'],
      phone: json['phone'],
      username: json['username'],
        respcode:code



    );

  }


}