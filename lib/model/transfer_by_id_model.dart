// To parse this JSON data, do
//
//     final inventoryTransferByIdModel = inventoryTransferByIdModelFromJson(jsonString);

import 'dart:convert';

InventoryTransferByIdModel inventoryTransferByIdModelFromJson(String str) =>
    InventoryTransferByIdModel.fromJson(json.decode(str));

String inventoryTransferByIdModelToJson(InventoryTransferByIdModel data) =>
    json.encode(data.toJson());

class InventoryTransferByIdModel {
  int? res;
  List<IntransferIdModel>? model;
  String? msg;

  InventoryTransferByIdModel({
    this.res,
    this.model,
    this.msg,
  });

  factory InventoryTransferByIdModel.fromJson(Map<String, dynamic> json) =>
      InventoryTransferByIdModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<IntransferIdModel>.from(
                json["model"]!.map((x) => IntransferIdModel.fromJson(x))),
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

class IntransferIdModel {
  String? sysDocId;
  String? voucherId;
  String? transferTypeId;
  dynamic transferAccountId;
  String? acceptSysDocId;
  String? acceptVoucherId;
  String? acceptReference;
  String? acceptedBy;
  dynamic rejectNote;
  dynamic rejectAcceptSysDocId;
  dynamic rejectAcceptVoucherId;
  dynamic rejectAcceptNote;
  dynamic rejectAcceptReference;
  dynamic rejectAcceptedBy;
  DateTime? transactionDate;
  DateTime? acceptDate;
  dynamic rejectDate;
  dynamic rejectAcceptDate;
  DateTime? dateCreated;
  dynamic dateUpdated;
  dynamic rejectedBy;
  String? createdBy;
  dynamic updatedBy;
  int? companyId;
  String? divisionId;
  String? locationFromId;
  String? locationToId;
  dynamic vehicleNumber;
  dynamic driverId;
  int? quantityDismantled;
  dynamic unitCost;
  String? reference;
  String? description;
  bool? isAccepted;
  dynamic isRejected;
  dynamic isRejectAccepted;
  dynamic isVoid;
  dynamic approvalStatus;
  dynamic reason;
  dynamic verificationStatus;
  dynamic rejectSysDocId;
  dynamic rejectReference;
  List<InventoryTransferDetail>? inventoryTransferDetails;

  IntransferIdModel({
    this.sysDocId,
    this.voucherId,
    this.transferTypeId,
    this.transferAccountId,
    this.acceptSysDocId,
    this.acceptVoucherId,
    this.acceptReference,
    this.acceptedBy,
    this.rejectNote,
    this.rejectAcceptSysDocId,
    this.rejectAcceptVoucherId,
    this.rejectAcceptNote,
    this.rejectAcceptReference,
    this.rejectAcceptedBy,
    this.transactionDate,
    this.acceptDate,
    this.rejectDate,
    this.rejectAcceptDate,
    this.dateCreated,
    this.dateUpdated,
    this.rejectedBy,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.divisionId,
    this.locationFromId,
    this.locationToId,
    this.vehicleNumber,
    this.driverId,
    this.quantityDismantled,
    this.unitCost,
    this.reference,
    this.description,
    this.isAccepted,
    this.isRejected,
    this.isRejectAccepted,
    this.isVoid,
    this.approvalStatus,
    this.reason,
    this.verificationStatus,
    this.rejectSysDocId,
    this.rejectReference,
    this.inventoryTransferDetails,
  });

