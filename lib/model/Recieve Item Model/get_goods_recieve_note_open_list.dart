// To parse this JSON data, do
//
//     final getGoodsRecieveNoteListModel = getGoodsRecieveNoteListModelFromJson(jsonString);

import 'dart:convert';

GetGoodsRecieveNoteListModel getGoodsRecieveNoteListModelFromJson(String str) =>
    GetGoodsRecieveNoteListModel.fromJson(json.decode(str));

String getGoodsRecieveNoteListModelToJson(GetGoodsRecieveNoteListModel data) =>
    json.encode(data.toJson());

class GetGoodsRecieveNoteListModel {
  int? result;
  List<GoodsRecieveNoteOpenModel>? modelobject;

  GetGoodsRecieveNoteListModel({
    this.result,
    this.modelobject,
  });

  factory GetGoodsRecieveNoteListModel.fromJson(Map<String, dynamic> json) =>
      GetGoodsRecieveNoteListModel(
        result: json["result"],
        modelobject: List<GoodsRecieveNoteOpenModel>.from(json["Modelobject"]
            .map((x) => GoodsRecieveNoteOpenModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "Modelobject":
            List<dynamic>.from(modelobject?.map((x) => x.toJson()) ?? []),
      };
}

class GoodsRecieveNoteOpenModel {
  bool? v;
  String? docId;
  String? docNumber;
  String? vendorCode;
  String? vendorName;
  DateTime? quoteDate;
  String? buyer;
  dynamic amount;
  String? ref1;
  String? ref2;
  String? vendorRef;
  String? currency;

  GoodsRecieveNoteOpenModel({
    this.v,
    this.docId,
    this.docNumber,
    this.vendorCode,
    this.vendorName,
    this.quoteDate,
    this.buyer,
    this.amount,
    this.ref1,
    this.ref2,
    this.vendorRef,
    this.currency,
  });

  factory GoodsRecieveNoteOpenModel.fromJson(Map<String, dynamic> json) =>
      GoodsRecieveNoteOpenModel(
        v: json["V"],
        docId: json["Doc ID"],
        docNumber: json["Doc Number"],
        vendorCode: json["Vendor Code"],
        vendorName: json["Vendor Name"],
        quoteDate: DateTime.parse(json["Quote Date"]),
        buyer: json["Buyer"],
        amount: json["Amount"],
        ref1: json["Ref1"],
        ref2: json["Ref2"],
        vendorRef: json["Vendor Ref"],
        currency: json["Currency"],
      );

  Map<String, dynamic> toJson() => {
        "V": v,
        "Doc ID": docId,
        "Doc Number": docNumber,
        "Vendor Code": vendorCode,
        "Vendor Name": vendorName,
        "Quote Date": quoteDate!.toIso8601String(),
        "Buyer": buyer,
        "Amount": amount,
        "Ref1": ref1,
        "Ref2": ref2,
        "Vendor Ref": vendorRef,
        "Currency": currency,
      };
}
