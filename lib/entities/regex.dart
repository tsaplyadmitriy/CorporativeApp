


class Regex{
  RegexType type;
  String regex;

  Regex({this.type,this.regex});

  static RegexType getType(String type){
    if(type=="USER_EMAIL"){
      return RegexType.EMAIL;
    }
    if(type=="USER_PASSWORD"){
        return RegexType.PASSWORD;
    }
    if(type=="USERNAME"){
        return RegexType.NAME;
    }

  }

@override
String toString()
{
  return regex;
}


  static Regex fromJson(Map<String,dynamic> json){
    return Regex(
      type: getType(json['type']),
      regex: json['regexp']
    );

  }


}

enum RegexType{
    EMAIL, NAME,PASSWORD

}