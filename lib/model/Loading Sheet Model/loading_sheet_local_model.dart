// To parse this JSON data, do
//
//     final loadingSheetsHeaderModel = loadingSheetsHeaderModelFromJson(jsonString);

import 'dart:convert';

LoadingSheetsHeaderModel loadingSheetsHeaderModelFromJson(String str) =>
    LoadingSheetsHeaderModel.fromJson(json.decode(str));

String loadingSheetsHeaderModelToJson(LoadingSheetsHeaderModel data) =>
    json.encode(data.toJson());

class LoadingSheetsHeaderModelNames {
  static const String tableName = "loadingSheetsHeader";
  static const String token = "token";
  static const String sysdocid = "sysdocid";
  static const String voucherid = "voucherid";
  static const String partyType = "partyType";
  static const String partyId = "partyId";
  static const String locationId = "locationId";
  static const String toLocationId = "toLocationId";
  static const String address = "address";
  static const String containerNo = "containerNo";
  static const String driverName = "driverName";
  static const String vehicleNo = "vehicleNo";
  static const String phoneNumber = "phoneNumber";
  static const String salespersonid = "salespersonid";
  static const String currencyid = "currencyid";
  static const String transactionDate = "transactionDate";
  static const String reference1 = "reference1";
  static const String reference2 = "reference2";
  static const String reference3 = "reference3";
  static const String note = "note";
  static const String documentType = "documentType";
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String isvoid = "isvoid";
  static const String discount = "discount";
  static const String total = "total";
  static const String roundoff = "roundoff";
  static const String isnewrecord = "isnewrecord";
  static const String isSynced = 'isSynced';
  static const String isError = 'isError';
  static const String isCompleted = 'isCompleted';
  static const String error = 'error';
  static const String categories = "categories";
  static const String partyName = "partyName";
}

class LoadingSheetsHeaderModel {
  String? token;
  String? sysdocid;
  String? voucherid;
  String? partyType;
  String? partyId;
  String? fromLocationId;
  String? toLocationId;
  String? address;
  String? containerNo;
  String? driverName;
  String? vehicleNo;
  String? phoneNumber;
  String? salespersonid;
  String? currencyid;
  String? transactionDate;
  String? reference1;
  String? reference2;
  String? reference3;
  String? note;
  String? documentType;
  String? startTime;
  String? endTime;
  int? isvoid;
  int? discount;
  double? total;
  int? roundoff;
  bool? completedToggle;
  int? isnewrecord;
  int? isSynced;
  int? isError;
  int? isCompleted;
  String? error;
  String? categories;
  String? partyName;

  LoadingSheetsHeaderModel(
      {this.token,
      this.sysdocid,
      this.voucherid,
      this.partyType,
      this.partyId,
      this.address,
      this.containerNo,
      this.toLocationId,
      this.driverName,
      this.phoneNumber,
      this.vehicleNo,
      this.fromLocationId,
      this.salespersonid,
      this.currencyid,
      this.transactionDate,
      this.reference1,
      this.reference2,
      this.reference3,
      this.note,
      this.documentType,
      this.startTime,
      this.endTime,
      this.isvoid,
      this.discount,
      this.total,
      this.roundoff,
      this.completedToggle = false,
      this.isnewrecord,
      this.isSynced,
      this.isError,
      this.isCompleted,
      this.error,
      this.categories,
      this.partyName});

