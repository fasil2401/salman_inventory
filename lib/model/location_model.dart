

import 'dart:convert';

LocationListModel locationFromJson(String str) => LocationListModel.fromJson(json.decode(str));

String locationToJson(LocationListModel data) => json.encode(data.toJson());

class LocationListModel {
  LocationListModel({
    required this.res,
    required this.model,
    required this.msg,
  });

  int res;
  List<LocationModel> model;
  String msg;

  factory LocationListModel.fromJson(Map<String, dynamic> json) => LocationListModel(
    res: json["res"],
    model: List<LocationModel>.from(json["model"].map((x) => LocationModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "res": res,
    "model": List<dynamic>.from(model.map((x) => x.toJson())),
    "msg": msg,
  };
}

class LocationModel {
  LocationModel({
    this.name,
    this.code,
  });

  String? code;
  String? name;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
  };
  Map<String ,dynamic> toMap(){
    return {
      LocationModelName.code:code,
      LocationModelName.name:name,


    };
  }
  LocationModel.fromMap(Map<String,dynamic> map){
    code=map[LocationModelName.code];
    name=map[LocationModelName.name];


  }
}
class LocationModelName{
  static const String tableName = "location";
  static const String code = "code";
  static const String name = "name";
}
