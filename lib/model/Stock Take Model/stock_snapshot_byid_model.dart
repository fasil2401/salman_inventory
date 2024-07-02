import 'dart:convert';

StockSnapshotByIdModel stockSnapshotByIdModelFromJson(String str) =>
    StockSnapshotByIdModel.fromJson(json.decode(str));

String stockSnapshotByIdModelToJson(StockSnapshotByIdModel data) =>
    json.encode(data.toJson());

class StockSnapshotByIdModel {
  StockSnapshotByIdModel({
    this.res,
    this.model,
    this.details,
    this.msg,
  });

  int? res;
  List<StockHeaderModel>? model;
  List<StockDetailModel>? details;
  String? msg;

  factory StockSnapshotByIdModel.fromJson(Map<String, dynamic> json) =>
      StockSnapshotByIdModel(
        res: json["res"],
        model: List<StockHeaderModel>.from(
            json["model"].map((x) => StockHeaderModel.fromJson(x))),
        details: List<StockDetailModel>.from(
            json["details"].map((x) => StockDetailModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": List<dynamic>.from(model?.map((x) => x.toJson()) ?? []),
        "details": List<dynamic>.from(details?.map((x) => x.toJson()) ?? []),
        "msg": msg,
      };
}

class StockDetailModel {
  StockDetailModel({
    this.sysDocId,
    this.voucherId,
    this.productId,
    this.rowIndex,
    this.description,
    this.unitId,
    this.unitQuantity,
    this.physicalQuantity,
    this.factor,
    this.factorType,
    this.listVoucherId,
    this.listSysDocId,
    this.listRowIndex,
    this.remarks,
    this.refSlNo,
    this.refText1,
    this.refText2,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
    this.quantity,
    this.cost,
    this.itRowId,
    this.isTrackLot,
    this.isTrackSerial,
  });

  String? sysDocId;
  String? voucherId;
  String? productId;
  int? rowIndex;
  String? description;
  String? unitId;
  dynamic unitQuantity;
  dynamic physicalQuantity;
  dynamic factor;
  dynamic factorType;
  String? listVoucherId;
  String? listSysDocId;
  dynamic listRowIndex;
  String? remarks;
  dynamic refSlNo;
  dynamic refText1;
  dynamic refText2;
  dynamic refNum1;
  dynamic refNum2;
  dynamic refDate1;
  dynamic refDate2;
  dynamic quantity;
  dynamic cost;
  dynamic itRowId;
  bool? isTrackLot;
  bool? isTrackSerial;

  factory StockDetailModel.fromJson(Map<String, dynamic> json) =>
      StockDetailModel(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        productId: json["ProductID"],
        rowIndex: json["RowIndex"],
        description: json["Description"],
        unitId: json["UnitID"],
        unitQuantity: json["UnitQuantity"],
        physicalQuantity: json["PhysicalQuantity"],
        factor: json["Factor"],
        factorType: json["FactorType"],
        listVoucherId: json["ListVoucherID"],
        listSysDocId: json["ListSysDocID"],
        listRowIndex: json["ListRowIndex"],
        remarks: json["Remarks"],
        refSlNo: json["RefSlNo"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: json["RefDate1"],
        refDate2: json["RefDate2"],
        quantity: json["Quantity"],
        cost: json["Cost"],
        itRowId: json["ITRowID"],
        isTrackLot: json["IsTrackLot"],
        isTrackSerial: json["IsTrackSerial"],
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "ProductID": productId,
        "RowIndex": rowIndex,
        "Description": description,
        "UnitID": unitId,
        "UnitQuantity": unitQuantity,
        "PhysicalQuantity": physicalQuantity,
        "Factor": factor,
        "FactorType": factorType,
        "ListVoucherID": listVoucherId,
        "ListSysDocID": listSysDocId,
        "ListRowIndex": listRowIndex,
        "Remarks": remarks,
        "RefSlNo": refSlNo,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1,
        "RefDate2": refDate2,
        "Quantity": quantity,
        "Cost": cost,
        "ITRowID": itRowId,
        "IsTrackLot": isTrackLot,
        "IsTrackSerial": isTrackSerial,
      };
}

class StockHeaderModel {
  StockHeaderModel({
    this.sysDocId,
    this.voucherId,
    this.companyId,
    this.divisionId,
    this.transactionDate,
    this.accountId,
    this.reference,
    this.description,
    this.locationId,
    this.adjustmentTypeId,
    this.requireUpdate,
    this.approvalStatus,
    this.verificationStatus,
    this.dateCreated,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.isNewRecord,
  });

  String? sysDocId;
  String? voucherId;
  String? companyId;
  String? divisionId;
  DateTime? transactionDate;
  String? accountId;
  String? reference;
  String? description;
  String? locationId;
  String? adjustmentTypeId;
  dynamic requireUpdate;
  dynamic approvalStatus;
  dynamic verificationStatus;
  DateTime? dateCreated;
  dynamic dateUpdated;
  String? createdBy;
  dynamic updatedBy;
  bool? isNewRecord;

  factory StockHeaderModel.fromJson(Map<String, dynamic> json) =>
      StockHeaderModel(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        companyId: json["CompanyID"],
        divisionId: json["DivisionID"],
        transactionDate: DateTime.parse(json["TransactionDate"]),
        accountId: json["AccountID"],
        reference: json["Reference"],
        description: json["Description"],
        locationId: json["LocationID"],
        adjustmentTypeId: json["AdjustmentTypeID"],
        requireUpdate: json["RequireUpdate"],
        approvalStatus: json["ApprovalStatus"],
        verificationStatus: json["VerificationStatus"],
        dateCreated: DateTime.parse(json["DateCreated"]),
        dateUpdated: json["DateUpdated"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
        isNewRecord: false,
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "CompanyID": companyId,
        "DivisionID": divisionId,
        "TransactionDate": transactionDate!.toIso8601String(),
        "AccountID": accountId,
        "Reference": reference,
        "Description": description,
        "LocationID": locationId,
        "AdjustmentTypeID": adjustmentTypeId,
        "RequireUpdate": requireUpdate,
        "ApprovalStatus": approvalStatus,
        "VerificationStatus": verificationStatus,
        "DateCreated": dateCreated!.toIso8601String(),
        "DateUpdated": dateUpdated,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
      };
}