  factory LoadingSheetsHeaderModel.fromJson(Map<String, dynamic> json) =>
      LoadingSheetsHeaderModel(
        token: json["token"],
        sysdocid: json["Sysdocid"],
        voucherid: json["Voucherid"],
        partyType: json["PartyType"],
        partyId: json["PartyID"],
        fromLocationId: json["LocationID"],
        salespersonid: json["Salespersonid"],
        currencyid: json["Currencyid"],
        transactionDate: json["TransactionDate"],
        reference1: json["Reference1"],
        reference2: json["Reference2"],
        reference3: json["Reference3"],
        note: json["Note"],
        isvoid: json["Isvoid"],
        discount: json["Discount"],
        total: json["Total"],
        roundoff: json["Roundoff"],
        isnewrecord: json["Isnewrecord"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "Sysdocid": sysdocid,
        "Voucherid": voucherid,
        "PartyType": partyType,
        "PartyID": partyId,
        "LocationID": fromLocationId,
        "Salespersonid": salespersonid,
        "Currencyid": currencyid,
        "TransactionDate": transactionDate,
        "Reference1": reference1,
        "Reference2": reference2,
        "Reference3": reference3,
        "Note": note,
        "Isvoid": isvoid,
        "Discount": discount,
        "Total": total,
        "Roundoff": roundoff,
        "Isnewrecord": isnewrecord,
      };
  Map<String, dynamic> toMap() {
    return {
      LoadingSheetsHeaderModelNames.token: token,
      LoadingSheetsHeaderModelNames.sysdocid: sysdocid,
      LoadingSheetsHeaderModelNames.voucherid: voucherid,
      LoadingSheetsHeaderModelNames.partyType: partyType,
      LoadingSheetsHeaderModelNames.partyId: partyId,
      LoadingSheetsHeaderModelNames.locationId: fromLocationId,
      LoadingSheetsHeaderModelNames.toLocationId: toLocationId,
      LoadingSheetsHeaderModelNames.address: address,
      LoadingSheetsHeaderModelNames.containerNo: containerNo,
      LoadingSheetsHeaderModelNames.driverName: driverName,
      LoadingSheetsHeaderModelNames.vehicleNo: vehicleNo,
      LoadingSheetsHeaderModelNames.phoneNumber: phoneNumber,
      LoadingSheetsHeaderModelNames.salespersonid: salespersonid,
      LoadingSheetsHeaderModelNames.currencyid: currencyid,
      LoadingSheetsHeaderModelNames.transactionDate: transactionDate,
      LoadingSheetsHeaderModelNames.reference1: reference1,
      LoadingSheetsHeaderModelNames.reference2: reference2,
      LoadingSheetsHeaderModelNames.reference3: reference3,
      LoadingSheetsHeaderModelNames.note: note,
      LoadingSheetsHeaderModelNames.documentType: documentType,
      LoadingSheetsHeaderModelNames.startTime: startTime,
      LoadingSheetsHeaderModelNames.endTime: endTime,
      LoadingSheetsHeaderModelNames.isvoid: isvoid,
      LoadingSheetsHeaderModelNames.discount: discount,
      LoadingSheetsHeaderModelNames.total: total,
      LoadingSheetsHeaderModelNames.roundoff: roundoff,
      LoadingSheetsHeaderModelNames.isnewrecord: isnewrecord,
      LoadingSheetsHeaderModelNames.isSynced: isSynced,
      LoadingSheetsHeaderModelNames.isError: isError,
      LoadingSheetsHeaderModelNames.isCompleted: isCompleted,
      LoadingSheetsHeaderModelNames.error: error,
      LoadingSheetsHeaderModelNames.categories: categories,
      LoadingSheetsHeaderModelNames.partyName: partyName,
    };
  }

  LoadingSheetsHeaderModel.fromMap(Map<String, dynamic> map) {
    token = map[LoadingSheetsHeaderModelNames.token];
    sysdocid = map[LoadingSheetsHeaderModelNames.sysdocid];
    voucherid = map[LoadingSheetsHeaderModelNames.voucherid];
    partyType = map[LoadingSheetsHeaderModelNames.partyType];
    partyId = map[LoadingSheetsHeaderModelNames.partyId];
    fromLocationId = map[LoadingSheetsHeaderModelNames.locationId];
    toLocationId = map[LoadingSheetsHeaderModelNames.toLocationId];
    address = map[LoadingSheetsHeaderModelNames.address];
    containerNo = map[LoadingSheetsHeaderModelNames.containerNo];
    driverName = map[LoadingSheetsHeaderModelNames.driverName];
    vehicleNo = map[LoadingSheetsHeaderModelNames.vehicleNo];
    phoneNumber = map[LoadingSheetsHeaderModelNames.phoneNumber];
    salespersonid = map[LoadingSheetsHeaderModelNames.salespersonid];
    currencyid = map[LoadingSheetsHeaderModelNames.currencyid];
    transactionDate = map[LoadingSheetsHeaderModelNames.transactionDate];
    reference1 = map[LoadingSheetsHeaderModelNames.reference1];
    reference2 = map[LoadingSheetsHeaderModelNames.reference2];
    reference3 = map[LoadingSheetsHeaderModelNames.reference3];
    note = map[LoadingSheetsHeaderModelNames.note];
    documentType = map[LoadingSheetsHeaderModelNames.documentType];
    startTime = map[LoadingSheetsHeaderModelNames.startTime];
    endTime = map[LoadingSheetsHeaderModelNames.endTime];
    isvoid = map[LoadingSheetsHeaderModelNames.isvoid];
    discount = map[LoadingSheetsHeaderModelNames.discount];
    total = map[LoadingSheetsHeaderModelNames.total];
    roundoff = map[LoadingSheetsHeaderModelNames.roundoff];
    isnewrecord = map[LoadingSheetsHeaderModelNames.isnewrecord];
    isSynced = map[LoadingSheetsHeaderModelNames.isSynced];
    isError = map[LoadingSheetsHeaderModelNames.isError];
    isCompleted = map[LoadingSheetsHeaderModelNames.isCompleted];
    error = map[LoadingSheetsHeaderModelNames.error];
    categories = map[LoadingSheetsHeaderModelNames.categories];
    partyName = map[LoadingSheetsHeaderModelNames.partyName];
  }
}

class ItemTransactionDetailsModelNames {
  static const String tableName = "ItemTransactionDetails";
  static const String itemCode = "Itemcode";
  static const String description = "Description";
  static const String quantity = "Quantity";
  static const String rowIndex = "Rowindex";
  static const String unitId = "Unitid";
  static const String unitPrice = "UnitPrice";
  static const String quantityReturned = "QuantityReturned";
  static const String quantityShipped = "QuantityShipped";
  static const String unitQuantity = "UnitQuantity";
  static const String unitFactor = "UnitFactor";
  static const String factorType = "FactorType";
  static const String subunitPrice = "SubunitPrice";
  static const String jobID = "JobID";
  static const String costCategoryID = "CostCategoryID";
  static const String locationID = "LocationID";
  static const String sourceVoucherID = "SourceVoucherID";
  static const String sourceSysDocID = "SourceSysDocID";
  static const String sourceRowIndex = "SourceRowIndex";
  static const String rowSource = "RowSource";
  static const String refSlNo = "RefSlNo";
  static const String refText1 = "RefText1";
  static const String refText2 = "RefText2";
  static const String refText3 = "RefText3";
  static const String refText4 = "RefText4";
  static const String refText5 = "RefText5";
  static const String refNum1 = "RefNum1";
  static const String refNum2 = "RefNum2";
  static const String refDate1 = "RefDate1";
  static const String refDate2 = "RefDate2";
  static const String remarks = "Remarks";
  static const String listQuantity = "ListQuantity";
}

class ItemTransactionDetailsModel {
  String? itemcode;
  String? description;
  double? quantity;
  int? rowindex;
  String? unitid;
  int? unitPrice;
  double? quantityReturned;
  double? quantityShipped;
  double? unitQuantity;
  int? unitFactor;
  String? factorType;
  int? subunitPrice;
  String? jobId;
  String? costCategoryId;
  String? locationId;
  String? sourceVoucherId;
  String? sourceSysDocId;
  int? sourceRowIndex;
  String? rowSource;
  String? refSlNo;
  String? refText1;
  String? refText2;
  String? refText3;
  String? refText4;
  String? refText5;
  int? refNum1;
  int? refNum2;
  String? refDate1;
  String? refDate2;
  String? remarks;
  String? listQuantity;
  String? expiryDate;

