class UserEntity{

  String email;
  String id;
  String password;
  String phone;
  String username;

  UserEntity({this.email,this.id,this.password,this.phone,this.username});

  factory UserEntity.fromJson(Map<String,dynamic> json){

    return new UserEntity(
      email: json['email'],
      id: json['id'],
      password: json['password'],
      phone: json['phone'],
      username: json['username']


    );

  }


}