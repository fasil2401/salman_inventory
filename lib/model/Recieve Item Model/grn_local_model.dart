class GoodsRecieveNoteHeaderModelNames {
  static const String tableName = "goodsRecieveNoteHeader";
  static const String isnewrecord = "isnewrecord";
  static const String sysdocid = "sysdocid";
  static const String voucherid = "voucherid";
  static const String companyid = "companyid";
  static const String divisionid = "divisionid";
  static const String vendorID = "vendorID";
  static const String transporterID = "transporterID";
  static const String termID = "termID";
  static const String transactiondate = "transactiondate";
  static const String purchaseFlow = "purchaseFlow";
  static const String currencyid = "currencyid";
  static const String currencyrate = "currencyrate";
  static const String shippingmethodid = "shippingmethodid";
  static const String reference = "reference";
  static const String reference2 = "reference2";
  static const String vendorReferenceNo = "vendorReferenceNo";
  static const String note = "note";
  static const String isvoid = "isvoid";
  static const String isImport = "isImport";
  static const String payeetaxgroupid = "payeetaxgroupid";
  static const String taxoption = "taxoption";
  static const String driverID = "driverID";
  static const String vehicleID = "vehicleID";
  static const String advanceamount = "advanceamount";
  static const String activateGRNEdit = "activateGRNEdit";
  static const String isSynced = 'isSynced';
  static const String isError = 'isError';
  static const String error = 'error';
}

class GoodsRecieveNoteHeaderModel {
  int? isnewrecord;
  String? sysdocid;
  String? voucherid;
  String? companyid;
  String? divisionid;
  String? vendorId;
  String? transporterId;
  String? termId;
  DateTime? transactiondate;
  int? purchaseFlow;
  String? currencyid;
  int? currencyrate;
  String? shippingmethodid;
  String? reference;
  String? reference2;
  String? vendorReferenceNo;
  String? note;
  int? isvoid;
  int? isImport;
  String? payeetaxgroupid;
  int? taxoption;
  String? driverId;
  String? vehicleId;
  int? advanceamount;
  int? activateGrnEdit;
  int? isSynced;
  int? isError;
  String? error;

  GoodsRecieveNoteHeaderModel({
    this.isnewrecord,
    this.sysdocid,
    this.voucherid,
    this.companyid,
    this.divisionid,
    this.vendorId,
    this.transporterId,
    this.termId,
    this.transactiondate,
    this.purchaseFlow,
    this.currencyid,
    this.currencyrate,
    this.shippingmethodid,
    this.reference,
    this.reference2,
    this.vendorReferenceNo,
    this.note,
    this.isvoid,
    this.isImport,
    this.payeetaxgroupid,
    this.taxoption,
    this.driverId,
    this.vehicleId,
    this.advanceamount,
    this.activateGrnEdit,
    this.isSynced,
    this.isError,
    this.error,
  });

  factory GoodsRecieveNoteHeaderModel.fromJson(Map<String, dynamic> json) =>
      GoodsRecieveNoteHeaderModel(
        isnewrecord: json["Isnewrecord"],
        sysdocid: json["Sysdocid"],
        voucherid: json["Voucherid"],
        companyid: json["Companyid"],
        divisionid: json["Divisionid"],
        vendorId: json["VendorID"],
        transporterId: json["TransporterID"],
        termId: json["TermID"],
        transactiondate: json["Transactiondate"] == null
            ? null
            : DateTime.parse(json["Transactiondate"]),
        purchaseFlow: json["PurchaseFlow"],
        currencyid: json["Currencyid"],
        currencyrate: json["Currencyrate"],
        shippingmethodid: json["Shippingmethodid"],
        reference: json["Reference"],
        reference2: json["Reference2"],
        vendorReferenceNo: json["VendorReferenceNo"],
        note: json["Note"],
        isvoid: json["Isvoid"],
        isImport: json["IsImport"],
        payeetaxgroupid: json["Payeetaxgroupid"],
        taxoption: json["Taxoption"],
        driverId: json["DriverID"],
        vehicleId: json["VehicleID"],
        advanceamount: json["Advanceamount"],
        activateGrnEdit: json["ActivateGRNEdit"],
      );

