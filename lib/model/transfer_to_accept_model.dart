import 'dart:convert';

TransferToAcceptModel transferToAcceptModelFromJson(String str) =>
    TransferToAcceptModel.fromJson(json.decode(str));

String transferToAcceptModelToJson(TransferToAcceptModel data) =>
    json.encode(data.toJson());

class TransferToAcceptModel {
  int? res;
  List<IntransferVoucherModel>? model;
  String? msg;

  TransferToAcceptModel({
    this.res,
    this.model,
    this.msg,
  });

  factory TransferToAcceptModel.fromJson(Map<String, dynamic> json) =>
      TransferToAcceptModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<IntransferVoucherModel>.from(
                json["model"]!.map((x) => IntransferVoucherModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null
            ? []
            : List<dynamic>.from(model!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class IntransferVoucherModel {
  String? sysDocId;
  String? number;
  String? type;
  DateTime? date;
  String? from;
  String? to;
  String? description;
  int? reason;

  IntransferVoucherModel({
    this.sysDocId,
    this.number,
    this.type,
    this.date,
    this.from,
    this.to,
    this.description,
    this.reason,
  });

  factory IntransferVoucherModel.fromJson(Map<String, dynamic> json) =>
      IntransferVoucherModel(
        sysDocId: json["SysDocID"],
        number: json["Number"],
        type: json["Type"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        from: json["From"],
        to: json["To"],
        description: json["Description"],
        reason: json["Reason"],
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "Number": number,
        "Type": type,
        "Date": date?.toIso8601String(),
        "From": from,
        "To": to,
        "Description": description,
        "Reason": reason,
      };
}
