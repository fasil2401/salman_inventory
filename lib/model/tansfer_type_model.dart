

import 'dart:convert';

TrasferType trasferTypeFromJson(String str) => TrasferType.fromJson(json.decode(str));

String trasferTypeToJson(TrasferType data) => json.encode(data.toJson());

class TrasferType {
  TrasferType({
    required this.model,
    required this.res,
    required this.msg,
  });

  int res;
  List<TransferTypeModel> model;
  String msg;

  factory TrasferType.fromJson(Map<String, dynamic> json) => TrasferType(
    res: json["res"],
    model: List<TransferTypeModel>.from(json["model"].map((x) => TransferTypeModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "res": res,
    "model": List<dynamic>.from(model.map((x) => x.toJson())),
    "msg": msg,
  };
}

class TransferTypeModel {
  TransferTypeModel({
    this.code,
    this.name,
    this.accountId,
    this.locationId,
  });

  String? code;
  String? name;
  String? accountId;
  String? locationId;

  factory TransferTypeModel.fromJson(Map<String, dynamic> json) => TransferTypeModel(
    code: json["Code"],
    name: json["Name"],
    accountId: json["AccountID"],
    locationId: json["LocationID"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
    "AccountID": accountId,
    "LocationID": locationId,
  };
  Map<String ,dynamic> toMap(){
    return {
      TransferTypeModelName.code:code,
      TransferTypeModelName.name:name,
      TransferTypeModelName.locationId:locationId,
      TransferTypeModelName.accountId:accountId,


    };
  }
  TransferTypeModel.fromMap(Map<String,dynamic> map){
    code=map[TransferTypeModelName.code];
    name=map[TransferTypeModelName.name];
    accountId=map[TransferTypeModelName.accountId];
    locationId=map[TransferTypeModelName.locationId];


  }
}
class TransferTypeModelName{
  static const String tableName = "transfer_type";
  static const String code = "code";
  static const String name = "name";
  static const String accountId = "accountId";
  static const String locationId = "locationId";
}
