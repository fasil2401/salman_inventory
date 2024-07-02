

class InventoryTransfer {
  InventoryTransfer({
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
    required this.inventoryTransferDetails,
  });

  String ? sysDocId;
  String ? voucherId;
  String ? transferTypeId;
  String ? transferAccountId;
  String ? acceptSysDocId;
  String ? acceptVoucherId;
  String ? acceptReference;
  String ? acceptedBy;
  String ? rejectNote;
  String ? rejectAcceptSysDocId;
  String ? rejectAcceptVoucherId;
  String ? rejectAcceptNote;
  String ? rejectAcceptReference;
  String ? rejectAcceptedBy;
  DateTime ? transactionDate;
  DateTime ? acceptDate;
  DateTime ? rejectDate;
  DateTime ? rejectAcceptDate;
  DateTime ? dateCreated;
  DateTime ? dateUpdated;
  String ? rejectedBy;
  String ? createdBy;
  String ? updatedBy;
  int ? companyId;
  String ? divisionId;
  String ? locationFromId;
  String ? locationToId;
  String ? vehicleNumber;
  String ? driverId;
  int ? quantityDismantled;
  int ?  unitCost;
  String ? reference;
  String ? description;
  bool ? isAccepted;
  bool ? isRejected;
  bool ? isRejectAccepted;
  bool ? isVoid;
  int ? approvalStatus;
  int ? reason;
  int ? verificationStatus;
  String ? rejectSysDocId;
  String ? rejectReference;
  List<InventoryTransferDetail> inventoryTransferDetails;


  Map<String, dynamic> toJson() => {
    "SysDocId": sysDocId == null ? null : sysDocId,
    "VoucherId": voucherId == null ? null : voucherId,
    "TransferTypeId": transferTypeId == null ? null : transferTypeId,
    "TransferAccountId": transferAccountId == null ? null : transferAccountId,
    "AcceptSysDocId": acceptSysDocId == null ? null : acceptSysDocId,
    "AcceptVoucherId": acceptVoucherId == null ? null : acceptVoucherId,
    "AcceptReference": acceptReference == null ? null : acceptReference,
    "AcceptedBy": acceptedBy == null ? null : acceptedBy,
    "RejectNote": rejectNote == null ? null : rejectNote,
    "RejectAcceptSysDocId": rejectAcceptSysDocId == null ? null : rejectAcceptSysDocId,
    "RejectAcceptVoucherId": rejectAcceptVoucherId == null ? null : rejectAcceptVoucherId,
    "RejectAcceptNote": rejectAcceptNote == null ? null : rejectAcceptNote,
    "RejectAcceptReference": rejectAcceptReference == null ? null : rejectAcceptReference,
    "RejectAcceptedBy": rejectAcceptedBy == null ? null : rejectAcceptedBy,
    "TransactionDate": transactionDate == null ? null : transactionDate,
    "AcceptDate": acceptDate == null ? null : acceptDate,
    "RejectDate": rejectDate == null ? null : rejectDate,
    "RejectAcceptDate": rejectAcceptDate == null ? null : rejectAcceptDate,
    "DateCreated": dateCreated == null ? null : dateCreated,
    "DateUpdated": dateUpdated == null ? null : dateUpdated,
    "RejectedBy": rejectedBy == null ? null : rejectedBy,
    "CreatedBy": createdBy == null ? null : createdBy,
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "CompanyId": companyId == null ? null : companyId,
    "DivisionId": divisionId == null ? null : divisionId,
    "LocationFromId": locationFromId == null ? null : locationFromId,
    "LocationToId": locationToId == null ? null : locationToId,
    "VehicleNumber": vehicleNumber == null ? null : vehicleNumber,
    "DriverId": driverId == null ? null : driverId,
    "QuantityDismantled": quantityDismantled == null ? null : quantityDismantled,
    "UnitCost": unitCost == null ? null : unitCost,
    "Reference": reference == null ? null : reference,
    "Description": description == null ? null : description,
    "IsAccepted": isAccepted == null ? null : isAccepted,
    "IsRejected": isRejected == null ? null : isRejected,
    "IsRejectAccepted": isRejectAccepted == null ? null : isRejectAccepted,
    "IsVoid": isVoid == null ? null : isVoid,
    "ApprovalStatus": approvalStatus == null ? null : approvalStatus,
    "Reason": reason == null ? null : reason,
    "VerificationStatus": verificationStatus == null ? null : verificationStatus,
    "RejectSysDocId": rejectSysDocId == null ? null : rejectSysDocId,
    "RejectReference": rejectReference == null ? null : rejectReference,
    "InventoryTransferDetails": inventoryTransferDetails == null ? null : List<dynamic>.from(inventoryTransferDetails.map((x) => x.toJson())),
  };
// }


}


class InventoryTransferDetail {
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
    // this.productlistmodel
  });
  // ProductListDb? productlistmodel;
  String? sysDocId;
  String? voucherId;
  String? remarks;
  String? acceptedFactorType;
  String? productId;
  String? description;
  dynamic rowIndex;
  dynamic sourceDocType;
  dynamic sourceRowIndex;
  dynamic listRowIndex;
  String? listVoucherId;
  String? listSysDocId;
  String? sourceVoucherId;
  String? sourceSysDocId;
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
  String? factorType;
  String? rejectedFactorType;
  String? unitId;



  Map<String, dynamic> toJson() => {
    "SysDocId": sysDocId == null ? null : sysDocId,
    "VoucherId": voucherId == null ? null : voucherId,
    "Remarks": remarks == null ? null : remarks,
    "AcceptedFactorType": acceptedFactorType == null ? null : acceptedFactorType,
    "ProductId": productId == null ? null : productId,
    "Description": description == null ? null : description,
    "RowIndex": rowIndex == null ? null : rowIndex,
    "SourceDocType": sourceDocType == null ? null : sourceDocType,
    "SourceRowIndex": sourceRowIndex == null ? null : sourceRowIndex,
    "ListRowIndex": listRowIndex == null ? null : listRowIndex,
    "ListVoucherID": listVoucherId == null ? null : listVoucherId,
    "ListSysDocID": listSysDocId == null ? null : listSysDocId,
    "SourceVoucherID": sourceVoucherId == null ? null : sourceVoucherId,
    "SourceSysDocID": sourceSysDocId == null ? null : sourceSysDocId,
    "IsSourcedRow": isSourcedRow == null ? null : isSourcedRow,
    "IsTrackLot": isTrackLot == null ? null : isTrackLot,
    "IsTrackSerial": isTrackSerial == null ? null : isTrackSerial,
    "AcceptedQuantity": acceptedQuantity == null ? null : acceptedQuantity,
    "AcceptedUnitQuantity": acceptedUnitQuantity == null ? null : acceptedUnitQuantity,
    "AcceptedFactor": acceptedFactor == null ? null : acceptedFactor,
    "RejectedQuantity": rejectedQuantity == null ? null : rejectedQuantity,
    "RejectedUnitQuantity": rejectedUnitQuantity == null ? null : rejectedUnitQuantity,
    "RejectedFactor": rejectedFactor == null ? null : rejectedFactor,
    "Quantity": quantity == null ? null : quantity,
    "UnitQuantity": unitQuantity == null ? null : unitQuantity,
    "Factor": factor == null ? null : factor,
    "FactorType": factorType == null ? null : factorType,
    "RejectedFactorType": rejectedFactorType == null ? null : rejectedFactorType,
    "UnitId": unitId == null ? null : unitId,
  };

  factory InventoryTransferDetail.fromJson(Map<String, dynamic> json) => InventoryTransferDetail(
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
}
