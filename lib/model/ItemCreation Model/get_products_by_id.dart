// To parse this JSON data, do
//
//     final getProductByIdModel = getProductByIdModelFromJson(jsonString);

import 'dart:convert';

GetProductByIdModel getProductByIdModelFromJson(String str) => GetProductByIdModel.fromJson(json.decode(str));

String getProductByIdModelToJson(GetProductByIdModel data) => json.encode(data.toJson());

class GetProductByIdModel {
    int? res;
    List<ProductById>? model;

    GetProductByIdModel({
        this.res,
        this.model,
    });

    factory GetProductByIdModel.fromJson(Map<String, dynamic> json) => GetProductByIdModel(
        res: json["res"],
        model: json["model"] == null ? [] : List<ProductById>.from(json["model"]!.map((x) => ProductById.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null ? [] : List<dynamic>.from(model!.map((x) => x.toJson())),
    };
}

class ProductById {
    String? productId;
    String? description;
    dynamic description2;
    dynamic description3;
    String? upc;
    bool? isPriceEmbedded;
    String? classId;
    dynamic vendorRef;
    dynamic matrixParentId;
   dynamic itemType;
   dynamic unitPrice1;
   dynamic unitPrice2;
   dynamic unitPrice3;
   dynamic minPrice;
   dynamic standardCost;
   dynamic lastCost;
   dynamic costMethod;
   dynamic averageCost;
   dynamic priceMask;
   dynamic w3PlRentPrice;
    String? categoryId;
    dynamic attribute1;
    dynamic attribute2;
    dynamic attribute3;
    bool? excludeFromCatalogue;
   dynamic quantityPerUnit;
   dynamic quantity;
   dynamic reorderLevel;
    String? unitId;
    dynamic photo;
    dynamic defaultLocationId;
    dynamic cogsAccount;
    dynamic bomid;
    dynamic assetAccount;
    dynamic expenseCode;
    dynamic incomeAccount;
    String? weight;
   dynamic rewardPercent;
    bool? isRewardEnabled;
    String? styleId;
    bool? isTrackLot;
    dynamic isTrackSerial;
    dynamic attribute;
    dynamic size;
    dynamic volume;
    bool? isTagalong;
    bool? isInactive;
    bool? isHoldSale;
    dynamic preferredVendor;
    String? brandId;
    dynamic divisionId;
    String? manufacturerId;
    String? origin;
    dynamic hsCode;
    dynamic warrantyPeriod;
    dynamic rackBin;
    dynamic note;
    dynamic loyaltyType;
    dynamic userDefined1;
    dynamic userDefined2;
    dynamic userDefined3;
    dynamic userDefined4;
    dynamic externalSource;
    dynamic externalId;
    dynamic materialId;
    dynamic finishingId;
    dynamic colorId;
    dynamic gradeId;
    dynamic standardId;
    dynamic pType1;
    dynamic pType2;
    dynamic pType3;
    dynamic pType4;
    dynamic pType5;
    dynamic pType6;
    dynamic pType7;
    dynamic pType8;
    String? taxOption;
    dynamic taxGroupId;
    dynamic taxIdNumber;
    dynamic isChangeDescription;
   dynamic unitPrice4;
   dynamic unitPrice5;
    String? createdBy;
    DateTime? dateCreated;
    dynamic updatedBy;
    dynamic dateUpdated;
    dynamic fixedTaxAmount;
    dynamic transactionUnitId;
    dynamic parentProductId;
    dynamic flag;
    dynamic hideInPos;
    dynamic reservedQuantity;
    dynamic orderedQuantity;
    dynamic ignoreCostDiffAmount;
    dynamic isTaxable;
    dynamic approvalStatus;
    dynamic verificationStatus;
    dynamic lastCostingDate;
    dynamic isCostingDone;
    dynamic onhandQty;
    dynamic currentAvgCost;
   dynamic lastPurchaseCost;
   dynamic lastPurchaseCostWlc;
   dynamic hasPhoto;
    dynamic msl;
    dynamic mil;

    ProductById({
        this.productId,
        this.description,
        this.description2,
        this.description3,
        this.upc,
        this.isPriceEmbedded,
        this.classId,
        this.vendorRef,
        this.matrixParentId,
        this.itemType,
        this.unitPrice1,
        this.unitPrice2,
        this.unitPrice3,
        this.minPrice,
        this.standardCost,
        this.lastCost,
        this.costMethod,
        this.averageCost,
        this.priceMask,
        this.w3PlRentPrice,
        this.categoryId,
        this.attribute1,
        this.attribute2,
        this.attribute3,
        this.excludeFromCatalogue,
        this.quantityPerUnit,
        this.quantity,
        this.reorderLevel,
        this.unitId,
        this.photo,
        this.defaultLocationId,
        this.cogsAccount,
        this.bomid,
        this.assetAccount,
        this.expenseCode,
        this.incomeAccount,
        this.weight,
        this.rewardPercent,
        this.isRewardEnabled,
        this.styleId,
        this.isTrackLot,
        this.isTrackSerial,
        this.attribute,
        this.size,
        this.volume,
        this.isTagalong,
        this.isInactive,
        this.isHoldSale,
        this.preferredVendor,
        this.brandId,
        this.divisionId,
        this.manufacturerId,
        this.origin,
        this.hsCode,
        this.warrantyPeriod,
        this.rackBin,
        this.note,
        this.loyaltyType,
        this.userDefined1,
        this.userDefined2,
        this.userDefined3,
        this.userDefined4,
        this.externalSource,
        this.externalId,
        this.materialId,
        this.finishingId,
        this.colorId,
        this.gradeId,
        this.standardId,
        this.pType1,
        this.pType2,
        this.pType3,
        this.pType4,
        this.pType5,
        this.pType6,
        this.pType7,
        this.pType8,
        this.taxOption,
        this.taxGroupId,
        this.taxIdNumber,
        this.isChangeDescription,
        this.unitPrice4,
        this.unitPrice5,
        this.createdBy,
        this.dateCreated,
        this.updatedBy,
        this.dateUpdated,
        this.fixedTaxAmount,
        this.transactionUnitId,
        this.parentProductId,
        this.flag,
        this.hideInPos,
        this.reservedQuantity,
        this.orderedQuantity,
        this.ignoreCostDiffAmount,
        this.isTaxable,
        this.approvalStatus,
        this.verificationStatus,
        this.lastCostingDate,
        this.isCostingDone,
        this.onhandQty,
        this.currentAvgCost,
        this.lastPurchaseCost,
        this.lastPurchaseCostWlc,
        this.hasPhoto,
        this.msl,
        this.mil,
    });

    factory ProductById.fromJson(Map<String, dynamic> json) => ProductById(
        productId: json["ProductID"],
        description: json["Description"],
        description2: json["Description2"],
        description3: json["Description3"],
        upc: json["UPC"],
        isPriceEmbedded: json["IsPriceEmbedded"],
        classId: json["ClassID"],
        vendorRef: json["VendorRef"],
        matrixParentId: json["MatrixParentID"],
        itemType: json["ItemType"],
        unitPrice1: json["UnitPrice1"],
        unitPrice2: json["UnitPrice2"],
        unitPrice3: json["UnitPrice3"],
        minPrice: json["MinPrice"],
        standardCost: json["StandardCost"],
        lastCost: json["LastCost"],
        costMethod: json["CostMethod"],
        averageCost: json["AverageCost"],
        priceMask: json["PriceMask"],
        w3PlRentPrice: json["W3PLRentPrice"],
        categoryId: json["CategoryID"],
        attribute1: json["Attribute1"],
        attribute2: json["Attribute2"],
        attribute3: json["Attribute3"],
        excludeFromCatalogue: json["ExcludeFromCatalogue"],
        quantityPerUnit: json["QuantityPerUnit"],
        quantity: json["Quantity"],
        reorderLevel: json["ReorderLevel"],
        unitId: json["UnitID"],
        photo: json["Photo"],
        defaultLocationId: json["DefaultLocationID"],
        cogsAccount: json["COGSAccount"],
        bomid: json["BOMID"],
        assetAccount: json["AssetAccount"],
        expenseCode: json["ExpenseCode"],
        incomeAccount: json["IncomeAccount"],
        weight: json["Weight"],
        rewardPercent: json["RewardPercent"],
        isRewardEnabled: json["IsRewardEnabled"],
        styleId: json["StyleID"],
        isTrackLot: json["IsTrackLot"],
        isTrackSerial: json["IsTrackSerial"],
        attribute: json["Attribute"],
        size: json["Size"],
        volume: json["Volume"],
        isTagalong: json["IsTagalong"],
        isInactive: json["IsInactive"],
        isHoldSale: json["IsHoldSale"],
        preferredVendor: json["PreferredVendor"],
        brandId: json["BrandID"],
        divisionId: json["DivisionID"],
        manufacturerId: json["ManufacturerID"],
        origin: json["Origin"],
        hsCode: json["HSCode"],
        warrantyPeriod: json["WarrantyPeriod"],
        rackBin: json["RackBin"],
        note: json["Note"],
        loyaltyType: json["LoyaltyType"],
        userDefined1: json["UserDefined1"],
        userDefined2: json["UserDefined2"],
        userDefined3: json["UserDefined3"],
        userDefined4: json["UserDefined4"],
        externalSource: json["ExternalSource"],
        externalId: json["ExternalID"],
        materialId: json["MaterialID"],
        finishingId: json["FinishingID"],
        colorId: json["ColorID"],
        gradeId: json["GradeID"],
        standardId: json["StandardID"],
        pType1: json["PType1"],
        pType2: json["PType2"],
        pType3: json["PType3"],
        pType4: json["PType4"],
        pType5: json["PType5"],
        pType6: json["PType6"],
        pType7: json["PType7"],
        pType8: json["PType8"],
        taxOption: json["TaxOption"],
        taxGroupId: json["TaxGroupID"],
        taxIdNumber: json["TaxIDNumber"],
        isChangeDescription: json["IsChangeDescription"],
        unitPrice4: json["UnitPrice4"],
        unitPrice5: json["UnitPrice5"],
        createdBy: json["CreatedBy"],
        dateCreated: json["DateCreated"] == null ? null : DateTime.parse(json["DateCreated"]),
        updatedBy: json["UpdatedBy"],
        dateUpdated: json["DateUpdated"],
        fixedTaxAmount: json["FixedTaxAmount"],
        transactionUnitId: json["TransactionUnitID"],
        parentProductId: json["ParentProductID"],
        flag: json["Flag"],
        hideInPos: json["HideInPOS"],
        reservedQuantity: json["ReservedQuantity"],
        orderedQuantity: json["OrderedQuantity"],
        ignoreCostDiffAmount: json["IgnoreCostDiffAmount"],
        isTaxable: json["IsTaxable"],
        approvalStatus: json["ApprovalStatus"],
        verificationStatus: json["VerificationStatus"],
        lastCostingDate: json["LastCostingDate"],
        isCostingDone: json["IsCostingDone"],
        onhandQty: json["OnhandQty"],
        currentAvgCost: json["CurrentAvgCost"],
        lastPurchaseCost: json["LastPurchaseCost"],
        lastPurchaseCostWlc: json["LastPurchaseCostWLC"],
        hasPhoto: json["HasPhoto"],
        msl: json["MSL"],
        mil: json["MIL"],
    );

    Map<String, dynamic> toJson() => {
        "ProductID": productId,
        "Description": description,
        "Description2": description2,
        "Description3": description3,
        "UPC": upc,
        "IsPriceEmbedded": isPriceEmbedded,
        "ClassID": classId,
        "VendorRef": vendorRef,
        "MatrixParentID": matrixParentId,
        "ItemType": itemType,
        "UnitPrice1": unitPrice1,
        "UnitPrice2": unitPrice2,
        "UnitPrice3": unitPrice3,
        "MinPrice": minPrice,
        "StandardCost": standardCost,
        "LastCost": lastCost,
        "CostMethod": costMethod,
        "AverageCost": averageCost,
        "PriceMask": priceMask,
        "W3PLRentPrice": w3PlRentPrice,
        "CategoryID": categoryId,
        "Attribute1": attribute1,
        "Attribute2": attribute2,
        "Attribute3": attribute3,
        "ExcludeFromCatalogue": excludeFromCatalogue,
        "QuantityPerUnit": quantityPerUnit,
        "Quantity": quantity,
        "ReorderLevel": reorderLevel,
        "UnitID": unitId,
        "Photo": photo,
        "DefaultLocationID": defaultLocationId,
        "COGSAccount": cogsAccount,
        "BOMID": bomid,
        "AssetAccount": assetAccount,
        "ExpenseCode": expenseCode,
        "IncomeAccount": incomeAccount,
        "Weight": weight,
        "RewardPercent": rewardPercent,
        "IsRewardEnabled": isRewardEnabled,
        "StyleID": styleId,
        "IsTrackLot": isTrackLot,
        "IsTrackSerial": isTrackSerial,
        "Attribute": attribute,
        "Size": size,
        "Volume": volume,
        "IsTagalong": isTagalong,
        "IsInactive": isInactive,
        "IsHoldSale": isHoldSale,
        "PreferredVendor": preferredVendor,
        "BrandID": brandId,
        "DivisionID": divisionId,
        "ManufacturerID": manufacturerId,
        "Origin": origin,
        "HSCode": hsCode,
        "WarrantyPeriod": warrantyPeriod,
        "RackBin": rackBin,
        "Note": note,
        "LoyaltyType": loyaltyType,
        "UserDefined1": userDefined1,
        "UserDefined2": userDefined2,
        "UserDefined3": userDefined3,
        "UserDefined4": userDefined4,
        "ExternalSource": externalSource,
        "ExternalID": externalId,
        "MaterialID": materialId,
        "FinishingID": finishingId,
        "ColorID": colorId,
        "GradeID": gradeId,
        "StandardID": standardId,
        "PType1": pType1,
        "PType2": pType2,
        "PType3": pType3,
        "PType4": pType4,
        "PType5": pType5,
        "PType6": pType6,
        "PType7": pType7,
        "PType8": pType8,
        "TaxOption": taxOption,
        "TaxGroupID": taxGroupId,
        "TaxIDNumber": taxIdNumber,
        "IsChangeDescription": isChangeDescription,
        "UnitPrice4": unitPrice4,
        "UnitPrice5": unitPrice5,
        "CreatedBy": createdBy,
        "DateCreated": dateCreated?.toIso8601String(),
        "UpdatedBy": updatedBy,
        "DateUpdated": dateUpdated,
        "FixedTaxAmount": fixedTaxAmount,
        "TransactionUnitID": transactionUnitId,
        "ParentProductID": parentProductId,
        "Flag": flag,
        "HideInPOS": hideInPos,
        "ReservedQuantity": reservedQuantity,
        "OrderedQuantity": orderedQuantity,
        "IgnoreCostDiffAmount": ignoreCostDiffAmount,
        "IsTaxable": isTaxable,
        "ApprovalStatus": approvalStatus,
        "VerificationStatus": verificationStatus,
        "LastCostingDate": lastCostingDate,
        "IsCostingDone": isCostingDone,
        "OnhandQty": onhandQty,
        "CurrentAvgCost": currentAvgCost,
        "LastPurchaseCost": lastPurchaseCost,
        "LastPurchaseCostWLC": lastPurchaseCostWlc,
        "HasPhoto": hasPhoto,
        "MSL": msl,
        "MIL": mil,
    };
}
