import 'dart:convert';

GetArrivalReportListModel getArrivalReportListModelFromJson(String str) =>
    GetArrivalReportListModel.fromJson(json.decode(str));

String getArrivalReportListModelToJson(GetArrivalReportListModel data) =>
    json.encode(data.toJson());

class GetArrivalReportListModel {
  GetArrivalReportListModel({
    this.result,
    this.modelobject,
  });

  int? result;
  List<ArrivalOpenListModel>? modelobject;

  factory GetArrivalReportListModel.fromJson(Map<String, dynamic> json) =>
      GetArrivalReportListModel(
        result: json["result"],
        modelobject: json["Modelobject"] == null
            ? []
            : List<ArrivalOpenListModel>.from(json["Modelobject"]!
                .map((x) => ArrivalOpenListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "Modelobject": modelobject == null
            ? []
            : List<dynamic>.from(modelobject!.map((x) => x.toJson())),
      };
}

class ArrivalOpenListModel {
  ArrivalOpenListModel({
    this.v,
    this.docId,
    this.docNumber,
    this.vendorCode,
    this.vendorName,
    this.containerNo,
    this.commodity,
    this.receivedDate,
    this.status,
    this.reference,
  });

  bool? v;
  String? docId;
  String? docNumber;
  String? vendorCode;
  String? vendorName;
  String? containerNo;
  String? commodity;
  DateTime? receivedDate;
  dynamic status;
  String? reference;

  factory ArrivalOpenListModel.fromJson(Map<String, dynamic> json) =>
      ArrivalOpenListModel(
        v: json["V"],
        docId: json["Doc ID"],
        docNumber: json["Doc Number"],
        vendorCode: json["Vendor Code"],
        vendorName: json["Vendor Name"],
        containerNo: json["Container No"],
        commodity: json["Commodity"],
        receivedDate: json["Received Date"] == null
            ? null
            : DateTime.parse(json["Received Date"]),
        status: json["Status"],
        reference: json["Reference"],
      );

  Map<String, dynamic> toJson() => {
        "V": v,
        "Doc ID": docId,
        "Doc Number": docNumber,
        "Vendor Code": vendorCode,
        "Vendor Name": vendorName,
        "Container No": containerNo,
        "Commodity": commodity,
        "Received Date": receivedDate?.toIso8601String(),
        "Status": status,
        "Reference": reference,
      };
}