  Map<String, dynamic> toJson() => {
        "Isnewrecord": isnewrecord,
        "Sysdocid": sysdocid,
        "Voucherid": voucherid,
        "Companyid": companyid,
        "Divisionid": divisionid,
        "VendorID": vendorId,
        "TransporterID": transporterId,
        "TermID": termId,
        "Transactiondate": transactiondate?.toIso8601String(),
        "PurchaseFlow": purchaseFlow,
        "Currencyid": currencyid,
        "Currencyrate": currencyrate,
        "Shippingmethodid": shippingmethodid,
        "Reference": reference,
        "Reference2": reference2,
        "VendorReferenceNo": vendorReferenceNo,
        "Note": note,
        "Isvoid": isvoid,
        "IsImport": isImport,
        "Payeetaxgroupid": payeetaxgroupid,
        "Taxoption": taxoption,
        "DriverID": driverId,
        "VehicleID": vehicleId,
        "Advanceamount": advanceamount,
        "ActivateGRNEdit": activateGrnEdit,
      };
  Map<String, dynamic> toMap() {
    return {
      GoodsRecieveNoteHeaderModelNames.isnewrecord: isnewrecord,
      GoodsRecieveNoteHeaderModelNames.sysdocid: sysdocid,
      GoodsRecieveNoteHeaderModelNames.voucherid: voucherid,
      GoodsRecieveNoteHeaderModelNames.companyid: companyid,
      GoodsRecieveNoteHeaderModelNames.divisionid: divisionid,
      GoodsRecieveNoteHeaderModelNames.vendorID: vendorId,
      GoodsRecieveNoteHeaderModelNames.transporterID: transporterId,
      GoodsRecieveNoteHeaderModelNames.termID: termId,
      GoodsRecieveNoteHeaderModelNames.transactiondate:
          transactiondate?.toIso8601String(),
      GoodsRecieveNoteHeaderModelNames.purchaseFlow: purchaseFlow,
      GoodsRecieveNoteHeaderModelNames.currencyid: currencyid,
      GoodsRecieveNoteHeaderModelNames.currencyrate: currencyrate,
      GoodsRecieveNoteHeaderModelNames.shippingmethodid: shippingmethodid,
      GoodsRecieveNoteHeaderModelNames.reference: reference,
      GoodsRecieveNoteHeaderModelNames.reference2: reference2,
      GoodsRecieveNoteHeaderModelNames.vendorReferenceNo: vendorReferenceNo,
      GoodsRecieveNoteHeaderModelNames.note: note,
      GoodsRecieveNoteHeaderModelNames.isvoid: isvoid,
      GoodsRecieveNoteHeaderModelNames.isImport: isImport,
      GoodsRecieveNoteHeaderModelNames.payeetaxgroupid: payeetaxgroupid,
      GoodsRecieveNoteHeaderModelNames.taxoption: taxoption,
      GoodsRecieveNoteHeaderModelNames.driverID: driverId,
      GoodsRecieveNoteHeaderModelNames.vehicleID: vehicleId,
      GoodsRecieveNoteHeaderModelNames.advanceamount: advanceamount,
      GoodsRecieveNoteHeaderModelNames.activateGRNEdit: activateGrnEdit,
      GoodsRecieveNoteHeaderModelNames.isSynced: isSynced,
      GoodsRecieveNoteHeaderModelNames.isError: isError,
      GoodsRecieveNoteHeaderModelNames.error: error,
    };
  }

