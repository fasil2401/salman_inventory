import 'dart:convert';

GetArrivalReportByIdModel getArrivalReportByIdModelFromJson(String str) => GetArrivalReportByIdModel.fromJson(json.decode(str));

String getArrivalReportByIdModelToJson(GetArrivalReportByIdModel data) => json.encode(data.toJson());

class GetArrivalReportByIdModel {
    GetArrivalReportByIdModel({
        this.result,
        this.header,
        this.detail,
    });

    int? result;
    List<Header>? header;
    List<Detail>? detail;

    factory GetArrivalReportByIdModel.fromJson(Map<String, dynamic> json) => GetArrivalReportByIdModel(
        result: json["result"],
        header: json["Header"] == null ? [] : List<Header>.from(json["Header"]!.map((x) => Header.fromJson(x))),
        detail: json["Detail"] == null ? [] : List<Detail>.from(json["Detail"]!.map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "Header": header == null ? [] : List<dynamic>.from(header!.map((x) => x.toJson())),
        "Detail": detail == null ? [] : List<dynamic>.from(detail!.map((x) => x.toJson())),
    };
}

class Detail {
    Detail({
        this.sysDocId,
        this.voucherId,
        this.rowIndex,
        this.lotNumber,
        this.comodityId,
        this.varietyId,
        this.brandId,
        this.itemSize,
        this.grade,
        this.sampleCount,
        this.issue1Count,
        this.issue2Count,
        this.issue3Count,
        this.issue4Count,
        this.dateCode,
        this.temperature,
        this.standardWeight,
        this.weight,
        this.pressure,
        this.brix,
        this.numericAtr1,
        this.numericAtr2,
        this.numericAtr3,
        this.numericAtr4,
        this.textAtr1,
        this.textAtr2,
        this.textAtr3,
        this.textAtr4,
        this.remarks,
        this.grower,
        this.commodityName,
        this.varietyName,
        this.brandName,
    });

