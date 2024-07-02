// To parse this JSON data, do
//
//     final createDirectInventoryTransfer = createDirectInventoryTransferFromJson(jsonString);

import 'dart:convert';

CreateDirectInventoryTransfer createDirectInventoryTransferFromJson(
        String str) =>
    CreateDirectInventoryTransfer.fromJson(json.decode(str));

String createDirectInventoryTransferToJson(
        CreateDirectInventoryTransfer data) =>
    json.encode(data.toJson());

class CreateDirectInventoryTransfer {
  String? token;
  String? sysdocid;
  dynamic sysDocType;
  String? voucherid;
  String? fromLocationId;
  String? salespersonid;
  String? currencyid;
  DateTime? transactionDate;
  String? reference;
  String? note;
  bool? isvoid;
  dynamic discount;
  String? vehicleNo;
  String? companyId;
  String? divisionId;
  bool? isnewrecord;
  String? toLocationId;
  String? description;
  String? driverId;
  List<DirectInventoryTransferDetail>? directInventoryTransferDetails;
  List<LotDetail>? lotDetails;

  CreateDirectInventoryTransfer({
    this.token,
    this.sysdocid,
    this.sysDocType,
    this.voucherid,
    this.fromLocationId,
    this.salespersonid,
    this.currencyid,
    this.transactionDate,
    this.reference,
    this.note,
    this.isvoid,
    this.discount,
    this.vehicleNo,
    this.companyId,
    this.divisionId,
    this.isnewrecord,
    this.toLocationId,
    this.description,
    this.driverId,
    this.directInventoryTransferDetails,
    this.lotDetails,
  });