  // Create object from a map
  factory GoodsRecieveNoteHeaderModel.fromMap(Map<String, dynamic> map) {
    return GoodsRecieveNoteHeaderModel(
      isnewrecord: map[GoodsRecieveNoteHeaderModelNames.isnewrecord],
      sysdocid: map[GoodsRecieveNoteHeaderModelNames.sysdocid],
      voucherid: map[GoodsRecieveNoteHeaderModelNames.voucherid],
      companyid: map[GoodsRecieveNoteHeaderModelNames.companyid],
      divisionid: map[GoodsRecieveNoteHeaderModelNames.divisionid],
      vendorId: map[GoodsRecieveNoteHeaderModelNames.vendorID],
      transporterId: map[GoodsRecieveNoteHeaderModelNames.transporterID],
      termId: map[GoodsRecieveNoteHeaderModelNames.termID],
      transactiondate:
          map[GoodsRecieveNoteHeaderModelNames.transactiondate] == null
              ? null
              : DateTime.parse(
                  map[GoodsRecieveNoteHeaderModelNames.transactiondate]),
      purchaseFlow: map[GoodsRecieveNoteHeaderModelNames.purchaseFlow],
      currencyid: map[GoodsRecieveNoteHeaderModelNames.currencyid],
      currencyrate: map[GoodsRecieveNoteHeaderModelNames.currencyrate],
      shippingmethodid: map[GoodsRecieveNoteHeaderModelNames.shippingmethodid],
      reference: map[GoodsRecieveNoteHeaderModelNames.reference],
      reference2: map[GoodsRecieveNoteHeaderModelNames.reference2],
      vendorReferenceNo:
          map[GoodsRecieveNoteHeaderModelNames.vendorReferenceNo],
      note: map[GoodsRecieveNoteHeaderModelNames.note],
      isvoid: map[GoodsRecieveNoteHeaderModelNames.isvoid],
      isImport: map[GoodsRecieveNoteHeaderModelNames.isImport],
      payeetaxgroupid: map[GoodsRecieveNoteHeaderModelNames.payeetaxgroupid],
      taxoption: map[GoodsRecieveNoteHeaderModelNames.taxoption],
      driverId: map[GoodsRecieveNoteHeaderModelNames.driverID],
      vehicleId: map[GoodsRecieveNoteHeaderModelNames.vehicleID],
      advanceamount: map[GoodsRecieveNoteHeaderModelNames.advanceamount],
      activateGrnEdit: map[GoodsRecieveNoteHeaderModelNames.activateGRNEdit],
      isSynced: map[GoodsRecieveNoteHeaderModelNames.isSynced],
      isError: map[GoodsRecieveNoteHeaderModelNames.isError],
      error: map[GoodsRecieveNoteHeaderModelNames.error],
    );
  }
}

class GRNDetailsModelNames {
  static const String tableName = "goodsRecieveNoteDetail";
  static const String voucherId = "voucherId";
  static const String itemcode = "itemcode";
  static const String description = "description";
  static const String quantity = "quantity";
  static const String refSlNo = "refSlNo";
  static const String refText1 = "refText1";
  static const String refText2 = "refText2";
  static const String refNum1 = "refNum1";
  static const String refNum2 = "refNum2";
  static const String refDate1 = "refDate1";
  static const String refDate2 = "refdate2";
  static const String locationid = "locationid";
  static const String jobid = "jobid";
  static const String costcategoryid = "costcategoryid";
  static const String unitprice = "unitprice";
  static const String unitID = "unitID";
  static const String remarks = "remarks";
  static const String rowindex = "rowindex";
  static const String jobSubCategoryid = "jobSubCategoryid";
  static const String jobCategoryid = "jobCategoryid";
  static const String specificationID = "specificationID";
  static const String taxoption = "taxoption";
  static const String taxGroupID = "taxGroupID";
  static const String styleid = "styleid";
  static const String itemtype = "itemtype";
  static const String isNew = "isNew";
  static const String cost = "cost";
  static const String amount = "amount";
  static const String rowSource = "rowSource";
}

class GRNDetailsModel {
  String? voucherId;
  String? itemcode;
  String? description;
  int? quantity;
  int? refSlNo;
  String? refText1;
  String? refText2;
  int? refNum1;
  int? refNum2;
  DateTime? refDate1;
  DateTime? refDate2;
  String? locationid;
  String? jobid;
  String? costcategoryid;
  double? unitprice;
  String? unitID;
  String? remarks;
  int? rowindex;
  String? jobSubCategoryid;
  String? jobCategoryid;
  String? specificationID;
  int? taxoption;
  String? taxGroupID;
  String? styleid;
  int? itemtype;
  int? isNew;
  double? cost;
  double? amount;
  int? rowSource;

