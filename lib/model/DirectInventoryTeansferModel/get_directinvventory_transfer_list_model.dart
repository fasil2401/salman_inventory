// To parse this JSON data, do
//
//     final getDirectInventoryTransferList = getDirectInventoryTransferListFromJson(jsonString);

import 'dart:convert';

GetDirectInventoryTransferList getDirectInventoryTransferListFromJson(String str) => GetDirectInventoryTransferList.fromJson(json.decode(str));

String getDirectInventoryTransferListToJson(GetDirectInventoryTransferList data) => json.encode(data.toJson());

class GetDirectInventoryTransferList {
    int? result;
    List<DirectInventoryTransferList>? model;
    String? msg;

    GetDirectInventoryTransferList({
        this.result,
        this.model,
        this.msg,
    });

    factory GetDirectInventoryTransferList.fromJson(Map<String, dynamic> json) => GetDirectInventoryTransferList(
        result: json["result"],
        model: json["Model"] == null ? [] : List<DirectInventoryTransferList>.from(json["Model"]!.map((x) => DirectInventoryTransferList.fromJson(x))),
        msg: json["Msg"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "Model": model == null ? [] : List<dynamic>.from(model!.map((x) => x.toJson())),
        "Msg": msg,
    };
}

class DirectInventoryTransferList {
    String? sysDocId;
    String? voucherId;
    DateTime? transactionDate;
    String? locationFromId;
    String? locationToId;

    DirectInventoryTransferList({
        this.sysDocId,
        this.voucherId,
        this.transactionDate,
        this.locationFromId,
        this.locationToId,
    });

    factory DirectInventoryTransferList.fromJson(Map<String, dynamic> json) => DirectInventoryTransferList(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        transactionDate: json["TransactionDate"] == null ? null : DateTime.parse(json["TransactionDate"]),
        locationFromId: json["LocationFromID"],
        locationToId: json["LocationToID"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "TransactionDate": transactionDate?.toIso8601String(),
        "LocationFromID": locationFromId,
        "LocationToID": locationToId,
    };
}
