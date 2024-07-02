import 'dart:convert';

CommonComboListModel commonComboListModelFromJson(String str) =>
    CommonComboListModel.fromJson(json.decode(str));

String commonComboListModelToJson(CommonComboListModel data) =>
    json.encode(data.toJson());

class CommonComboListModel {
  CommonComboListModel({
    this.result,
    this.modelobject,
  });

  int? result;
  List<CommonComboModel>? modelobject;

  factory CommonComboListModel.fromJson(Map<String, dynamic> json) =>
      CommonComboListModel(
        result: json["result"] == null ? json["res"] : null,
        modelobject: json["Modelobject"] == null
            ? json["model"] == null
                ? []
                : List<CommonComboModel>.from(
                    json["model"]!.map((x) => CommonComboModel.fromJson(x)))
            : List<CommonComboModel>.from(
                json["Modelobject"]!.map((x) => CommonComboModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "Modelobject": modelobject == null
            ? []
            : List<dynamic>.from(modelobject!.map((x) => x.toJson())),
      };
}

class CommonComboModel {
  CommonComboModel({
    this.code,
    this.name,
    this.genericListType,
  });

  String? code;
  String? name;
  int? genericListType;

  factory CommonComboModel.fromJson(Map<String, dynamic> json) =>
      CommonComboModel(
        code: json["Code"],
        name: json["Name"],
        genericListType: json["GenericListType"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "GenericListType": genericListType,
      };
}