  GRNDetailsModel({
    this.voucherId,
    this.itemcode,
    this.description,
    this.quantity,
    this.refSlNo,
    this.refText1,
    this.refText2,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
    this.locationid,
    this.jobid,
    this.costcategoryid,
    this.unitprice,
    this.unitID,
    this.remarks,
    this.rowindex,
    this.jobSubCategoryid,
    this.jobCategoryid,
    this.specificationID,
    this.taxoption,
    this.taxGroupID,
    this.styleid,
    this.itemtype,
    this.isNew,
    this.cost,
    this.amount,
    this.rowSource,
  });

  Map<String, dynamic> toMap() {
    return {
      GRNDetailsModelNames.voucherId: voucherId,
      GRNDetailsModelNames.itemcode: itemcode,
      GRNDetailsModelNames.description: description,
      GRNDetailsModelNames.quantity: quantity,
      GRNDetailsModelNames.refSlNo: refSlNo,
      GRNDetailsModelNames.refText1: refText1,
      GRNDetailsModelNames.refText2: refText2,
      GRNDetailsModelNames.refNum1: refNum1,
      GRNDetailsModelNames.refNum2: refNum2,
      GRNDetailsModelNames.refDate1: refDate1?.toIso8601String(),
      GRNDetailsModelNames.refDate2: refDate2?.toIso8601String(),
      GRNDetailsModelNames.locationid: locationid,
      GRNDetailsModelNames.jobid: jobid,
      GRNDetailsModelNames.costcategoryid: costcategoryid,
      GRNDetailsModelNames.unitprice: unitprice,
      GRNDetailsModelNames.unitID: unitID,
      GRNDetailsModelNames.remarks: remarks,
      GRNDetailsModelNames.rowindex: rowindex,
      GRNDetailsModelNames.jobSubCategoryid: jobSubCategoryid,
      GRNDetailsModelNames.jobCategoryid: jobCategoryid,
      GRNDetailsModelNames.specificationID: specificationID,
      GRNDetailsModelNames.taxoption: taxoption,
      GRNDetailsModelNames.taxGroupID: taxGroupID,
      GRNDetailsModelNames.styleid: styleid,
      GRNDetailsModelNames.itemtype: itemtype,
      GRNDetailsModelNames.isNew: isNew,
      GRNDetailsModelNames.cost: cost,
      GRNDetailsModelNames.amount: amount,
      GRNDetailsModelNames.rowSource: rowSource,
    };
  }

  factory GRNDetailsModel.fromMap(Map<String, dynamic> map) {
    return GRNDetailsModel(
      voucherId: map[GRNDetailsModelNames.voucherId],
      itemcode: map[GRNDetailsModelNames.itemcode],
      description: map[GRNDetailsModelNames.description],
      quantity: map[GRNDetailsModelNames.quantity],
      refSlNo: map[GRNDetailsModelNames.refSlNo],
      refText1: map[GRNDetailsModelNames.refText1],
      refText2: map[GRNDetailsModelNames.refText2],
      refNum1: map[GRNDetailsModelNames.refNum1],
      refNum2: map[GRNDetailsModelNames.refNum2],
      refDate1: map[GRNDetailsModelNames.refDate1] == null
          ? null
          : DateTime.parse(map[GRNDetailsModelNames.refDate1]),
      refDate2: map[GRNDetailsModelNames.refDate2] == null
          ? null
          : DateTime.parse(map[GRNDetailsModelNames.refDate2]),
      locationid: map[GRNDetailsModelNames.locationid],
      jobid: map[GRNDetailsModelNames.jobid],
      costcategoryid: map[GRNDetailsModelNames.costcategoryid],
      unitprice: map[GRNDetailsModelNames.unitprice],
      unitID: map[GRNDetailsModelNames.unitID],
      remarks: map[GRNDetailsModelNames.remarks],
      rowindex: map[GRNDetailsModelNames.rowindex],
      jobSubCategoryid: map[GRNDetailsModelNames.jobSubCategoryid],
      jobCategoryid: map[GRNDetailsModelNames.jobCategoryid],
      specificationID: map[GRNDetailsModelNames.specificationID],
      taxoption: map[GRNDetailsModelNames.taxoption],
      taxGroupID: map[GRNDetailsModelNames.taxGroupID],
      styleid: map[GRNDetailsModelNames.styleid],
      itemtype: map[GRNDetailsModelNames.itemtype],
      isNew: map[GRNDetailsModelNames.isNew],
      cost: map[GRNDetailsModelNames.cost],
      amount: map[GRNDetailsModelNames.amount],
      rowSource: map[GRNDetailsModelNames.rowSource],
    );
  }
}

