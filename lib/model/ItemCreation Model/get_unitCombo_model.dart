// To parse this JSON data, do
//
//     final getUnitComboModel = getUnitComboModelFromJson(jsonString);

import 'dart:convert';

GetUnitComboModel getUnitComboModelFromJson(String str) => GetUnitComboModel.fromJson(json.decode(str));

String getUnitComboModelToJson(GetUnitComboModel data) => json.encode(data.toJson());

class GetUnitComboModel {
  int? res;
  List<Model>? model;

  GetUnitComboModel({
    this.res,
    this.model,
  });

  factory GetUnitComboModel.fromJson(Map<String, dynamic> json) => GetUnitComboModel(
    res: json["res"],
    model: List<Model>.from(json["model"].map((x) => Model.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "res": res,
    "model": List<dynamic>.from(model!.map((x) => x.toJson())),
  };
}

class Model {
  String? code;
  String? name;

  Model({
    this.code,
    this.name,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
  };
}
