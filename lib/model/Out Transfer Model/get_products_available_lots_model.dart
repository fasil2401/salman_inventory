// To parse this JSON data, do
//
//     final getProductAvailableLotsmModel = getProductAvailableLotsmModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

GetProductAvailableLotsmModel getProductAvailableLotsmModelFromJson(
        String str) =>
    GetProductAvailableLotsmModel.fromJson(json.decode(str));

String getProductAvailableLotsmModelToJson(
        GetProductAvailableLotsmModel data) =>
    json.encode(data.toJson());

class GetProductAvailableLotsmModel {
  int? res;
  List<ProductAvailableLots>? model;
  String? msg;

  GetProductAvailableLotsmModel({
    this.res,
    this.model,
    this.msg,
  });

  factory GetProductAvailableLotsmModel.fromJson(Map<String, dynamic> json) =>
      GetProductAvailableLotsmModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<ProductAvailableLots>.from(
                json["model"]!.map((x) => ProductAvailableLots.fromJson(x))),
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

class ProductAvailableLots {
  String? productId;
  String? selectUnit;
  dynamic lotNumber;
  String? reference;
  String? reference2;
  dynamic itemType;
  dynamic sourceLotNumber;
  DateTime? productionDate;
  DateTime? expiryDate;
  dynamic lotQty;
  dynamic cost;
  String? binId;
  String? rackId;
  dynamic refText1;
  dynamic refText2;
  dynamic refDate1;
  dynamic refDate2;
  dynamic refText3;
  dynamic refText4;
  dynamic refText5;
  dynamic refNum1;
  dynamic refNum2;
  dynamic refSlNo;
  dynamic holdQty;
  String? consign;
  dynamic curAvailableQty;
  dynamic convFactor;
  dynamic seleFactType;
  bool? isHold;
  dynamic availableQty;
  dynamic acceptedQuantiy;
  TextEditingController? controller;

  ProductAvailableLots({
    this.productId,
    this.selectUnit,
    this.lotNumber,
    this.reference,
    this.reference2,
    this.itemType,
    this.sourceLotNumber,
    this.productionDate,
    this.expiryDate,
    this.lotQty,
    this.cost,
    this.binId,
    this.rackId,
    this.refText1,
    this.refText2,
    this.refDate1,
    this.refDate2,
    this.refText3,
    this.refText4,
    this.refText5,
    this.refNum1,
    this.refNum2,
    this.refSlNo,
    this.holdQty,
    this.consign,
    this.curAvailableQty,
    this.convFactor,
    this.seleFactType,
    this.isHold,
    this.availableQty,
    this.controller,
  });

  factory ProductAvailableLots.fromJson(Map<String, dynamic> json) =>
      ProductAvailableLots(
        selectUnit: json["selectUnit"],
        lotNumber: json["LotNumber"],
        reference: json["Reference"],
        reference2: json["Reference2"],
        itemType: json["ItemType"],
        sourceLotNumber: json["SourceLotNumber"],
        productionDate: json["ProductionDate"] == null
            ? null
            : DateTime.parse(json["ProductionDate"]),
        expiryDate: json["ExpiryDate"] == null
            ? null
            : DateTime.parse(json["ExpiryDate"]),
        lotQty: json["LotQty"],
        cost: json["Cost"],
        binId: json["BinID"],
        rackId: json["RackID"],
        refText1: json["RefText1"],
        refText2: json["RefText2"],
        refDate1: json["RefDate1"],
        refDate2: json["RefDate2"],
        refText3: json["RefText3"],
        refText4: json["RefText4"],
        refText5: json["RefText5"],
        refNum1: json["RefNum1"],
        refNum2: json["RefNum2"],
        refSlNo: json["RefSlNo"],
        holdQty: json["HoldQty"],
        consign: json["Consign#"],
        curAvailableQty: json["CurAvailableQty"],
        convFactor: json["ConvFactor"],
        seleFactType: json["SeleFactType"],
        isHold: json["IsHold"],
        availableQty: json["AvailableQty"],
        controller: TextEditingController(text: '0.00'),
      );

  Map<String, dynamic> toJson() => {
        "selectUnit": selectUnit,
        "LotNumber": lotNumber,
        "Reference": reference,
        "Reference2": reference2,
        "ItemType": itemType,
        "SourceLotNumber": sourceLotNumber,
        "ProductionDate": productionDate?.toIso8601String(),
        "ExpiryDate": expiryDate?.toIso8601String(),
        "LotQty": lotQty,
        "Cost": cost,
        "BinID": binId,
        "RackID": rackId,
        "RefText1": refText1,
        "RefText2": refText2,
        "RefDate1": refDate1,
        "RefDate2": refDate2,
        "RefText3": refText3,
        "RefText4": refText4,
        "RefText5": refText5,
        "RefNum1": refNum1,
        "RefNum2": refNum2,
        "RefSlNo": refSlNo,
        "HoldQty": holdQty,
        "Consign#": consign,
        "CurAvailableQty": curAvailableQty,
        "ConvFactor": convFactor,
        "SeleFactType": seleFactType,
        "IsHold": isHold,
        "AvailableQty": availableQty,
      };
}