class ProductLotReceivingDetailModelNames {
  static const String tableName = "goodsRecieveNoteLot";
  static const String sysdocid = "sysdocid";
  static const String voucherid = "voucherid";
  static const String productID = "productID";
  static const String unitID = "unitID";
  static const String locationId = "locationId";
  static const String lotNumber = "lotNumber";
  static const String reference = "reference";
  static const String sourceLotNumber = "sourceLotNumber";
  static const String quantity = "quantity";
  static const String binID = "binID";
  static const String reference2 = "reference2";
  static const String unitPrice = "unitPrice";
  static const String rowIndex = "rowIndex";
  static const String cost = "cost";
  static const String soldQty = "soldQty";
  static const String rackID = "rackID";
  static const String lotQty = "lotQty";
  static const String expiryDate = "expiryDate";
  static const String refSlNo = "refSlNo";
  static const String refext1 = "refext1";
  static const String reftext2 = "reftext2";
  static const String reftext3 = "reftext3";
  static const String reftext4 = "reftext4";
  static const String reftext5 = "reftext5";
  static const String refNum1 = "refNum1";
  static const String refNum2 = "refNum2";
  static const String refDate1 = "refDate1";
  static const String refDate2 = "refDate2";
}

class ProductLotReceivingDetailModel {
  String? sysdocid;
  String? voucherid;
  String? productID;
  String? unitID;
  String? locationId;
  String? lotNumber;
  String? reference;
  String? sourceLotNumber;
  int? quantity;
  String? binID;
  String? reference2;
  double? unitPrice;
  int? rowIndex;
  double? cost;
  double? soldQty;
  String? rackID;
  int? lotQty;
  DateTime? expiryDate;
  int? refSlNo;
  String? refext1;
  String? reftext2;
  String? reftext3;
  String? reftext4;
  String? reftext5;
  int? refNum1;
  int? refNum2;
  DateTime? refDate1;
  DateTime? refDate2;

  ProductLotReceivingDetailModel({
    this.sysdocid,
    this.voucherid,
    this.productID,
    this.unitID,
    this.locationId,
    this.lotNumber,
    this.reference,
    this.sourceLotNumber,
    this.quantity,
    this.binID,
    this.reference2,
    this.unitPrice,
    this.rowIndex,
    this.cost,
    this.soldQty,
    this.rackID,
    this.lotQty,
    this.expiryDate,
    this.refSlNo,
    this.refext1,
    this.reftext2,
    this.reftext3,
    this.reftext4,
    this.reftext5,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
  });

