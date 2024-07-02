// To parse this JSON data, do
//
//     final createGoodsRecieveNoteDetailModel = createGoodsRecieveNoteDetailModelFromJson(jsonString);

import 'dart:convert';

CreateGoodsRecieveNoteDetailModel createGoodsRecieveNoteDetailModelFromJson(String str) => CreateGoodsRecieveNoteDetailModel.fromJson(json.decode(str));

String createGoodsRecieveNoteDetailModelToJson(CreateGoodsRecieveNoteDetailModel data) => json.encode(data.toJson());

class CreateGoodsRecieveNoteDetailModel {
    String? token;
    bool? isnewrecord;
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
    bool? isvoid;
    bool? isImport;
    String? payeetaxgroupid;
    int? taxoption;
    String? driverId;
    String? vehicleId;
    int? advanceamount;
    bool? activateGrnEdit;
    List<GrnDetail>? grnDetails;
    List<ProductLotReceivingDetail>? productLotReceivingDetail;

    CreateGoodsRecieveNoteDetailModel({
        this.token,
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
        this.grnDetails,
        this.productLotReceivingDetail,
    });

    factory CreateGoodsRecieveNoteDetailModel.fromJson(Map<String, dynamic> json) => CreateGoodsRecieveNoteDetailModel(
        token: json["token"],
        isnewrecord: json["Isnewrecord"],
        sysdocid: json["Sysdocid"],
        voucherid: json["Voucherid"],
        companyid: json["Companyid"],
        divisionid: json["Divisionid"],
        vendorId: json["VendorID"],
        transporterId: json["TransporterID"],
        termId: json["TermID"],
        transactiondate: json["Transactiondate"] == null ? null : DateTime.parse(json["Transactiondate"]),
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
        grnDetails: json["GRNDetails"] == null ? [] : List<GrnDetail>.from(json["GRNDetails"]!.map((x) => GrnDetail.fromJson(x))),
        productLotReceivingDetail: json["ProductLotReceivingDetail"] == null ? [] : List<ProductLotReceivingDetail>.from(json["ProductLotReceivingDetail"]!.map((x) => ProductLotReceivingDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
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
        "GRNDetails": grnDetails == null ? [] : List<dynamic>.from(grnDetails!.map((x) => x.toJson())),
        "ProductLotReceivingDetail": productLotReceivingDetail == null ? [] : List<dynamic>.from(productLotReceivingDetail!.map((x) => x.toJson())),
    };
}

class GrnDetail {
    String? itemcode;
    String? description;
    dynamic quantity;
    dynamic refSlNo;
    String? refText1;
    String? refText2;
    dynamic refNum1;
    dynamic refNum2;
    DateTime? refDate1;
    DateTime? refdate2;
    String? locationid;
    String? jobid;
    String? costcategoryid;
    dynamic unitprice;
    String? unitId;
    String? remarks;
    dynamic rowindex;
    String? jobSubCategoryid;
    String? jobCategoryid;
    String? specificationId;
    dynamic taxoption;
    String? taxGroupId;
    String? styleid;
    dynamic itemtype;
    dynamic isNew;
    dynamic cost;
    dynamic amount;
    dynamic rowSource;

    GrnDetail({
        this.itemcode,
        this.description,
        this.quantity,
        this.refSlNo,
        this.refText1,
        this.refText2,
        this.refNum1,
        this.refNum2,
        this.refDate1,
        this.refdate2,
        this.locationid,
        this.jobid,
        this.costcategoryid,
        this.unitprice,
        this.unitId,
        this.remarks,
        this.rowindex,
        this.jobSubCategoryid,
        this.jobCategoryid,
        this.specificationId,
        this.taxoption,
        this.taxGroupId,
        this.styleid,
        this.itemtype,
        this.isNew,
        this.cost,
        this.amount,
        this.rowSource,
    });

    factory GrnDetail.fromJson(Map<String, dynamic> json) => GrnDetail(
        itemcode: json["Itemcode"],
        description: json["Description"],
        quantity: json["Quantity"],
        refSlNo: json["RefSlNo"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: json["RefDate1"] == null ? null : DateTime.parse(json["RefDate1"]),
        refdate2: json["Refdate2"] == null ? null : DateTime.parse(json["Refdate2"]),
        locationid: json["Locationid"],
        jobid: json["Jobid"],
        costcategoryid: json["Costcategoryid"],
        unitprice: json["Unitprice"],
        unitId: json["UnitID"],
        remarks: json["Remarks"],
        rowindex: json["Rowindex"],
        jobSubCategoryid: json["JobSubCategoryid"],
        jobCategoryid: json["JobCategoryid"],
        specificationId: json["SpecificationID"],
        taxoption: json["Taxoption"],
        taxGroupId: json["TaxGroupID"],
        styleid: json["Styleid"],
        itemtype: json["Itemtype"],
        isNew: json["IsNew"],
        cost: json["Cost"],
        amount: json["Amount"],
        rowSource: json["RowSource"],
    );

    Map<String, dynamic> toJson() => {
        "Itemcode": itemcode,
        "Description": description,
        "Quantity": quantity,
        "RefSlNo": refSlNo,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1?.toIso8601String(),
        "Refdate2": refdate2?.toIso8601String(),
        "Locationid": locationid,
        "Jobid": jobid,
        "Costcategoryid": costcategoryid,
        "Unitprice": unitprice,
        "UnitID": unitId,
        "Remarks": remarks,
        "Rowindex": rowindex,
        "JobSubCategoryid": jobSubCategoryid,
        "JobCategoryid": jobCategoryid,
        "SpecificationID": specificationId,
        "Taxoption": taxoption,
        "TaxGroupID": taxGroupId,
        "Styleid": styleid,
        "Itemtype": itemtype,
        "IsNew": isNew,
        "Cost": cost,
        "Amount": amount,
        "RowSource": rowSource,
    };
}

class ProductLotReceivingDetail {
    String? token;
    String? sysdocid;
    String? voucherid;
    String? productId;
    String? unitId;
    String? locationId;
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
    String? rackId;
    dynamic lotQty;
    DateTime? expiryDate;
    dynamic refSlNo;
    String? refext1;
    String? reftext2;
    String? reftext3;
    String? reftext4;
    String? reftext5;
    dynamic refNum1;
    dynamic refNum2;
    DateTime? refDate1;
    DateTime? refDate2;

    ProductLotReceivingDetail({
        this.token,
        this.sysdocid,
        this.voucherid,
        this.productId,
        this.unitId,
        this.locationId,
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
        this.rackId,
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

    factory ProductLotReceivingDetail.fromJson(Map<String, dynamic> json) => ProductLotReceivingDetail(
        token: json["token"],
        sysdocid: json["Sysdocid"],
        voucherid: json["Voucherid"],
        productId: json["ProductID"],
        unitId: json["UnitID"],
        locationId: json["LocationId"],
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
        rackId: json["RackID"],
        lotQty: json["LotQty"],
        expiryDate: json["ExpiryDate"] == null ? null : DateTime.parse(json["ExpiryDate"]),
        refSlNo: json["RefSlNo"],
        refext1: json["Refext1"],
        reftext2: json["Reftext2"],
        reftext3: json["Reftext3"],
        reftext4: json["Reftext4"],
        reftext5: json["Reftext5"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refDate1: json["RefDate1"] == null ? null : DateTime.parse(json["RefDate1"]),
        refDate2: json["RefDate2"] == null ? null : DateTime.parse(json["RefDate2"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "Sysdocid": sysdocid,
        "Voucherid": voucherid,
        "ProductID": productId,
        "UnitID": unitId,
        "LocationId": locationId,
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
        "RackID": rackId,
        "LotQty": lotQty,
        "ExpiryDate": expiryDate?.toIso8601String(),
        "RefSlNo": refSlNo,
        "Refext1": refext1,
        "Reftext2": reftext2,
        "Reftext3": reftext3,
        "Reftext4": reftext4,
        "Reftext5": reftext5,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefDate1": refDate1?.toIso8601String(),
        "RefDate2": refDate2?.toIso8601String(),
    };
}
