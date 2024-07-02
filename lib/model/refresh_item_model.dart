// To parse this JSON data, do
//
//     final refreshItemListModel = refreshItemListModelFromJson(jsonString);

import 'dart:convert';

import 'package:axolon_inventory_manager/model/product_list_model.dart';


RefreshItemListModel refreshItemListModelFromJson(String str) =>
    RefreshItemListModel.fromJson(json.decode(str));

String refreshItemListModelToJson(RefreshItemListModel data) =>
    json.encode(data.toJson());

class RefreshItemListModel {
  int? res;
  List<RefreshModel>? model;
  List<Unitmodel>? unitmodel;
  List<Productlocationmodel>? productlocationmodel;
  dynamic locationpricelist;
  String? msg;

  RefreshItemListModel({
    this.res,
    this.model,
    this.unitmodel,
    this.productlocationmodel,
    this.locationpricelist,
    this.msg,
  });

  factory RefreshItemListModel.fromJson(Map<String, dynamic> json) =>
      RefreshItemListModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<RefreshModel>.from(
                json["model"]!.map((x) => RefreshModel.fromJson(x))),
        unitmodel: json["unitmodel"] == null
            ? []
            : List<Unitmodel>.from(
                json["unitmodel"]!.map((x) => Unitmodel.fromJson(x))),
        productlocationmodel: json["productlocationmodel"] == null
            ? []
            : List<Productlocationmodel>.from(
                json["productlocationmodel"]!
                    .map((x) => Productlocationmodel.fromJson(x))),
        locationpricelist: json["locationpricelist"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null
            ? []
            : List<dynamic>.from(model!.map((x) => x.toJson())),
        "unitmodel": unitmodel == null
            ? []
            : List<dynamic>.from(unitmodel!.map((x) => x.toJson())),
        "productlocationmodel": productlocationmodel == null
            ? []
            : List<dynamic>.from(productlocationmodel!.map((x) => x.toJson())),
        "locationpricelist": locationpricelist,
        "msg": msg,
      };
}

class RefreshModel {
  int? taxOption;
  String? origin;
  String? productId;
  String? productimage;
  bool? isTrackLot;
  String? upc;
  String? unitId;
  String? taxGroupId;
  String? locationId;
  double? quantity;
  double? specialPrice;
  double? price1;
  double? price2;
  String? size;
  String? rackBin;
  String? description;
  double? reorderLevel;
  double? minPrice;
  String? category;
  String? style;
  String? modelClass;
  String? brand;
  dynamic age;
  String? manufacturer;
  int? itemType;
  String? categoryId;

  RefreshModel({
    this.taxOption,
    this.origin,
    this.productId,
    this.productimage,
    this.isTrackLot,
    this.upc,
    this.unitId,
    this.taxGroupId,
    this.locationId,
    this.quantity,
    this.specialPrice,
    this.price1,
    this.price2,
    this.size,
    this.rackBin,
    this.description,
    this.reorderLevel,
    this.minPrice,
    this.category,
    this.style,
    this.modelClass,
    this.brand,
    this.age,
    this.manufacturer,
    this.itemType,
    this.categoryId,
  });

  factory RefreshModel.fromJson(Map<String, dynamic> json) => RefreshModel(
        taxOption: json["TaxOption"],
        origin: json["Origin"],
        productId: json["ProductID"],
        productimage: json["productimage"],
        isTrackLot: json["IsTrackLot"],
        upc: json["UPC"],
        unitId: json["UnitID"],
        taxGroupId: json["TaxGroupID"],
        locationId: json["LocationID"],
        quantity: json["Quantity"],
        specialPrice: json["SpecialPrice"]?.toDouble(),
        price1: json["Price1"]?.toDouble(),
        price2: json["Price2"]?.toDouble(),
        size: json["Size"],
        rackBin: json["RackBin"],
        description: json["Description"],
        reorderLevel: json["ReorderLevel"],
        minPrice: json["MinPrice"]?.toDouble(),
        category: json["Category"],
        style: json["Style"],
        modelClass: json["Class"],
        brand: json["Brand"],
        age: json["Age"],
        manufacturer: json["Manufacturer"],
        itemType: json["ItemType"],
        categoryId: json["CategoryID"],
      );

  Map<String, dynamic> toJson() => {
        "TaxOption": taxOption,
        "Origin": origin,
        "ProductID": productId,
        "productimage": productimage,
        "IsTrackLot": isTrackLot,
        "UPC": upc,
        "UnitID": unitId,
        "TaxGroupID": taxGroupId,
        "LocationID": locationId,
        "Quantity": quantity,
        "SpecialPrice": specialPrice,
        "Price1": price1,
        "Price2": price2,
        "Size": size,
        "RackBin": rackBin,
        "Description": description,
        "ReorderLevel": reorderLevel,
        "MinPrice": minPrice,
        "Category": category,
        "Style": style,
        "Class": modelClass,
        "Brand": brand,
        "Age": age,
        "Manufacturer": manufacturer,
        "ItemType": itemType,
        "CategoryID": categoryId,
      };
}



  

