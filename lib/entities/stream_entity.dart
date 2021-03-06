

class StreamEntity{

  String band;
  String description;
  String id;
  bool liked;
  int likesCount;
  bool markedToNotification;
  String name ;
  String place;
  String style;
  int date;
  String status;
  String url;
  int viewCount;
  int respCode;
  int comments;
  List<StreamData> sources;

  StreamEntity({this.band, this .description, this.id, this.liked,this.likesCount, this.markedToNotification,
  this.name, this.place,this.date,this.status,this.url,this.viewCount,this.style,this.respCode,this.sources,this.comments});




  factory StreamEntity.fromJson(Map<String,dynamic> json,int code){

    var date = DateTime.fromMillisecondsSinceEpoch(json['startDate']);

    print(date);

    return new StreamEntity(
       band:json['band'],
      description:json['description'],
      id: json['id'],
      liked: json['liked'],
      likesCount: json['likesCount'],
      markedToNotification: json['markedToNotification'],
      name: json['name'],
      place: json['place'],
      date: json['startDate'],
      status: json['status'],
      style: json['style'],
      url: json['url'],
      viewCount: json['viewersCount'],
      sources: (json['sources'] as List).map((i) =>StreamData.fromJson(i)).toList(),
      respCode:code,
      comments: 0



    );

  }



}

class StreamData{

  String type;
  String url;

  StreamData({this.type,this.url});

  factory StreamData.fromJson(Map<String,dynamic> json){
    return StreamData(
      type: json['type'],
      url: json['url']
    );
  }
}