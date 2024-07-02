import 'dart:convert';

ListStockSnapshotModel listStockSnapshotModelFromJson(String str) =>
    ListStockSnapshotModel.fromJson(json.decode(str));

String listStockSnapshotModelToJson(ListStockSnapshotModel data) =>
    json.encode(data.toJson());

class ListStockSnapshotModel {
  ListStockSnapshotModel({
    this.res,
    this.model,
    this.msg,
  });

  int? res;
  List<StockSnapShot>? model;
  String? msg;

  factory ListStockSnapshotModel.fromJson(Map<String, dynamic> json) =>
      ListStockSnapshotModel(
        res: json["res"],
        model: List<StockSnapShot>.from(
            json["model"].map((x) => StockSnapShot.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": List<dynamic>.from(model?.map((x) => x.toJson()) ?? []),
        "msg": msg,
      };
}

class StockSnapShot {
  StockSnapShot(
      {this.sysDocId,
      this.voucherId,
      this.transactionDate,
      this.locationId,
      this.locationName,
      this.description,
      this.planedDate,
      this.status});

  String? sysDocId;
  String? voucherId;
  DateTime? transactionDate;
  String? locationId;
  String? locationName;
  String? description;
  DateTime? planedDate;
  String? status;

  factory StockSnapShot.fromJson(Map<String, dynamic> json) => StockSnapShot(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        transactionDate: json["TransactionDate"] != null
            ? DateTime.parse(json["TransactionDate"])
            : null,
        locationId: json["LocationID"],
        locationName: json["LocationName"],
        description: json["Description"],
        planedDate: json["PlanedDate"] != null
            ? DateTime.parse(json["PlanedDate"])
            : null,
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "TransactionDate":
            transactionDate == null ? null : transactionDate!.toIso8601String(),
        "LocationID": locationId,
        "LocationName": locationName,
        "Description": description,
        "PlanedDate": planedDate,
        "Status": status,
      };
}