    String? sysDocId;
    String? voucherId;
    dynamic rowIndex;
    String? lotNumber;
    String? comodityId;
    String? varietyId;
    String? brandId;
    String? itemSize;
    String? grade;
    dynamic sampleCount;
    dynamic issue1Count;
    dynamic issue2Count;
    dynamic issue3Count;
    dynamic issue4Count;
    String? dateCode;
    String? temperature;
    dynamic standardWeight;
    dynamic weight;
    dynamic pressure;
    dynamic brix;
    dynamic numericAtr1;
    dynamic numericAtr2;
    dynamic numericAtr3;
    dynamic numericAtr4;
    String? textAtr1;
    String? textAtr2;
    String? textAtr3;
    String? textAtr4;
    String? remarks;
    String? grower;
    String? commodityName;
    String? varietyName;
    String? brandName;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        rowIndex: json["RowIndex"],
        lotNumber: json["LotNumber"],
        comodityId: json["ComodityID"],
        varietyId: json["VarietyID"],
        brandId: json["BrandID"],
        itemSize: json["ItemSize"],
        grade: json["Grade"],
        sampleCount: json["SampleCount"],
        issue1Count: json["Issue1Count"],
        issue2Count: json["Issue2Count"],
        issue3Count: json["Issue3Count"],
        issue4Count: json["Issue4Count"],
        dateCode: json["DateCode"],
        temperature: json["Temperature"],
        standardWeight: json["StandardWeight"],
        weight: json["Weight"],
        pressure: json["Pressure"],
        brix: json["Brix"],
        numericAtr1: json["NumericAtr1"],
        numericAtr2: json["NumericAtr2"],
        numericAtr3: json["NumericAtr3"],
        numericAtr4: json["NumericAtr4"],
        textAtr1: json["TextAtr1"],
        textAtr2: json["TextAtr2"],
        textAtr3: json["TextAtr3"],
        textAtr4: json["TextAtr4"],
        remarks: json["Remarks"],
        grower: json["Grower"],
        commodityName: json["CommodityName"],
        varietyName: json["VarietyName"],
        brandName: json["BrandName"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "RowIndex": rowIndex,
        "LotNumber": lotNumber,
        "ComodityID": comodityId,
        "VarietyID": varietyId,
        "BrandID": brandId,
        "ItemSize": itemSize,
        "Grade": grade,
        "SampleCount": sampleCount,
        "Issue1Count": issue1Count,
        "Issue2Count": issue2Count,
        "Issue3Count": issue3Count,
        "Issue4Count": issue4Count,
        "DateCode": dateCode,
        "Temperature": temperature,
        "StandardWeight": standardWeight,
        "Weight": weight,
        "Pressure": pressure,
        "Brix": brix,
        "NumericAtr1": numericAtr1,
        "NumericAtr2": numericAtr2,
        "NumericAtr3": numericAtr3,
        "NumericAtr4": numericAtr4,
        "TextAtr1": textAtr1,
        "TextAtr2": textAtr2,
        "TextAtr3": textAtr3,
        "TextAtr4": textAtr4,
        "Remarks": remarks,
        "Grower": grower,
        "CommodityName": commodityName,
        "VarietyName": varietyName,
        "BrandName": brandName,
    };
}

class Header {
    Header({
        this.sysDocId,
        this.voucherId,
        this.vendorId,
        this.inspectorId,
        this.containerNumber,
        this.vesselName,
        this.comodities,
        this.sourceSysDocId,
        this.sourceVoucherId,
        this.originId,
        this.taskId,
        this.reference,
        this.reference2,
        this.containerTemp,
        this.totalPallets,
        this.totalQuantity,
        this.dateReceived,
        this.totalIssue1,
        this.totalIssue2,
        this.totalIssue3,
        this.totalIssue4,
        this.issue1Name,
        this.issue2Name,
        this.issue3Name,
        this.issue4Name,
        this.totalWeightLess,
        this.dateInspected,
        this.isConsignment,
        this.note,
        this.locationId,
        this.templateId,
        this.description,
        this.packingCondition,
        this.isPalletized,
        this.conclusion,
        this.resultNote,
        this.rowIndex,
        this.status,
        this.sourceDocType,
        this.vehicleNumber,
        this.isVoid,
        this.approvalStatus,
        this.verificationStatus,
        this.dateCreated,
        this.dateUpdated,
        this.createdBy,
        this.updatedBy,
        this.vendorName,
        this.qualityClaim,
        this.qualityClaimSysDoc,
    });

