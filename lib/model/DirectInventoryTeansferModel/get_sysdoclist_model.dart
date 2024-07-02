

import 'dart:convert';

GetQuarantineSysDocIDsModel getQuarantineSysDocIDsModelFromJson(String str) => GetQuarantineSysDocIDsModel.fromJson(json.decode(str));

String getQuarantineSysDocIDsModelToJson(GetQuarantineSysDocIDsModel data) => json.encode(data.toJson());

class GetQuarantineSysDocIDsModel {
    int? result;
    List<SysDocIDsModel>? model;
    String? msg;

    GetQuarantineSysDocIDsModel({
        this.result,
        this.model,
        this.msg,
    });

    factory GetQuarantineSysDocIDsModel.fromJson(Map<String, dynamic> json) => GetQuarantineSysDocIDsModel(
        result: json["result"],
        model: json["Model"] == null ? [] : List<SysDocIDsModel>.from(json["Model"]!.map((x) => SysDocIDsModel.fromJson(x))),
        msg: json["Msg"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "Model": model == null ? [] : List<dynamic>.from(model!.map((x) => x.toJson())),
        "Msg": msg,
    };
}

class SysDocIDsModel {
    String? sysDocId;
    String? docName;

    SysDocIDsModel({
        this.sysDocId,
        this.docName,
    });

    factory SysDocIDsModel.fromJson(Map<String, dynamic> json) => SysDocIDsModel(
        sysDocId: json["SysDocID"],
        docName: json["DocName"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "DocName": docName,
    };
}
