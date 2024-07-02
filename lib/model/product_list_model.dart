import 'dart:convert';

ProductList productListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    required this.res,
    required this.productlistModel,
    required this.unitmodel,
    required this.productlocationmodel,
    required this.msg,
  });

  int res;
  List<ProductListModel> productlistModel;
  List<Unitmodel> unitmodel;
  List<Productlocationmodel> productlocationmodel;
  String msg;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        res: json["res"],
        productlistModel: List<ProductListModel>.from(
            json["model"].map((x) => ProductListModel.fromJson(x))),
        unitmodel: List<Unitmodel>.from(
            json["unitmodel"].map((x) => Unitmodel.fromJson(x))),
        productlocationmodel: List<Productlocationmodel>.from(
            json["productlocationmodel"]
                .map((x) => Productlocationmodel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": List<dynamic>.from(productlistModel.map((x) => x.toJson())),
        "unitmodel": List<dynamic>.from(unitmodel.map((x) => x.toJson())),
        "productlocationmodel":
            List<dynamic>.from(productlocationmodel.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ProductListModel {
  ProductListModel({
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
    this.isHold,
    this.isInactive,
  });

  String? taxOption;
  String? origin;
  String? productId;
  String? productimage;
  int? isTrackLot;
  String? upc;
  String? unitId;
  String? taxGroupId;
  String? locationId;
  dynamic quantity;
  dynamic specialPrice;
  dynamic price1;
  dynamic price2;
  String? size;
  String? rackBin;
  String? description;
  dynamic reorderLevel;
  dynamic minPrice;
  String? category;
  String? style;
  String? modelClass;
  String? brand;
  String? age;
  String? manufacturer;
  int? isHold;
  int? isInactive;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        taxOption: json["TaxOption"],
        origin: json["Origin"],
        productId: json["ProductID"],
        productimage: json["productimage"],
        isTrackLot: json["IsTrackLot"] == true ? 1 : 0,
        upc: json["UPC"],
        unitId: json["UnitID"] == null ? null : json["UnitID"],
        taxGroupId: json["TaxGroupID"] == null ? null : json["TaxGroupID"],
        locationId: json["LocationID"],
        quantity: json["Quantity"],
        specialPrice: json["SpecialPrice"],
        price1: json["Price1"],
        price2: json["Price2"],
        size: json["Size"],
        rackBin: json["RackBin"],
        description: json["Description"],
        reorderLevel: json["ReorderLevel"],
        minPrice: json["MinPrice"],
        category: json["Category"] == null ? null : json["Category"],
        style: json["Style"] == null ? null : json["Style"],
        modelClass: json["Class"] == null ? null : json["Class"],
        brand: json["Brand"] == null ? null : json["Brand"],
        age: json["Age"],
        manufacturer:
            json["Manufacturer"] == null ? null : json["Manufacturer"],
      );

  Map<String, dynamic> toJson() => {
        "TaxOption": taxOption,
        "Origin": origin,
        "ProductID": productId,
        "productimage": productimage,
        "IsTrackLot": isTrackLot,
        "UPC": upc,
        "UnitID": unitId == null ? null : unitId,
        "TaxGroupID": taxGroupId == null ? null : taxGroupId,
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
        "Category": category == null ? null : category,
        "Style": style == null ? null : style,
        "Class": modelClass == null ? null : modelClass,
        "Brand": brand == null ? null : brand,
        "Age": age,
        "Manufacturer": manufacturer == null ? null : manufacturer,
      };
  Map<String, dynamic> toMap() {
    return {
      ProductListModelName.taxOption: taxOption,
      ProductListModelName.origin: origin,
      ProductListModelName.productId: productId,
      ProductListModelName.productimage: productimage,
      ProductListModelName.isTrackLot: isTrackLot,
      ProductListModelName.upc: upc,
      ProductListModelName.unitId: unitId,
      ProductListModelName.taxGroupId: taxGroupId,
      ProductListModelName.locationId: locationId,
      ProductListModelName.quantity: quantity,
      ProductListModelName.specialPrice: specialPrice,
      ProductListModelName.price1: price1,
      ProductListModelName.price2: price2,
      ProductListModelName.size: size,
      ProductListModelName.rackBin: rackBin,
      ProductListModelName.description: description,
      ProductListModelName.reorderLevel: reorderLevel,
      ProductListModelName.minPrice: minPrice,
      ProductListModelName.category: category,
      ProductListModelName.style: style,
      ProductListModelName.modelClass: modelClass,
      ProductListModelName.brand: brand,
      ProductListModelName.age: age,
      ProductListModelName.manufacturer: manufacturer,
      ProductListModelName.isHold: isHold,
      ProductListModelName.isInactive: isInactive,
    };
  }

  ProductListModel.fromMap(Map<String, dynamic> map) {
    taxOption = map[ProductListModelName.taxOption];
    origin = map[ProductListModelName.origin];
    productId = map[ProductListModelName.productId];
    productimage = map[ProductListModelName.productimage];
    isTrackLot = map[ProductListModelName.isTrackLot];
    upc = map[ProductListModelName.upc];
    unitId = map[ProductListModelName.unitId];
    taxGroupId = map[ProductListModelName.taxGroupId];
    locationId = map[ProductListModelName.locationId];
    quantity = map[ProductListModelName.quantity];
    specialPrice = map[ProductListModelName.specialPrice];
    price1 = map[ProductListModelName.price1];
    price2 = map[ProductListModelName.price2];
    size = map[ProductListModelName.size];
    rackBin = map[ProductListModelName.rackBin];
    description = map[ProductListModelName.description];
    reorderLevel = map[ProductListModelName.reorderLevel];
    minPrice = map[ProductListModelName.minPrice];
    category = map[ProductListModelName.category];
    style = map[ProductListModelName.style];
    modelClass = map[ProductListModelName.modelClass];
    brand = map[ProductListModelName.brand];
    age = map[ProductListModelName.age];
    manufacturer = map[ProductListModelName.manufacturer];
    isHold = map[ProductListModelName.isHold];
    isInactive = map[ProductListModelName.isInactive];
  }
}

class ProductListModelName {
  static const String taxOption = "taxOption";
  static const String origin = "origin";
  static const String productId = "productId";
  static const String productimage = "productimage";
  static const String isTrackLot = "isTrackLot";
  static const String upc = "upc";
  static const String unitId = "unitId";
  static const String taxGroupId = "taxGroupId";
  static const String locationId = "locationId";
  static const String quantity = "quantity";
  static const String specialPrice = "specialPrice";
  static const String price1 = "price1";
  static const String price2 = "price2";
  static const String size = "size";
  static const String rackBin = "rackBin";
  static const String description = "description";
  static const String reorderLevel = "reorderLevel";
  static const String minPrice = "minPrice";
  static const String category = "category";
  static const String style = "style";
  static const String modelClass = "modelClass";
  static const String brand = "brand";
  static const String age = "age";
  static const String manufacturer = "manufacturer";
  static const String isHold = "isHold";
  static const String isInactive = "isInactive";
  static const String tableName = "productList";
}

class Productlocationmodel {
  Productlocationmodel({
    this.locationId,
    this.productId,
    this.quantity,
    this.locationName,
  });

  String? locationId;
  String? productId;
  dynamic quantity;
  String? locationName;

  factory Productlocationmodel.fromJson(Map<String, dynamic> json) =>
      Productlocationmodel(
        locationId: json["LocationID"],
        productId: json["ProductID"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "LocationID": locationId,
        "ProductID": productId,
        "Quantity": quantity,
      };
  Map<String, dynamic> toMap() {
    return {
      ProductlocationmodelName.locationId: locationId,
      ProductlocationmodelName.productId: productId,
      ProductlocationmodelName.quantity: quantity,
      'locationName': locationName,
    };
  }

  Productlocationmodel.fromMap(Map<String, dynamic> map) {
    locationId = map[ProductlocationmodelName.locationId];
    productId = map[ProductlocationmodelName.productId];
    quantity = map[ProductlocationmodelName.quantity];
    locationName = map['locationName'];
  }
}

class ProductlocationmodelName {
  static const String tableName = 'product_location';
  static const String productId = 'productId';
  static const String locationId = 'locationId';
  static const String quantity = 'quantity';
}

class Unitmodel {
  Unitmodel({
    this.code,
    this.name,
    this.productId,
    this.factorType,
    this.factor,
    this.isMainUnit,
  });

  String? code;
  String? name;
  String? productId;
  String? factorType;
  String? factor;
  bool? isMainUnit;

  factory Unitmodel.fromJson(Map<String?, dynamic> json) => Unitmodel(
        code: json["Code"],
        name: json["Name"],
        productId: json["ProductID"],
        factorType: json["FactorType"],
        factor: json["Factor"],
        isMainUnit: json["IsMainUnit"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "ProductID": productId,
        "FactorType": factorType,
        "Factor": factor,
        "IsMainUnit": isMainUnit,
      };
  Map<String, dynamic> toMap() {
    return {
      UnitmodelName.code: code,
      UnitmodelName.name: name,
      UnitmodelName.productId: productId,
      UnitmodelName.factorType: factorType,
      UnitmodelName.factor: factor,
      UnitmodelName.isMainUnit: isMainUnit,
    };
  }

  Unitmodel.fromMap(Map<String, dynamic> map) {
    code = map[UnitmodelName.code];
    name = map[UnitmodelName.name];
    productId = map[UnitmodelName.productId];
    factorType = map[UnitmodelName.factorType];
    factor = map[UnitmodelName.factor];
    isMainUnit = map[UnitmodelName.isMainUnit] == 1 ? true : false;
    ;
  }
}

class UnitmodelName {
  static const String code = "code";
  static const String name = "name";
  static const String productId = "productId";
  static const String factorType = "factorType";
  static const String factor = "factor";
  static const String isMainUnit = "isMainUnit";
  static const String tableName = "unitList";
}
