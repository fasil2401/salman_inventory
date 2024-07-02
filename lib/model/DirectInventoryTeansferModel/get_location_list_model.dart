// To parse this JSON data, do
//
//     final getQuarantineLocationModel = getQuarantineLocationModelFromJson(jsonString);

import 'dart:convert';

GetQuarantineLocationModel getQuarantineLocationModelFromJson(String str) => GetQuarantineLocationModel.fromJson(json.decode(str));

String getQuarantineLocationModelToJson(GetQuarantineLocationModel data) => json.encode(data.toJson());

class GetQuarantineLocationModel {
    int? res;
    List<QuarantineLocationModel>? model;
    String? msg;

    GetQuarantineLocationModel({
        this.res,
        this.model,
        this.msg,
    });

    factory GetQuarantineLocationModel.fromJson(Map<String, dynamic> json) => GetQuarantineLocationModel(
        res: json["res"],
        model: json["model"] == null ? [] : List<QuarantineLocationModel>.from(json["model"]!.map((x) => QuarantineLocationModel.fromJson(x))),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null ? [] : List<dynamic>.from(model!.map((x) => x.toJson())),
        "msg": msg,
    };
}

class QuarantineLocationModel {
    String? code;
    String? name;

    QuarantineLocationModel({
        this.code,
        this.name,
    });

    factory QuarantineLocationModel.fromJson(Map<String, dynamic> json) => QuarantineLocationModel(
        code: json["Code"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
    };
}