  ItemTransactionDetailsModel({
    this.itemcode,
    this.description,
    this.quantity,
    this.rowindex,
    this.unitid,
    this.unitPrice,
    this.quantityReturned,
    this.quantityShipped,
    this.unitQuantity,
    this.unitFactor,
    this.factorType,
    this.subunitPrice,
    this.jobId,
    this.costCategoryId,
    this.locationId,
    this.sourceVoucherId,
    this.sourceSysDocId,
    this.sourceRowIndex,
    this.rowSource,
    this.refSlNo,
    this.refText1,
    this.refText2,
    this.refText3,
    this.refText4,
    this.refText5,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
    this.remarks,
    this.listQuantity,
    this.expiryDate,
  });

  factory ItemTransactionDetailsModel.fromJson(Map<String?, dynamic> json) =>
      ItemTransactionDetailsModel(
        itemcode: json["Itemcode"],
        description: json["Description"],
        quantity: json["Quantity"],
        rowindex: json["Rowindex"],
        unitid: json["Unitid"],
        unitPrice: json["UnitPrice"],
        quantityReturned: json["QuantityReturned"],
        quantityShipped: json["QuantityShipped"],
        unitQuantity: json["UnitQuantity"],
        unitFactor: json["UnitFactor"],
        factorType: json["FactorType"],
        subunitPrice: json["SubunitPrice"],
        jobId: json["JobID"],
        costCategoryId: json["CostCategoryID"],
        locationId: json["LocationID"],
        sourceVoucherId: json["SourceVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        sourceRowIndex: json["SourceRowIndex"],
        rowSource: json["RowSource"],
        refSlNo: json["RefSlNo"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refText3: json["RefText3"],
        refText4: json["RefText4"],
        refText5: json["RefText5"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: json["RefDate1"],
        refDate2: json["RefDate2"],
        remarks: json["Remarks"],
      );

  Map<String?, dynamic> toJson() => {
        "Itemcode": itemcode,
        "Description": description,
        "Quantity": quantity,
        "Rowindex": rowindex,
        "Unitid": unitid,
        "UnitPrice": unitPrice,
        "QuantityReturned": quantityReturned,
        "QuantityShipped": quantityShipped,
        "UnitQuantity": unitQuantity,
        "UnitFactor": unitFactor,
        "FactorType": factorType,
        "SubunitPrice": subunitPrice,
        "JobID": jobId,
        "CostCategoryID": costCategoryId,
        "LocationID": locationId,
        "SourceVoucherID": sourceVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "SourceRowIndex": sourceRowIndex,
        "RowSource": rowSource,
        "RefSlNo": refSlNo,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefText3": refText3,
        "RefText4": refText4,
        "RefText5": refText5,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1,
        "RefDate2": refDate2,
        "Remarks": remarks,
        "ExpiryDate": expiryDate,
      };

  Map<String?, dynamic> toMap() {
    return {
      ItemTransactionDetailsModelNames.itemCode: itemcode,
      ItemTransactionDetailsModelNames.description: description,
      ItemTransactionDetailsModelNames.quantity: quantity,
      ItemTransactionDetailsModelNames.rowIndex: rowindex,
      ItemTransactionDetailsModelNames.unitId: unitid,
      ItemTransactionDetailsModelNames.unitPrice: unitPrice,
      ItemTransactionDetailsModelNames.quantityReturned: quantityReturned,
      ItemTransactionDetailsModelNames.quantityShipped: quantityShipped,
      ItemTransactionDetailsModelNames.unitQuantity: unitQuantity,
      ItemTransactionDetailsModelNames.unitFactor: unitFactor,
      ItemTransactionDetailsModelNames.factorType: factorType,
      ItemTransactionDetailsModelNames.subunitPrice: subunitPrice,
      ItemTransactionDetailsModelNames.jobID: jobId,
      ItemTransactionDetailsModelNames.costCategoryID: costCategoryId,
      ItemTransactionDetailsModelNames.locationID: locationId,
      ItemTransactionDetailsModelNames.sourceVoucherID: sourceVoucherId,
      ItemTransactionDetailsModelNames.sourceSysDocID: sourceSysDocId,
      ItemTransactionDetailsModelNames.sourceRowIndex: sourceRowIndex,
      ItemTransactionDetailsModelNames.rowSource: rowSource,
      ItemTransactionDetailsModelNames.refSlNo: refSlNo,
      ItemTransactionDetailsModelNames.refText1: refText1,
      ItemTransactionDetailsModelNames.refText2: refText2,
      ItemTransactionDetailsModelNames.refText3: refText3,
      ItemTransactionDetailsModelNames.refText4: refText4,
      ItemTransactionDetailsModelNames.refText5: refText5,
      ItemTransactionDetailsModelNames.refNum1: refNum1,
      ItemTransactionDetailsModelNames.refNum2: refNum2,
      ItemTransactionDetailsModelNames.refDate1: refDate1,
      ItemTransactionDetailsModelNames.refDate2: refDate2,
      ItemTransactionDetailsModelNames.remarks: remarks,
      ItemTransactionDetailsModelNames.listQuantity: listQuantity,
    };
  }

  ItemTransactionDetailsModel.fromMap(Map<String, dynamic> map) {
    itemcode = map[ItemTransactionDetailsModelNames.itemCode];
    description = map[ItemTransactionDetailsModelNames.description];
    quantity = map[ItemTransactionDetailsModelNames.quantity];
    rowindex = map[ItemTransactionDetailsModelNames.rowIndex];
    unitid = map[ItemTransactionDetailsModelNames.unitId];
    unitPrice = map[ItemTransactionDetailsModelNames.unitPrice];
    quantityReturned = map[ItemTransactionDetailsModelNames.quantityReturned];
    quantityShipped = map[ItemTransactionDetailsModelNames.quantityShipped];
    unitQuantity = map[ItemTransactionDetailsModelNames.unitQuantity];
    unitFactor = map[ItemTransactionDetailsModelNames.unitFactor];
    factorType = map[ItemTransactionDetailsModelNames.factorType];
    subunitPrice = map[ItemTransactionDetailsModelNames.subunitPrice];
    jobId = map[ItemTransactionDetailsModelNames.jobID];
    costCategoryId = map[ItemTransactionDetailsModelNames.costCategoryID];
    locationId = map[ItemTransactionDetailsModelNames.locationID];
    sourceVoucherId = map[ItemTransactionDetailsModelNames.sourceVoucherID];
    sourceSysDocId = map[ItemTransactionDetailsModelNames.sourceSysDocID];
    sourceRowIndex = map[ItemTransactionDetailsModelNames.sourceRowIndex];
    rowSource = map[ItemTransactionDetailsModelNames.rowSource];
    refSlNo = map[ItemTransactionDetailsModelNames.refSlNo];
    refText1 = map[ItemTransactionDetailsModelNames.refText1];
    refText2 = map[ItemTransactionDetailsModelNames.refText2];
    refText3 = map[ItemTransactionDetailsModelNames.refText3];
    refText4 = map[ItemTransactionDetailsModelNames.refText4];
    refText5 = map[ItemTransactionDetailsModelNames.refText5];
    refNum1 = map[ItemTransactionDetailsModelNames.refNum1];
    refNum2 = map[ItemTransactionDetailsModelNames.refNum2];
    refDate1 = map[ItemTransactionDetailsModelNames.refDate1];
    refDate2 = map[ItemTransactionDetailsModelNames.refDate2];
    remarks = map[ItemTransactionDetailsModelNames.remarks];
    listQuantity = map[ItemTransactionDetailsModelNames.listQuantity];
  }
}