    String? sysDocId;
    String? voucherId;
    String? vendorId;
    String? inspectorId;
    String? containerNumber;
    String? vesselName;
    dynamic comodities;
    String? sourceSysDocId;
    String? sourceVoucherId;
    String? originId;
    String? taskId;
    String? reference;
    String? reference2;
    dynamic containerTemp;
    dynamic totalPallets;
    dynamic totalQuantity;
    DateTime? dateReceived;
    dynamic totalIssue1;
    dynamic totalIssue2;
    dynamic totalIssue3;
    dynamic totalIssue4;
    String? issue1Name;
    String? issue2Name;
    String? issue3Name;
    String? issue4Name;
    dynamic totalWeightLess;
    DateTime? dateInspected;
    dynamic isConsignment;
    String? note;
    dynamic locationId;
    String? templateId;
    String? description;
    dynamic packingCondition;
    dynamic isPalletized;
    dynamic conclusion;
    dynamic resultNote;
    dynamic rowIndex;
    dynamic status;
    dynamic sourceDocType;
    dynamic vehicleNumber;
    dynamic isVoid;
    dynamic approvalStatus;
    dynamic verificationStatus;
    DateTime? dateCreated;
    dynamic dateUpdated;
    String? createdBy;
    dynamic updatedBy;
    String? vendorName;
    dynamic qualityClaim;
    dynamic qualityClaimSysDoc;

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        sysDocId: json["SysDocID"],
        voucherId: json["VoucherID"],
        vendorId: json["VendorID"],
        inspectorId: json["InspectorID"],
        containerNumber: json["ContainerNumber"],
        vesselName: json["VesselName"],
        comodities: json["Comodities"],
        sourceSysDocId: json["SourceSysDocID"],
        sourceVoucherId: json["SourceVoucherID"],
        originId: json["OriginID"],
        taskId: json["TaskID"],
        reference: json["Reference"],
        reference2: json["Reference2"],
        containerTemp: json["ContainerTemp"],
        totalPallets: json["TotalPallets"],
        totalQuantity: json["TotalQuantity"],
        dateReceived: json["DateReceived"] == null ? null : DateTime.parse(json["DateReceived"]),
        totalIssue1: json["TotalIssue1"],
        totalIssue2: json["TotalIssue2"],
        totalIssue3: json["TotalIssue3"],
        totalIssue4: json["TotalIssue4"],
        issue1Name: json["Issue1Name"],
        issue2Name: json["Issue2Name"],
        issue3Name: json["Issue3Name"],
        issue4Name: json["Issue4Name"],
        totalWeightLess: json["TotalWeightLess"],
        dateInspected: json["DateInspected"] == null ? null : DateTime.parse(json["DateInspected"]),
        isConsignment: json["IsConsignment"],
        note: json["Note"],
        locationId: json["LocationID"],
        templateId: json["TemplateID"],
        description: json["Description"],
        packingCondition: json["PackingCondition"],
        isPalletized: json["IsPalletized"],
        conclusion: json["Conclusion"],
        resultNote: json["ResultNote"],
        rowIndex: json["RowIndex"],
        status: json["Status"],
        sourceDocType: json["SourceDocType"],
        vehicleNumber: json["VehicleNumber"],
        isVoid: json["IsVoid"],
        approvalStatus: json["ApprovalStatus"],
        verificationStatus: json["VerificationStatus"],
        dateCreated: json["DateCreated"] == null ? null : DateTime.parse(json["DateCreated"]),
        dateUpdated: json["DateUpdated"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
        vendorName: json["VendorName"],
        qualityClaim: json["QualityClaim"],
        qualityClaimSysDoc: json["QualityClaimSysDoc"],
    );

    Map<String, dynamic> toJson() => {
        "SysDocID": sysDocId,
        "VoucherID": voucherId,
        "VendorID": vendorId,
        "InspectorID": inspectorId,
        "ContainerNumber": containerNumber,
        "VesselName": vesselName,
        "Comodities": comodities,
        "SourceSysDocID": sourceSysDocId,
        "SourceVoucherID": sourceVoucherId,
        "OriginID": originId,
        "TaskID": taskId,
        "Reference": reference,
        "Reference2": reference2,
        "ContainerTemp": containerTemp,
        "TotalPallets": totalPallets,
        "TotalQuantity": totalQuantity,
        "DateReceived": dateReceived?.toIso8601String(),
        "TotalIssue1": totalIssue1,
        "TotalIssue2": totalIssue2,
        "TotalIssue3": totalIssue3,
        "TotalIssue4": totalIssue4,
        "Issue1Name": issue1Name,
        "Issue2Name": issue2Name,
        "Issue3Name": issue3Name,
        "Issue4Name": issue4Name,
        "TotalWeightLess": totalWeightLess,
        "DateInspected": dateInspected?.toIso8601String(),
        "IsConsignment": isConsignment,
        "Note": note,
        "LocationID": locationId,
        "TemplateID": templateId,
        "Description": description,
        "PackingCondition": packingCondition,
        "IsPalletized": isPalletized,
        "Conclusion": conclusion,
        "ResultNote": resultNote,
        "RowIndex": rowIndex,
        "Status": status,
        "SourceDocType": sourceDocType,
        "VehicleNumber": vehicleNumber,
        "IsVoid": isVoid,
        "ApprovalStatus": approvalStatus,
        "VerificationStatus": verificationStatus,
        "DateCreated": dateCreated?.toIso8601String(),
        "DateUpdated": dateUpdated,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
        "VendorName": vendorName,
        "QualityClaim": qualityClaim,
        "QualityClaimSysDoc": qualityClaimSysDoc,
    };
}
