// To parse this JSON data, do
//
//     final getGrnByIdModel = getGrnByIdModelFromJson(jsonString);

import 'dart:convert';

GetGrnByIdModel getGrnByIdModelFromJson(String str) =>
    GetGrnByIdModel.fromJson(json.decode(str));

String getGrnByIdModelToJson(GetGrnByIdModel data) =>
    json.encode(data.toJson());

class GetGrnByIdModel {
  int? result;
  List<Header>? header;
  List<Detail>? detail;
  List<Lotdetail>? lotdetail;

  GetGrnByIdModel({
    this.result,
    this.header,
    this.detail,
    this.lotdetail,
  });

  factory GetGrnByIdModel.fromJson(Map<String, dynamic> json) =>
      GetGrnByIdModel(
        result: json["result"],
        header:
            List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
        detail:
            List<Detail>.from(json["Detail"].map((x) => Detail.fromJson(x))),
        lotdetail: List<Lotdetail>.from(
            json["Lotdetail"].map((x) => Lotdetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "Header": List<dynamic>.from(header!.map((x) => x.toJson())),
        "Detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
        "Lotdetail": List<dynamic>.from(lotdetail!.map((x) => x.toJson())),
      };
}

class Detail {
  String? sysDocId;
  String? voucherId;
  String? productId;
  dynamic quantity;
  dynamic unitPrice;
  String? description;
  String? unitId;
  dynamic unitQuantity;
  dynamic unitFactor;
  dynamic factorType;
  String? jobId;
  dynamic costCategoryId;
  String? locationId;
  dynamic rowIndex;
  dynamic orderVoucherId;
  dynamic rowsource;
  dynamic orderSysDocId;
  dynamic orderRowIndex;
  dynamic isPorRow;
  dynamic pkVoucherId;
  dynamic pkSysDocId;
  dynamic pkRowIndex;
  String? specificationId;
  String? styleId;
  dynamic listVoucherId;
  dynamic listSysDocId;
  dynamic listRowIndex;
  String? remarks;
  String? taxGroupId;
  dynamic taxOption;
  dynamic jobCategoryId;
  dynamic jobSubCategoryId;
  dynamic lCost;
  dynamic lCostAmount;
  dynamic refSlNo;
  dynamic refText1;
  dynamic refText2;
  dynamic refNum1;
  dynamic refNum2;
  DateTime? refDate1;
  DateTime? refDate2;
  dynamic isNew;
  dynamic quantityReturned;
  dynamic unitPrice1;
  dynamic itRowId;
  String? description1;
  String? attribute1;
  String? attribute2;
  String? attribute3;
  bool? isTrackLot;
  bool? isTrackSerial;
  dynamic matrixParentId;
  dynamic itemType;
  String? itemTaxGroupId;
  dynamic taxOption1;
  dynamic received;
  dynamic ordered;
  dynamic minGuarantee;

  Detail({
    this.sysDocId,
    this.voucherId,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.description,
    this.unitId,
    this.unitQuantity,
    this.unitFactor,
    this.factorType,
    this.jobId,
    this.costCategoryId,
    this.locationId,
    this.rowIndex,
    this.orderVoucherId,
    this.rowsource,
    this.orderSysDocId,
    this.orderRowIndex,
    this.isPorRow,
    this.pkVoucherId,
    this.pkSysDocId,
    this.pkRowIndex,
    this.specificationId,
    this.styleId,
    this.listVoucherId,
    this.listSysDocId,
    this.listRowIndex,
    this.remarks,
    this.taxGroupId,
    this.taxOption,
    this.jobCategoryId,
    this.jobSubCategoryId,
    this.lCost,
    this.lCostAmount,
    this.refSlNo,
    this.refText1,
    this.refText2,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
    this.isNew,
    this.quantityReturned,
    this.unitPrice1,
    this.itRowId,
    this.description1,
    this.attribute1,
    this.attribute2,
    this.attribute3,
    this.isTrackLot,
    this.isTrackSerial,
    this.matrixParentId,
    this.itemType,
    this.itemTaxGroupId,
    this.taxOption1,
    this.received,
    this.ordered,
    this.minGuarantee,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        productId: json["ProductID"],
        quantity: json["Quantity"],
        unitPrice: json["UnitPrice"],
        description: json["Description"],
        unitId: json["UnitID"],
        unitQuantity: json["UnitQuantity"],
        unitFactor: json["UnitFactor"],
        factorType: json["FactorType"],
        jobId: json["JobID"],
        costCategoryId: json["CostCategoryID"],
        locationId: json["LocationID"],
        rowIndex: json["RowIndex"],
        orderVoucherId: json["OrderVoucherID"],
        rowsource: json["ROWSOURCE"],
        orderSysDocId: json["OrderSysDocID"],
        orderRowIndex: json["OrderRowIndex"],
        isPorRow: json["IsPORRow"],
        pkVoucherId: json["PKVoucherID"],
        pkSysDocId: json["PKSysDocID"],
        pkRowIndex: json["PKRowIndex"],
        specificationId: json["SpecificationID"],
        styleId: json["StyleID"],
        listVoucherId: json["ListVoucherID"],
        listSysDocId: json["ListSysDocID"],
        listRowIndex: json["ListRowIndex"],
        remarks: json["Remarks"],
        taxGroupId: json["TaxGroupID"],
        taxOption: json["TaxOption"],
        jobCategoryId: json["JobCategoryID"],
        jobSubCategoryId: json["JobSubCategoryID"],
        lCost: json["LCost"],
        lCostAmount: json["LCostAmount"],
        refSlNo: json["RefSlNo"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: DateTime.parse(json["RefDate1"]),
        refDate2: DateTime.parse(json["RefDate2"]),
        isNew: json["IsNew"],
        quantityReturned: json["QuantityReturned"],
        unitPrice1: json["UnitPrice1"],
        itRowId: json["ITRowID"],
        description1: json["Description1"],
        attribute1: json["Attribute1"],
        attribute2: json["Attribute2"],
        attribute3: json["Attribute3"],
        isTrackLot: json["IsTrackLot"],
        isTrackSerial: json["IsTrackSerial"],
        matrixParentId: json["MatrixParentID"],
        itemType: json["ItemType"],
        itemTaxGroupId: json["ItemTaxGroupID"],
        taxOption1: json["TaxOption1"],
        received: json["Received"],
        ordered: json["Ordered"],
        minGuarantee: json["MinGuarantee"],
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "ProductID": productId,
        "Quantity": quantity,
        "UnitPrice": unitPrice,
        "Description": description,
        "UnitID": unitId,
        "UnitQuantity": unitQuantity,
        "UnitFactor": unitFactor,
        "FactorType": factorType,
        "JobID": jobId,
        "CostCategoryID": costCategoryId,
        "LocationID": locationId,
        "RowIndex": rowIndex,
        "OrderVoucherID": orderVoucherId,
        "ROWSOURCE": rowsource,
        "OrderSysDocID": orderSysDocId,
        "OrderRowIndex": orderRowIndex,
        "IsPORRow": isPorRow,
        "PKVoucherID": pkVoucherId,
        "PKSysDocID": pkSysDocId,
        "PKRowIndex": pkRowIndex,
        "SpecificationID": specificationId,
        "StyleID": styleId,
        "ListVoucherID": listVoucherId,
        "ListSysDocID": listSysDocId,
        "ListRowIndex": listRowIndex,
        "Remarks": remarks,
        "TaxGroupID": taxGroupId,
        "TaxOption": taxOption,
        "JobCategoryID": jobCategoryId,
        "JobSubCategoryID": jobSubCategoryId,
        "LCost": lCost,
        "LCostAmount": lCostAmount,
        "RefSlNo": refSlNo,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1!.toIso8601String(),
        "RefDate2": refDate2!.toIso8601String(),
        "IsNew": isNew,
        "QuantityReturned": quantityReturned,
        "UnitPrice1": unitPrice1,
        "ITRowID": itRowId,
        "Description1": description1,
        "Attribute1": attribute1,
        "Attribute2": attribute2,
        "Attribute3": attribute3,
        "IsTrackLot": isTrackLot,
        "IsTrackSerial": isTrackSerial,
        "MatrixParentID": matrixParentId,
        "ItemType": itemType,
        "ItemTaxGroupID": itemTaxGroupId,
        "TaxOption1": taxOption1,
        "Received": received,
        "Ordered": ordered,
        "MinGuarantee": minGuarantee,
      };
}

class Header {
  String? sysDocId;
  String? voucherId;
  String? divisionId;
  String? companyId;
  String? vendorId;
  DateTime? transactionDate;
  dynamic buyerId;
  dynamic status;
  dynamic currencyId;
  int? purchaseFlow;
  int? currencyRate;
  String? termId;
  dynamic shippingMethodId;
  String? reference;
  String? reference2;
  String? vendorReferenceNo;
  String? note;
  dynamic poNumber;
  int? sourceDocType;
  dynamic isVoid;
  dynamic discount;
  dynamic discountFc;
  dynamic taxAmount;
  dynamic taxAmountFc;
  dynamic total;
  dynamic totalFc;
  bool? isImport;
  dynamic poSysDocId;
  dynamic poVoucherId;
  dynamic sourceSysDocId;
  dynamic sourceVoucherId;
  String? transporterId;
  dynamic driverId;
  String? vehicleId;
  dynamic containerNumber;
  dynamic containerSizeId;
  dynamic payeeTaxGroupId;
  int? taxOption;
  dynamic claimStatus;
  dynamic claimRef1;
  dynamic claimRef2;
  dynamic groupName;
  dynamic claimAmount;
  dynamic claimAmountFc;
  dynamic claimRemarks;
  dynamic claimCurrencyId;
  dynamic claimCurrencyRate;
  bool? activateGrnEdit;
  dynamic recivedAmount;
  dynamic recivedAmountRefernce;
  dynamic isInvoiced;
  dynamic invoiceSysDocId;
  dynamic invoiceVoucherId;
  dynamic approvalStatus;
  dynamic verificationStatus;
  dynamic dateCreated;
  dynamic dateUpdated;
  String? createdBy;
  String? updatedBy;
  dynamic paymentTermId;
  dynamic bolNumber;
  dynamic clearingAgent;
  dynamic containerNumber1;
  dynamic port;
  dynamic buyerName;
  int? taxOption1;

  Header({
    this.sysDocId,
    this.voucherId,
    this.divisionId,
    this.companyId,
    this.vendorId,
    this.transactionDate,
    this.buyerId,
    this.status,
    this.currencyId,
    this.purchaseFlow,
    this.currencyRate,
    this.termId,
    this.shippingMethodId,
    this.reference,
    this.reference2,
    this.vendorReferenceNo,
    this.note,
    this.poNumber,
    this.sourceDocType,
    this.isVoid,
    this.discount,
    this.discountFc,
    this.taxAmount,
    this.taxAmountFc,
    this.total,
    this.totalFc,
    this.isImport,
    this.poSysDocId,
    this.poVoucherId,
    this.sourceSysDocId,
    this.sourceVoucherId,
    this.transporterId,
    this.driverId,
    this.vehicleId,
    this.containerNumber,
    this.containerSizeId,
    this.payeeTaxGroupId,
    this.taxOption,
    this.claimStatus,
    this.claimRef1,
    this.claimRef2,
    this.groupName,
    this.claimAmount,
    this.claimAmountFc,
    this.claimRemarks,
    this.claimCurrencyId,
    this.claimCurrencyRate,
    this.activateGrnEdit,
    this.recivedAmount,
    this.recivedAmountRefernce,
    this.isInvoiced,
    this.invoiceSysDocId,
    this.invoiceVoucherId,
    this.approvalStatus,
    this.verificationStatus,
    this.dateCreated,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.paymentTermId,
    this.bolNumber,
    this.clearingAgent,
    this.containerNumber1,
    this.port,
    this.buyerName,
    this.taxOption1,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        divisionId: json["DivisionID"],
        companyId: json["CompanyID"],
        vendorId: json["VendorID"],
        transactionDate: DateTime.parse(json["TransactionDate"]),
        buyerId: json["BuyerID"],
        status: json["Status"],
        currencyId: json["CurrencyID"],
        purchaseFlow: json["PurchaseFlow"],
        currencyRate: json["CurrencyRate"],
        termId: json["TermID"],
        shippingMethodId: json["ShippingMethodID"],
        reference: json["Reference"],
        reference2: json["Reference2"],
        vendorReferenceNo: json["VendorReferenceNo"],
        note: json["Note"],
        poNumber: json["PONumber"],
        sourceDocType: json["SourceDocType"],
        isVoid: json["IsVoid"],
        discount: json["Discount"],
        discountFc: json["DiscountFC"],
        taxAmount: json["TaxAmount"],
        taxAmountFc: json["TaxAmountFC"],
        total: json["Total"],
        totalFc: json["TotalFC"],
        isImport: json["IsImport"],
        poSysDocId: json["POSysDocID"],
        poVoucherId: json["POVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        sourceVoucherId: json["SourceVoucherID"],
        transporterId: json["TransporterID"],
        driverId: json["DriverID"],
        vehicleId: json["VehicleID"],
        containerNumber: json["ContainerNumber"],
        containerSizeId: json["ContainerSizeID"],
        payeeTaxGroupId: json["PayeeTaxGroupID"],
        taxOption: json["TaxOption"],
        claimStatus: json["ClaimStatus"],
        claimRef1: json["ClaimRef1"],
        claimRef2: json["ClaimRef2"],
        groupName: json["GroupName"],
        claimAmount: json["ClaimAmount"],
        claimAmountFc: json["ClaimAmountFC"],
        claimRemarks: json["ClaimRemarks"],
        claimCurrencyId: json["ClaimCurrencyID"],
        claimCurrencyRate: json["ClaimCurrencyRate"],
        activateGrnEdit: json["ActivateGrnEdit"],
        recivedAmount: json["RecivedAmount"],
        recivedAmountRefernce: json["RecivedAmountRefernce"],
        isInvoiced: json["IsInvoiced"],
        invoiceSysDocId: json["InvoiceSysDocID"],
        invoiceVoucherId: json["InvoiceVoucherID"],
        approvalStatus: json["ApprovalStatus"],
        verificationStatus: json["VerificationStatus"],
        dateCreated: DateTime.parse(json["DateCreated"]),
        dateUpdated: json["DateUpdated"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
        paymentTermId: json["PaymentTermID"],
        bolNumber: json["BOLNumber"],
        clearingAgent: json["ClearingAgent"],
        containerNumber1: json["ContainerNumber1"],
        port: json["Port"],
        buyerName: json["BuyerName"],
        taxOption1: json["TaxOption1"],
      );

  Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "DivisionID": divisionId,
        "CompanyID": companyId,
        "VendorID": vendorId,
        "TransactionDate": transactionDate!.toIso8601String(),
        "BuyerID": buyerId,
        "Status": status,
        "CurrencyID": currencyId,
        "PurchaseFlow": purchaseFlow,
        "CurrencyRate": currencyRate,
        "TermID": termId,
        "ShippingMethodID": shippingMethodId,
        "Reference": reference,
        "Reference2": reference2,
        "VendorReferenceNo": vendorReferenceNo,
        "Note": note,
        "PONumber": poNumber,
        "SourceDocType": sourceDocType,
        "IsVoid": isVoid,
        "Discount": discount,
        "DiscountFC": discountFc,
        "TaxAmount": taxAmount,
        "TaxAmountFC": taxAmountFc,
        "Total": total,
        "TotalFC": totalFc,
        "IsImport": isImport,
        "POSysDocID": poSysDocId,
        "POVoucherID": poVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "SourceVoucherID": sourceVoucherId,
        "TransporterID": transporterId,
        "DriverID": driverId,
        "VehicleID": vehicleId,
        "ContainerNumber": containerNumber,
        "ContainerSizeID": containerSizeId,
        "PayeeTaxGroupID": payeeTaxGroupId,
        "TaxOption": taxOption,
        "ClaimStatus": claimStatus,
        "ClaimRef1": claimRef1,
        "ClaimRef2": claimRef2,
        "GroupName": groupName,
        "ClaimAmount": claimAmount,
        "ClaimAmountFC": claimAmountFc,
        "ClaimRemarks": claimRemarks,
        "ClaimCurrencyID": claimCurrencyId,
        "ClaimCurrencyRate": claimCurrencyRate,
        "ActivateGrnEdit": activateGrnEdit,
        "RecivedAmount": recivedAmount,
        "RecivedAmountRefernce": recivedAmountRefernce,
        "IsInvoiced": isInvoiced,
        "InvoiceSysDocID": invoiceSysDocId,
        "InvoiceVoucherID": invoiceVoucherId,
        "ApprovalStatus": approvalStatus,
        "VerificationStatus": verificationStatus,
        "DateCreated": dateCreated!.toIso8601String(),
        "DateUpdated": dateUpdated!.toIso8601String(),
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "PaymentTermID": paymentTermId,
        "BOLNumber": bolNumber,
        "ClearingAgent": clearingAgent,
        "ContainerNumber1": containerNumber1,
        "Port": port,
        "BuyerName": buyerName,
        "TaxOption1": taxOption1,
      };
}

class Lotdetail {
  String? lotNumber;
  dynamic sourceLotNumber;
  dynamic reference;
  String? locationId;
  String? binId;
  String? rackId;
  String? productId;
  String? sysDocId;
  String? voucherId;
  dynamic rowIndex;
  dynamic lotQty;
  dynamic soldQty;
  DateTime? productionDate;
  DateTime? expiryDate;
  dynamic receiptDate;
  String? reference2;
  dynamic unitQuantity;
  dynamic factor;
  String? factorType;
  String? unitId;
  dynamic refSlNo;
  String? refText1;
  String? refText2;
  dynamic refNum1;
  dynamic refNum2;
  DateTime? refDate1;
  DateTime? refDate2;
  String? refText3;
  String? refText4;
  String? refText5;

  Lotdetail({
    this.lotNumber,
    this.sourceLotNumber,
    this.reference,
    this.locationId,
    this.binId,
    this.rackId,
    this.productId,
    this.sysDocId,
    this.voucherId,
    this.rowIndex,
    this.lotQty,
    this.soldQty,
    this.productionDate,
    this.expiryDate,
    this.receiptDate,
    this.reference2,
    this.unitQuantity,
    this.factor,
    this.factorType,
    this.unitId,
    this.refSlNo,
    this.refText1,
    this.refText2,
    this.refNum1,
    this.refNum2,
    this.refDate1,
    this.refDate2,
    this.refText3,
    this.refText4,
    this.refText5,
  });

  factory Lotdetail.fromJson(Map<String, dynamic> json) => Lotdetail(
        lotNumber: json["LotNumber"],
        sourceLotNumber: json["SourceLotNumber"],
        reference: json["Reference"],
        locationId: json["LocationID"],
        binId: json["BinID"],
        rackId: json["RackID"],
        productId: json["ProductID"],
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        rowIndex: json["RowIndex"],
        lotQty: json["LotQty"],
        soldQty: json["SoldQty"],
        productionDate: DateTime.parse(json["ProductionDate"]),
        expiryDate: DateTime.parse(json["ExpiryDate"]),
        receiptDate: json["ReceiptDate"],
        reference2: json["Reference2"],
        unitQuantity: json["UnitQuantity"],
        factor: json["Factor"],
        factorType: json["FactorType"],
        unitId: json["UnitID"],
        refSlNo: json["RefSlNo"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: DateTime.parse(json["RefDate1"]),
        refDate2: DateTime.parse(json["RefDate2"]),
        refText3: json["RefText3"],
        refText4: json["RefText4"],
        refText5: json["RefText5"],
      );

  Map<String, dynamic> toJson() => {
        "LotNumber": lotNumber,
        "SourceLotNumber": sourceLotNumber,
        "Reference": reference,
        "LocationID": locationId,
        "BinID": binId,
        "RackID": rackId,
        "ProductID": productId,
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "RowIndex": rowIndex,
        "LotQty": lotQty,
        "SoldQty": soldQty,
        "ProductionDate": productionDate!.toIso8601String(),
        "ExpiryDate": expiryDate!.toIso8601String(),
        "ReceiptDate": receiptDate,
        "Reference2": reference2,
        "UnitQuantity": unitQuantity,
        "Factor": factor,
        "FactorType": factorType,
        "UnitID": unitId,
        "RefSlNo": refSlNo,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1!.toIso8601String(),
        "RefDate2": refDate2!.toIso8601String(),
        "RefText3": refText3,
        "RefText4": refText4,
        "RefText5": refText5,
      };
}