  factory IntransferIdModel.fromJson(Map<String, dynamic> json) =>
      IntransferIdModel(
        sysDocId: json["SysDocId"],
        voucherId: json["VoucherId"],
        transferTypeId: json["TransferTypeId"],
        transferAccountId: json["TransferAccountId"],
        acceptSysDocId: json["AcceptSysDocId"],
        acceptVoucherId: json["AcceptVoucherId"],
        acceptReference: json["AcceptReference"],
        acceptedBy: json["AcceptedBy"],
        rejectNote: json["RejectNote"],
        rejectAcceptSysDocId: json["RejectAcceptSysDocId"],
        rejectAcceptVoucherId: json["RejectAcceptVoucherId"],
        rejectAcceptNote: json["RejectAcceptNote"],
        rejectAcceptReference: json["RejectAcceptReference"],
        rejectAcceptedBy: json["RejectAcceptedBy"],
        transactionDate: json["TransactionDate"] == null
            ? null
            : DateTime.parse(json["TransactionDate"]),
        acceptDate: json["AcceptDate"] == null
            ? null
            : DateTime.parse(json["AcceptDate"]),
        rejectDate: json["RejectDate"],
        rejectAcceptDate: json["RejectAcceptDate"],
        dateCreated: json["DateCreated"] == null
            ? null
            : DateTime.parse(json["DateCreated"]),
        dateUpdated: json["DateUpdated"],
        rejectedBy: json["RejectedBy"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
        companyId: json["CompanyId"],
        divisionId: json["DivisionId"],
        locationFromId: json["LocationFromId"],
        locationToId: json["LocationToId"],
        vehicleNumber: json["VehicleNumber"],
        driverId: json["DriverId"],
        quantityDismantled: json["QuantityDismantled"],
        unitCost: json["UnitCost"],
        reference: json["Reference"],
        description: json["Description"],
        isAccepted: json["IsAccepted"],
        isRejected: json["IsRejected"],
        isRejectAccepted: json["IsRejectAccepted"],
        isVoid: json["IsVoid"],
        approvalStatus: json["ApprovalStatus"],
        reason: json["Reason"],
        verificationStatus: json["VerificationStatus"],
        rejectSysDocId: json["RejectSysDocId"],
        rejectReference: json["RejectReference"],
        inventoryTransferDetails: json["InventoryTransferDetails"] == null
            ? []
            : List<InventoryTransferDetail>.from(
                json["InventoryTransferDetails"]!
                    .map((x) => InventoryTransferDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SysDocId": sysDocId,
        "VoucherId": voucherId,
        "TransferTypeId": transferTypeId,
        "TransferAccountId": transferAccountId,
        "AcceptSysDocId": acceptSysDocId,
        "AcceptVoucherId": acceptVoucherId,
        "AcceptReference": acceptReference,
        "AcceptedBy": acceptedBy,
        "RejectNote": rejectNote,
        "RejectAcceptSysDocId": rejectAcceptSysDocId,
        "RejectAcceptVoucherId": rejectAcceptVoucherId,
        "RejectAcceptNote": rejectAcceptNote,
        "RejectAcceptReference": rejectAcceptReference,
        "RejectAcceptedBy": rejectAcceptedBy,
        "TransactionDate": transactionDate?.toIso8601String(),
        "AcceptDate": acceptDate?.toIso8601String(),
        "RejectDate": rejectDate,
        "RejectAcceptDate": rejectAcceptDate,
        "DateCreated": dateCreated?.toIso8601String(),
        "DateUpdated": dateUpdated,
        "RejectedBy": rejectedBy,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "CompanyId": companyId,
        "DivisionId": divisionId,
        "LocationFromId": locationFromId,
        "LocationToId": locationToId,
        "VehicleNumber": vehicleNumber,
        "DriverId": driverId,
        "QuantityDismantled": quantityDismantled,
        "UnitCost": unitCost,
        "Reference": reference,
        "Description": description,
        "IsAccepted": isAccepted,
        "IsRejected": isRejected,
        "IsRejectAccepted": isRejectAccepted,
        "IsVoid": isVoid,
        "ApprovalStatus": approvalStatus,
        "Reason": reason,
        "VerificationStatus": verificationStatus,
        "RejectSysDocId": rejectSysDocId,
        "RejectReference": rejectReference,
        "InventoryTransferDetails": inventoryTransferDetails == null
            ? []
            : List<dynamic>.from(
                inventoryTransferDetails!.map((x) => x.toJson())),
      };
}

class InventoryTransferDetail {
  String? sysDocId;
  String? voucherId;
  String? remarks;
  dynamic acceptedFactorType;
  String? productId;
  String? description;
  int? rowIndex;
  dynamic sourceDocType;
  dynamic sourceRowIndex;
  dynamic listRowIndex;
  dynamic listVoucherId;
  dynamic listSysDocId;
  dynamic sourceVoucherId;
  dynamic sourceSysDocId;
  dynamic isSourcedRow;
  bool? isTrackLot;
  bool? isTrackSerial;
  dynamic acceptedQuantity;
  dynamic acceptedUnitQuantity;
  dynamic acceptedFactor;
  dynamic rejectedQuantity;
  dynamic rejectedUnitQuantity;
  dynamic rejectedFactor;
  dynamic quantity;
  dynamic unitQuantity;
  dynamic factor;
  dynamic factorType;
  dynamic rejectedFactorType;
  String? unitId;

  InventoryTransferDetail({
    this.sysDocId,
    this.voucherId,
    this.remarks,
    this.acceptedFactorType,
    this.productId,
    this.description,
    this.rowIndex,
    this.sourceDocType,
    this.sourceRowIndex,
    this.listRowIndex,
    this.listVoucherId,
    this.listSysDocId,
    this.sourceVoucherId,
    this.sourceSysDocId,
    this.isSourcedRow,
    this.isTrackLot,
    this.isTrackSerial,
    this.acceptedQuantity,
    this.acceptedUnitQuantity,
    this.acceptedFactor,
    this.rejectedQuantity,
    this.rejectedUnitQuantity,
    this.rejectedFactor,
    this.quantity,
    this.unitQuantity,
    this.factor,
    this.factorType,
    this.rejectedFactorType,
    this.unitId,
  });

  factory InventoryTransferDetail.fromJson(Map<String, dynamic> json) =>
      InventoryTransferDetail(
        sysDocId: json["SysDocId"],
        voucherId: json["VoucherId"],
        remarks: json["Remarks"],
        acceptedFactorType: json["AcceptedFactorType"],
        productId: json["ProductId"],
        description: json["Description"],
        rowIndex: json["RowIndex"],
        sourceDocType: json["SourceDocType"],
        sourceRowIndex: json["SourceRowIndex"],
        listRowIndex: json["ListRowIndex"],
        listVoucherId: json["ListVoucherID"],
        listSysDocId: json["ListSysDocID"],
        sourceVoucherId: json["SourceVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        isSourcedRow: json["IsSourcedRow"],
        isTrackLot: json["IsTrackLot"],
        isTrackSerial: json["IsTrackSerial"],
        acceptedQuantity: json["AcceptedQuantity"],
        acceptedUnitQuantity: json["AcceptedUnitQuantity"],
        acceptedFactor: json["AcceptedFactor"],
        rejectedQuantity: json["RejectedQuantity"],
        rejectedUnitQuantity: json["RejectedUnitQuantity"],
        rejectedFactor: json["RejectedFactor"],
        quantity: json["Quantity"],
        unitQuantity: json["UnitQuantity"],
        factor: json["Factor"],
        factorType: json["FactorType"],
        rejectedFactorType: json["RejectedFactorType"],
        unitId: json["UnitId"],
      );

  Map<String, dynamic> toJson() => {
        "Remarks": remarks,
        "AcceptedFactorType": acceptedFactorType,
        "ProductId": productId,
        "Description": description,
        "RowIndex": rowIndex,
        "SourceDocType": sourceDocType,
        "SourceRowIndex": sourceRowIndex,
        "ListRowIndex": listRowIndex,
        "ListVoucherID": listVoucherId,
        "ListSysDocID": listSysDocId,
        "SourceVoucherID": sourceVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "IsSourcedRow": isSourcedRow,
        "IsTrackLot": isTrackLot,
        "IsTrackSerial": isTrackSerial,
        "AcceptedQuantity": acceptedQuantity,
        "AcceptedUnitQuantity": acceptedUnitQuantity,
        "AcceptedFactor": acceptedFactor,
        "RejectedQuantity": rejectedQuantity,
        "RejectedUnitQuantity": rejectedUnitQuantity,
        "RejectedFactor": rejectedFactor,
        "Quantity": quantity,
        "UnitQuantity": unitQuantity,
        "Factor": factor,
        "FactorType": factorType,
        "RejectedFactorType": rejectedFactorType,
        "UnitId": unitId,
      };
}
