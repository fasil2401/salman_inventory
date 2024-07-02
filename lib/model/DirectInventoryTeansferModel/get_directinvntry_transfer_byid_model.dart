// To parse this JSON data, do
//
//     final getDirectInventoryTransferByIdModel = getDirectInventoryTransferByIdModelFromJson(jsonString);

import 'dart:convert';

GetDirectInventoryTransferByIdModel getDirectInventoryTransferByIdModelFromJson(String str) => GetDirectInventoryTransferByIdModel.fromJson(json.decode(str));

String getDirectInventoryTransferByIdModelToJson(GetDirectInventoryTransferByIdModel data) => json.encode(data.toJson());

class GetDirectInventoryTransferByIdModel {
    int? result;
    List<Header>? header;
    List<Detail>? detail;
    List<LotReceivedetail>? lotReceivedetail;
    List<Transistdetail>? transistdetail;

    GetDirectInventoryTransferByIdModel({
        this.result,
        this.header,
        this.detail,
        this.lotReceivedetail,
        this.transistdetail,
    });

    factory GetDirectInventoryTransferByIdModel.fromJson(Map<String, dynamic> json) => GetDirectInventoryTransferByIdModel(
        result: json["result"],
        header: json["Header"] == null ? [] : List<Header>.from(json["Header"]!.map((x) => Header.fromJson(x))),
        detail: json["Detail"] == null ? [] : List<Detail>.from(json["Detail"]!.map((x) => Detail.fromJson(x))),
        lotReceivedetail: json["LotReceivedetail"] == null ? [] : List<LotReceivedetail>.from(json["LotReceivedetail"]!.map((x) => LotReceivedetail.fromJson(x))),
        transistdetail: json["Transistdetail"] == null ? [] : List<Transistdetail>.from(json["Transistdetail"]!.map((x) => Transistdetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "Header": header == null ? [] : List<dynamic>.from(header!.map((x) => x.toJson())),
        "Detail": detail == null ? [] : List<dynamic>.from(detail!.map((x) => x.toJson())),
        "LotReceivedetail": lotReceivedetail == null ? [] : List<dynamic>.from(lotReceivedetail!.map((x) => x.toJson())),
        "Transistdetail": transistdetail == null ? [] : List<dynamic>.from(transistdetail!.map((x) => x.toJson())),
    };
}

class Detail {
    String? sysDocId;
    String? voucherId;
    String? productId;
    dynamic rowIndex;
    String? unitId;
    dynamic quantity;
    dynamic unitQuantity;
    dynamic factor;
    dynamic factorType;
    bool? isTrackLot;
    dynamic acceptedQuantity;
    dynamic acceptedUnitQuantity;
    dynamic rejectedQuantity;
    dynamic rejectedUnitQuantity;
    dynamic listVoucherId;
    dynamic listSysDocId;
    dynamic listRowIndex;
    String? remarks;
    dynamic price;
    dynamic sourceVoucherId;
    dynamic sourceSysDocId;
    dynamic sourceRowIndex;
    dynamic isSourcedRow;
    dynamic sourceDocType;
    dynamic acceptedFactor;
    dynamic acceptedFactorType;
    dynamic column1;
    dynamic rejectedFactor;
    dynamic rejectedFactorType;
    String? description;
    bool? isTrackSerial;

    Detail({
        this.sysDocId,
        this.voucherId,
        this.productId,
        this.rowIndex,
        this.unitId,
        this.quantity,
        this.unitQuantity,
        this.factor,
        this.factorType,
        this.isTrackLot,
        this.acceptedQuantity,
        this.acceptedUnitQuantity,
        this.rejectedQuantity,
        this.rejectedUnitQuantity,
        this.listVoucherId,
        this.listSysDocId,
        this.listRowIndex,
        this.remarks,
        this.price,
        this.sourceVoucherId,
        this.sourceSysDocId,
        this.sourceRowIndex,
        this.isSourcedRow,
        this.sourceDocType,
        this.acceptedFactor,
        this.acceptedFactorType,
        this.column1,
        this.rejectedFactor,
        this.rejectedFactorType,
        this.description,
        this.isTrackSerial,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        sysDocId: json["SysDocID"],
        voucherId:json["VoucherID"],
        productId: json["ProductID"],
        rowIndex: json["RowIndex"],
        unitId: json["UnitID"],
        quantity: json["Quantity"],
        unitQuantity: json["UnitQuantity"],
        factor: json["Factor"],
        factorType: json["FactorType"],
        isTrackLot: json["IsTrackLot"],
        acceptedQuantity: json["AcceptedQuantity"],
        acceptedUnitQuantity: json["AcceptedUnitQuantity"],
        rejectedQuantity: json["RejectedQuantity"],
        rejectedUnitQuantity: json["RejectedUnitQuantity"],
        listVoucherId: json["ListVoucherID"],
        listSysDocId: json["ListSysDocID"],
        listRowIndex: json["ListRowIndex"],
        remarks: json["Remarks"],
        price: json["Price"],
        sourceVoucherId: json["SourceVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        sourceRowIndex: json["SourceRowIndex"],
        isSourcedRow: json["IsSourcedRow"],
        sourceDocType: json["SourceDocType"],
        acceptedFactor: json["AcceptedFactor"],
        acceptedFactorType: json["AcceptedFactorType"],
        column1: json["Column1"],
        rejectedFactor: json["RejectedFactor"],
        rejectedFactorType: json["RejectedFactorType"],
        description: json["Description"],
        isTrackSerial: json["IsTrackSerial"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "ProductID": productId,
        "RowIndex": rowIndex,
        "UnitID": unitId,
        "Quantity": quantity,
        "UnitQuantity": unitQuantity,
        "Factor": factor,
        "FactorType": factorType,
        "IsTrackLot": isTrackLot,
        "AcceptedQuantity": acceptedQuantity,
        "AcceptedUnitQuantity": acceptedUnitQuantity,
        "RejectedQuantity": rejectedQuantity,
        "RejectedUnitQuantity": rejectedUnitQuantity,
        "ListVoucherID": listVoucherId,
        "ListSysDocID": listSysDocId,
        "ListRowIndex": listRowIndex,
        "Remarks": remarks,
        "Price": price,
        "SourceVoucherID": sourceVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "SourceRowIndex": sourceRowIndex,
        "IsSourcedRow": isSourcedRow,
        "SourceDocType": sourceDocType,
        "AcceptedFactor": acceptedFactor,
        "AcceptedFactorType": acceptedFactorType,
        "Column1": column1,
        "RejectedFactor": rejectedFactor,
        "RejectedFactorType": rejectedFactorType,
        "Description": description,
        "IsTrackSerial": isTrackSerial,
    };
}



class Header {
    String? sysDocId;
    String? voucherId;
    String? companyId;
    String? divisionId;
    DateTime? transactionDate;
    dynamic acceptDate;
    dynamic rejectDate;
    String? reference;
    dynamic acceptReference;
    dynamic acceptVoucherId;
    dynamic rejectAcceptSysDocId;
    dynamic rejectAcceptVoucherId;
    dynamic rejectAcceptNote;
    dynamic rejectAcceptDate;
    dynamic rejectedBy;
    dynamic acceptedBy;
    dynamic rejectAcceptedBy;
    dynamic rejectAcceptReference;
    dynamic transferTypeId;
    String? description;
    String? locationFromId;
    String? locationToId;
    dynamic acceptSysDocId;
    dynamic rejectSysDocId;
    dynamic rejectReference;
    dynamic rejectNote;
    dynamic driverId;
    String? vehicleNumber;
    dynamic isVoid;
    bool? isAccepted;
    dynamic isRejected;
    dynamic transferAccountId;
    dynamic isRejectAccepted;
    dynamic approvalStatus;
    dynamic verificationStatus;
    DateTime? dateCreated;
    dynamic dateUpdated;
    String? createdBy;
    dynamic updatedBy;
    dynamic transitLocationId;

    Header({
        this.sysDocId,
        this.voucherId,
        this.companyId,
        this.divisionId,
        this.transactionDate,
        this.acceptDate,
        this.rejectDate,
        this.reference,
        this.acceptReference,
        this.acceptVoucherId,
        this.rejectAcceptSysDocId,
        this.rejectAcceptVoucherId,
        this.rejectAcceptNote,
        this.rejectAcceptDate,
        this.rejectedBy,
        this.acceptedBy,
        this.rejectAcceptedBy,
        this.rejectAcceptReference,
        this.transferTypeId,
        this.description,
        this.locationFromId,
        this.locationToId,
        this.acceptSysDocId,
        this.rejectSysDocId,
        this.rejectReference,
        this.rejectNote,
        this.driverId,
        this.vehicleNumber,
        this.isVoid,
        this.isAccepted,
        this.isRejected,
        this.transferAccountId,
        this.isRejectAccepted,
        this.approvalStatus,
        this.verificationStatus,
        this.dateCreated,
        this.dateUpdated,
        this.createdBy,
        this.updatedBy,
        this.transitLocationId,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        companyId: json["CompanyID"],
        divisionId: json["DivisionID"],
        transactionDate: json["TransactionDate"] == null ? null : DateTime.parse(json["TransactionDate"]),
        acceptDate: json["AcceptDate"],
        rejectDate: json["RejectDate"],
        reference: json["Reference"],
        acceptReference: json["AcceptReference"],
        acceptVoucherId: json["AcceptVoucherID"],
        rejectAcceptSysDocId: json["RejectAcceptSysDocID"],
        rejectAcceptVoucherId: json["RejectAcceptVoucherID"],
        rejectAcceptNote: json["RejectAcceptNote"],
        rejectAcceptDate: json["RejectAcceptDate"],
        rejectedBy: json["RejectedBy"],
        acceptedBy: json["AcceptedBy"],
        rejectAcceptedBy: json["RejectAcceptedBy"],
        rejectAcceptReference: json["RejectAcceptReference"],
        transferTypeId: json["TransferTypeID"],
        description: json["Description"],
        locationFromId: json["LocationFromID"],
        locationToId: json["LocationToID"],
        acceptSysDocId: json["AcceptSysDocID"],
        rejectSysDocId: json["RejectSysDocID"],
        rejectReference: json["RejectReference"],
        rejectNote: json["RejectNote"],
        driverId: json["DriverID"],
        vehicleNumber: json["VehicleNumber"],
        isVoid: json["IsVoid"],
        isAccepted: json["IsAccepted"],
        isRejected: json["IsRejected"],
        transferAccountId: json["TransferAccountID"],
        isRejectAccepted: json["IsRejectAccepted"],
        approvalStatus: json["ApprovalStatus"],
        verificationStatus: json["VerificationStatus"],
        dateCreated: json["DateCreated"] == null ? null : DateTime.parse(json["DateCreated"]),
        dateUpdated: json["DateUpdated"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
        transitLocationId: json["TransitLocationID"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "CompanyID": companyId,
        "DivisionID": divisionId,
        "TransactionDate": transactionDate?.toIso8601String(),
        "AcceptDate": acceptDate,
        "RejectDate": rejectDate,
        "Reference": reference,
        "AcceptReference": acceptReference,
        "AcceptVoucherID": acceptVoucherId,
        "RejectAcceptSysDocID": rejectAcceptSysDocId,
        "RejectAcceptVoucherID": rejectAcceptVoucherId,
        "RejectAcceptNote": rejectAcceptNote,
        "RejectAcceptDate": rejectAcceptDate,
        "RejectedBy": rejectedBy,
        "AcceptedBy": acceptedBy,
        "RejectAcceptedBy": rejectAcceptedBy,
        "RejectAcceptReference": rejectAcceptReference,
        "TransferTypeID": transferTypeId,
        "Description": description,
        "LocationFromID": locationFromId,
        "LocationToID": locationToId,
        "AcceptSysDocID": acceptSysDocId,
        "RejectSysDocID": rejectSysDocId,
        "RejectReference": rejectReference,
        "RejectNote": rejectNote,
        "DriverID": driverId,
        "VehicleNumber": vehicleNumber,
        "IsVoid": isVoid,
        "IsAccepted": isAccepted,
        "IsRejected": isRejected,
        "TransferAccountID": transferAccountId,
        "IsRejectAccepted": isRejectAccepted,
        "ApprovalStatus": approvalStatus,
        "VerificationStatus": verificationStatus,
        "DateCreated": dateCreated?.toIso8601String(),
        "DateUpdated": dateUpdated,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "TransitLocationID": transitLocationId,
    };
}


class LotReceivedetail {
    String? lotNumber;
    String? sourceLotNumber;
    dynamic reference;
    String? locationId;
    String? binId;
    dynamic rackId;
    String? productId;
    String? sysDocId;
    String? voucherId;
    dynamic rowIndex;
    dynamic lotQty;
    dynamic soldQty;
    dynamic productionDate;
    dynamic expiryDate;
    dynamic receiptDate;
    String? reference2;
    dynamic unitQuantity;
    dynamic factor;
    String? factorType;
    String? unitId;
    dynamic refSlNo;
    dynamic refText1;
    dynamic refText2;
    dynamic refNum1;
    dynamic refNum2;
    dynamic refDate1;
    dynamic refDate2;
    dynamic refText3;
    dynamic refText4;
    dynamic refText5;

    LotReceivedetail({
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

    factory LotReceivedetail.fromJson(Map<String, dynamic> json) => LotReceivedetail(
        lotNumber: json["LotNumber"],
        sourceLotNumber: json["SourceLotNumber"],
        reference: json["Reference"],
        locationId: json["LocationID"],
        binId: json["BinID"],
        rackId: json["RackID"],
        productId: json["ProductID"],
        sysDocId: json["SysDocID"],
        voucherId:json["VoucherID"],
        rowIndex: json["RowIndex"],
        lotQty: json["LotQty"],
        soldQty: json["SoldQty"],
        productionDate: json["ProductionDate"],
        expiryDate: json["ExpiryDate"],
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
        refDate1: json["RefDate1"],
        refDate2: json["RefDate2"],
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
        "SysDocID":sysDocId,
        "VoucherID": voucherId,
        "RowIndex": rowIndex,
        "LotQty": lotQty,
        "SoldQty": soldQty,
        "ProductionDate": productionDate,
        "ExpiryDate": expiryDate,
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
        "RefDate1": refDate1,
        "RefDate2": refDate2,
        "RefText3": refText3,
        "RefText4": refText4,
        "RefText5": refText5,
    };
}

class Transistdetail {
   dynamic lotNumber;
    String? reference;
   dynamic sourceLotNumber;
    String? locationId;
    String? productId;
   dynamic rowIndex;
    dynamic productionDate;
    dynamic expiryDate;
    DateTime? receiptDate;
    String? voucherId;
    String? sysDocId;
   dynamic lotQty;
   dynamic soldQty;

    Transistdetail({
        this.lotNumber,
        this.reference,
        this.sourceLotNumber,
        this.locationId,
        this.productId,
        this.rowIndex,
        this.productionDate,
        this.expiryDate,
        this.receiptDate,
        this.voucherId,
        this.sysDocId,
        this.lotQty,
        this.soldQty,
    });

    factory Transistdetail.fromJson(Map<String, dynamic> json) => Transistdetail(
        lotNumber: json["LotNumber"],
        reference: json["Reference"],
        sourceLotNumber: json["SourceLotNumber"],
        locationId: json["LocationID"],
        productId: json["ProductID"],
        rowIndex: json["RowIndex"],
        productionDate: json["ProductionDate"],
        expiryDate: json["ExpiryDate"],
        receiptDate: json["ReceiptDate"] == null ? null : DateTime.parse(json["ReceiptDate"]),
        voucherId: json["VoucherID"],
        sysDocId: json["SysDocID"],
        lotQty: json["LotQty"],
        soldQty: json["SoldQty"],
    );

    Map<String, dynamic> toJson() => {
        "LotNumber": lotNumber,
        "Reference": reference,
        "SourceLotNumber": sourceLotNumber,
        "LocationID": locationId,
        "ProductID": productId,
        "RowIndex": rowIndex,
        "ProductionDate": productionDate,
        "ExpiryDate": expiryDate,
        "ReceiptDate": receiptDate?.toIso8601String(),
        "VoucherID": voucherId,
        "SysDocID":sysDocId,
        "LotQty": lotQty,
        "SoldQty": soldQty,
    };
}


