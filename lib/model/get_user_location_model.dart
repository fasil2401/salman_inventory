// To parse this JSON data, do
//
//     final getUseLocationModel = getUseLocationModelFromJson(jsonString);

import 'dart:convert';

GetUserLocationModel getUseLocationModelFromJson(String str) =>
    GetUserLocationModel.fromJson(json.decode(str));

String getUseLocationModelToJson(GetUserLocationModel data) =>
    json.encode(data.toJson());

class GetUserLocationModel {
  int? res;
  List<UserLocationModel>? model;

  GetUserLocationModel({
    this.res,
    this.model,
  });

  factory GetUserLocationModel.fromJson(Map<String, dynamic> json) =>
      GetUserLocationModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<UserLocationModel>.from(
                json["model"]!.map((x) => UserLocationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null
            ? []
            : List<dynamic>.from(model!.map((x) => x.toJson())),
      };
}

class UserLocationModel {
  String? code;
  String? name;
  dynamic isConsignOutLocation;
  dynamic isConsignInLocation;
  bool? isposLocation;
  bool? isWarehouse;
  dynamic isQuarantine;
  String? isUserLocation;

  UserLocationModel({
    this.code,
    this.name,
    this.isConsignOutLocation,
    this.isConsignInLocation,
    this.isposLocation,
    this.isWarehouse,
    this.isQuarantine,
    this.isUserLocation,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      UserLocationModel(
        code: json["Code"],
        name: json["Name"],
        isConsignOutLocation: json["IsConsignOutLocation"],
        isConsignInLocation: json["IsConsignInLocation"],
        isposLocation: json["ISPOSLocation"],
        isWarehouse: json["IsWarehouse"],
        isQuarantine: json["IsQuarantine"],
        isUserLocation: json["IsUserLocation"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "IsConsignOutLocation": isConsignOutLocation,
        "IsConsignInLocation": isConsignInLocation,
        "ISPOSLocation": isposLocation,
        "IsWarehouse": isWarehouse,
        "IsQuarantine": isQuarantine,
        "IsUserLocation": isUserLocation,
      };

  Map<String, dynamic> toMap() {
    return {
      UserLocationModelName.code: code,
      UserLocationModelName.name: name,
      UserLocationModelName.isConsignOutLocation: isConsignOutLocation,
      UserLocationModelName.isConsignInLocation: isConsignInLocation,
      UserLocationModelName.isposLocation: isposLocation,
      UserLocationModelName.isWarehouse: isWarehouse,
      UserLocationModelName.isQuarantine: isQuarantine,
      UserLocationModelName.isUserLocation: isUserLocation,
    };
  }

  UserLocationModel.fromMap(Map<String, dynamic> map) {
    code = map[UserLocationModelName.code];
    name = map[UserLocationModelName.name];
    isConsignOutLocation =
        map[UserLocationModelName.isConsignOutLocation] == 1 ? true : false;
    isConsignInLocation =
        map[UserLocationModelName.isConsignInLocation] == 1 ? true : false;
    isposLocation =
        map[UserLocationModelName.isposLocation] == 1 ? true : false;
    isWarehouse = map[UserLocationModelName.isWarehouse] == 1 ? true : false;
    isQuarantine = map[UserLocationModelName.isQuarantine] == 1 ? true : false;
    isUserLocation = map[UserLocationModelName.isUserLocation];
  }
}

class UserLocationModelName {
  static const String tableName = "userlocation";
  static const String code = "code";
  static const String name = "name";
  static const String isConsignOutLocation = "isConsignOutLocation";
  static const String isConsignInLocation = "isConsignInLocation";
  static const String isposLocation = "isposLocation";
  static const String isWarehouse = "isWarehouse";
  static const String isQuarantine = "isQuarantine";
  static const String isUserLocation = "isUserLocation";
}
