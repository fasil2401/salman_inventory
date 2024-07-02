
// To parse this JSON data, do
//
//     final getTransactionOpenList = getTransactionOpenListFromJson(jsonString);

import 'dart:convert';

GetTransactionOpenList getTransactionOpenListFromJson(String str) =>
    GetTransactionOpenList.fromJson(json.decode(str));

String getTransactionOpenListToJson(GetTransactionOpenList data) =>
    json.encode(data.toJson());

class GetTransactionOpenList {
  int? res;
  List<OpenList>? model;
  String? msg;

  GetTransactionOpenList({
    this.res,
    this.model,
    this.msg,
  });

  factory GetTransactionOpenList.fromJson(Map<String, dynamic> json) =>
      GetTransactionOpenList(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<OpenList>.from(
                json["model"]!.map((x) => OpenList.fromJson(x))),
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

class OpenList {
  String? docId;
  String? docNumber;
  String? partyId;
  String? partyName;
  DateTime? transactionDate;
  String? salesperson;
  int? quantity;
  String? ref1;
  String? ref2;

  OpenList({
    this.docId,
    this.docNumber,
    this.partyId,
    this.partyName,
    this.transactionDate,
    this.salesperson,
    this.quantity,
    this.ref1,
    this.ref2,
  });

  factory OpenList.fromJson(Map<String, dynamic> json) => OpenList(
        docId: json["Doc ID"],
        docNumber: json["Doc Number"],
        partyId: json[" Party ID"],
        partyName: json["PARTY NAME"],
        transactionDate: json["TransactionDate"] == null
            ? null
            : DateTime.parse(json["TransactionDate"]),
        salesperson: json["Salesperson"],
        quantity: json["Quantity"],
        ref1: json["Ref1"],
        ref2: json["Ref2"],
      );

  Map<String, dynamic> toJson() => {
        "Doc ID": docId,
        "Doc Number": docNumber,
        " Party ID": partyId,
        "PARTY NAME": partyName,
        "TransactionDate": transactionDate?.toIso8601String(),
        "Salesperson": salesperson,
        "Quantity": quantity,
        "Ref1": ref1,
        "Ref2": ref2,
      };
}