  factory CreateDirectInventoryTransfer.fromJson(Map<String, dynamic> json) =>
      CreateDirectInventoryTransfer(
        token: json["token"],
        sysdocid: json["Sysdocid"],
        sysDocType: json["SysDocType"],
        voucherid: json["Voucherid"],
        fromLocationId: json["FromLocationID"],
        salespersonid: json["Salespersonid"],
        currencyid: json["Currencyid"],
        transactionDate: json["TransactionDate"] == null
            ? null
            : DateTime.parse(json["TransactionDate"]),
        reference: json["Reference"],
        note: json["Note"],
        isvoid: json["Isvoid"],
        discount: json["Discount"],
        vehicleNo: json["VehicleNo"],
        companyId: json["CompanyID"],
        divisionId: json["DivisionID"],
        isnewrecord: json["Isnewrecord"],
        toLocationId: json["ToLocationID"],
        description: json["Description"],
        driverId: json["DriverID"],
        directInventoryTransferDetails:
            json["DirectInventoryTransferDetails"] == null
                ? []
                : List<DirectInventoryTransferDetail>.from(
                    json["DirectInventoryTransferDetails"]!
                        .map((x) => DirectInventoryTransferDetail.fromJson(x))),
        lotDetails: json["LotDetails"] == null
            ? []
            : List<LotDetail>.from(
                json["LotDetails"]!.map((x) => LotDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "Sysdocid": sysdocid,
        "SysDocType": sysDocType,
        "Voucherid": voucherid,
        "FromLocationID": fromLocationId,
        "Salespersonid": salespersonid,
        "Currencyid": currencyid,
        "TransactionDate": transactionDate?.toIso8601String(),
        "Reference": reference,
        "Note": note,
        "Isvoid": isvoid,
        "Discount": discount,
        "VehicleNo": vehicleNo,
        "CompanyID": companyId,
        "DivisionID": divisionId,
        "Isnewrecord": isnewrecord,
        "ToLocationID": toLocationId,
        "Description": description,
        "DriverID": driverId,
        "DirectInventoryTransferDetails": directInventoryTransferDetails == null
            ? []
            : List<dynamic>.from(
                directInventoryTransferDetails!.map((x) => x.toJson())),
        "LotDetails": lotDetails == null
            ? []
            : List<dynamic>.from(lotDetails!.map((x) => x.toJson())),
      };
}

class DirectInventoryTransferDetail {
  String? itemcode;
  String? description;
  double? quantity;
  dynamic rowindex;
  String? unitid;
  dynamic unitPrice;
  String? locationId;
  String? sourceVoucherId;
  String? sourceSysDocId;
  dynamic sourceSysDocType;
  dynamic sourceRowIndex;
  String? remarks;
  bool? isSourceRow;

  DirectInventoryTransferDetail({
    this.itemcode,
    this.description,
    this.quantity,
    this.rowindex,
    this.unitid,
    this.unitPrice,
    this.locationId,
    this.sourceVoucherId,
    this.sourceSysDocId,
    this.sourceSysDocType,
    this.sourceRowIndex,
    this.remarks,
    this.isSourceRow,
  });

  factory DirectInventoryTransferDetail.fromJson(Map<String, dynamic> json) =>
      DirectInventoryTransferDetail(
        itemcode: json["Itemcode"],
        description: json["Description"],
        quantity: json["Quantity"],
        rowindex: json["Rowindex"],
        unitid: json["Unitid"],
        unitPrice: json["UnitPrice"],
        locationId: json["LocationID"],
        sourceVoucherId: json["SourceVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        sourceSysDocType: json["SourceSysDocType"],
        sourceRowIndex: json["SourceRowIndex"],
        remarks: json["Remarks"],
        isSourceRow: json["IsSourceRow"],
      );

  Map<String, dynamic> toJson() => {
        "Itemcode": itemcode,
        "Description": description,
        "Quantity": quantity,
        "Rowindex": rowindex,
        "Unitid": unitid,
        "UnitPrice": unitPrice,
        "LocationID": locationId,
        "SourceVoucherID": sourceVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "SourceSysDocType": sourceSysDocType,
        "SourceRowIndex": sourceRowIndex,
        "Remarks": remarks,
        "IsSourceRow": isSourceRow,
      };
}

class LotDetail {
  String? token;
  String? sysdocid;
  String? voucherid;
  String? productId;
  String? unitId;
  String? fromLocationId;
  String? toLocationId;
  String? lotNumber;
  String? reference;
  String? sourceLotNumber;
  dynamic quantity;
  String? binId;
  String? reference2;
  dynamic unitPrice;
  dynamic rowIndex;
  dynamic cost;
  dynamic soldQty;
  double? lotQty;

  LotDetail({
    this.token,
    this.sysdocid,
    this.voucherid,
    this.productId,
    this.unitId,
    this.fromLocationId,
    this.toLocationId,
    this.lotNumber,
    this.reference,
    this.sourceLotNumber,
    this.quantity,
    this.binId,
    this.reference2,
    this.unitPrice,
    this.rowIndex,
    this.cost,
    this.soldQty,
    this.lotQty,
  });

  factory LotDetail.fromJson(Map<String, dynamic> json) => LotDetail(
        token: json["token"],
        sysdocid: json["Sysdocid"],
        voucherid: json["Voucherid"],
        productId: json["ProductID"],
        unitId: json["UnitID"],
        fromLocationId: json["FromLocationId"],
        toLocationId: json["ToLocationId"],
        lotNumber: json["LotNumber"],
        reference: json["Reference"],
        sourceLotNumber: json["SourceLotNumber"],
        quantity: json["Quantity"],
        binId: json["BinID"],
        reference2: json["Reference2"],
        unitPrice: json["UnitPrice"],
        rowIndex: json["RowIndex"],
        cost: json["Cost"],
        soldQty: json["SoldQty"],
        lotQty: json["LotQty"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "Sysdocid": sysdocid,
        "Voucherid": voucherid,
        "ProductID": productId,
        "UnitID": unitId,
        "FromLocationId": fromLocationId,
        "ToLocationId": toLocationId,
        "LotNumber": lotNumber,
        "Reference": reference,
        "SourceLotNumber": sourceLotNumber,
        "Quantity": quantity,
        "BinID": binId,
        "Reference2": reference2,
        "UnitPrice": unitPrice,
        "RowIndex": rowIndex,
        "Cost": cost,
        "SoldQty": soldQty,
        "LotQty": lotQty,
      };
}