  Map<String, dynamic> toMap() {
    return {
      ProductLotReceivingDetailModelNames.sysdocid: sysdocid,
      ProductLotReceivingDetailModelNames.voucherid: voucherid,
      ProductLotReceivingDetailModelNames.productID: productID,
      ProductLotReceivingDetailModelNames.unitID: unitID,
      ProductLotReceivingDetailModelNames.locationId: locationId,
      ProductLotReceivingDetailModelNames.lotNumber: lotNumber,
      ProductLotReceivingDetailModelNames.reference: reference,
      ProductLotReceivingDetailModelNames.sourceLotNumber: sourceLotNumber,
      ProductLotReceivingDetailModelNames.quantity: quantity,
      ProductLotReceivingDetailModelNames.binID: binID,
      ProductLotReceivingDetailModelNames.reference2: reference2,
      ProductLotReceivingDetailModelNames.unitPrice: unitPrice,
      ProductLotReceivingDetailModelNames.rowIndex: rowIndex,
      ProductLotReceivingDetailModelNames.cost: cost,
      ProductLotReceivingDetailModelNames.soldQty: soldQty,
      ProductLotReceivingDetailModelNames.rackID: rackID,
      ProductLotReceivingDetailModelNames.lotQty: lotQty,
      ProductLotReceivingDetailModelNames.expiryDate:
          expiryDate?.toIso8601String(),
      ProductLotReceivingDetailModelNames.refSlNo: refSlNo,
      ProductLotReceivingDetailModelNames.refext1: refext1,
      ProductLotReceivingDetailModelNames.reftext2: reftext2,
      ProductLotReceivingDetailModelNames.reftext3: reftext3,
      ProductLotReceivingDetailModelNames.reftext4: reftext4,
      ProductLotReceivingDetailModelNames.reftext5: reftext5,
      ProductLotReceivingDetailModelNames.refNum1: refNum1,
      ProductLotReceivingDetailModelNames.refNum2: refNum2,
      ProductLotReceivingDetailModelNames.refDate1: refDate1?.toIso8601String(),
      ProductLotReceivingDetailModelNames.refDate2: refDate2?.toIso8601String(),
    };
  }

  factory ProductLotReceivingDetailModel.fromMap(Map<String, dynamic> map) {
    return ProductLotReceivingDetailModel(
      sysdocid: map[ProductLotReceivingDetailModelNames.sysdocid],
      voucherid: map[ProductLotReceivingDetailModelNames.voucherid],
      productID: map[ProductLotReceivingDetailModelNames.productID],
      unitID: map[ProductLotReceivingDetailModelNames.unitID],
      locationId: map[ProductLotReceivingDetailModelNames.locationId],
      lotNumber: map[ProductLotReceivingDetailModelNames.lotNumber],
      reference: map[ProductLotReceivingDetailModelNames.reference],
      sourceLotNumber: map[ProductLotReceivingDetailModelNames.sourceLotNumber],
      quantity: map[ProductLotReceivingDetailModelNames.quantity],
      binID: map[ProductLotReceivingDetailModelNames.binID],
      reference2: map[ProductLotReceivingDetailModelNames.reference2],
      unitPrice: map[ProductLotReceivingDetailModelNames.unitPrice],
      rowIndex: map[ProductLotReceivingDetailModelNames.rowIndex],
      cost: map[ProductLotReceivingDetailModelNames.cost],
      soldQty: map[ProductLotReceivingDetailModelNames.soldQty],
      rackID: map[ProductLotReceivingDetailModelNames.rackID],
      lotQty: map[ProductLotReceivingDetailModelNames.lotQty],
      expiryDate: map[ProductLotReceivingDetailModelNames.expiryDate] == null
          ? null
          : DateTime.parse(map[ProductLotReceivingDetailModelNames.expiryDate]),
      refSlNo: map[ProductLotReceivingDetailModelNames.refSlNo],
      refext1: map[ProductLotReceivingDetailModelNames.refext1],
      reftext2: map[ProductLotReceivingDetailModelNames.reftext2],
      reftext3: map[ProductLotReceivingDetailModelNames.reftext3],
      reftext4: map[ProductLotReceivingDetailModelNames.reftext4],
      reftext5: map[ProductLotReceivingDetailModelNames.reftext5],
      refNum1: map[ProductLotReceivingDetailModelNames.refNum1],
      refNum2: map[ProductLotReceivingDetailModelNames.refNum2],
      refDate1: map[ProductLotReceivingDetailModelNames.refDate1] == null
          ? null
          : DateTime.parse(map[ProductLotReceivingDetailModelNames.refDate1]),
      refDate2: map[ProductLotReceivingDetailModelNames.refDate2] == null
          ? null
          : DateTime.parse(map[ProductLotReceivingDetailModelNames.refDate2]),
    );
  }
}
