class DraftItemListImpNames {
  static const String taxOption = "taxOption";
  static const String origin = "origin";
  static const String productId = "productId";
  static const String productimage = "productImage";
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
  static const String draftOption = "draftOption";
  static const String index = 'rowIndex';
  static const String updatedQuatity = 'updatedQuatity';
  static const String updatedUnitId = 'updatedUnitId';
  static const String remarks = 'remarks';
  static const String sysDocId = 'sysDocId';
  static const String voucherId = 'voucherId';
  static const String headerLocationId = 'headerLocationId';
  static const String headerDescription= 'headerDescription';
  static const String transactionDate ='transactionDate';
  static const String isNewRecord = 'isNewRecord';
  static const String tableName = "draftItemList";
}

class DraftItemListModel {
  String? taxOption;
  String? origin;
  String? productId;
  String? productimage;
  int? isTrackLot;
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
  String? age;
  String? manufacturer;
  int? draftOption;
  int? index;
  double? updatedQuatity;
  String? updatedUnitId;
  String? remarks;
  String? sysDocId;
  String? voucherId;
  String? headerLocationId;
  String? headerDescription;
  String? transactionDate;
  int? isNewRecord;

  DraftItemListModel({
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
    this.draftOption,
    this.index,
    this.updatedUnitId,
    this.updatedQuatity,
    this.remarks,
    this.headerDescription,
    this.headerLocationId,
    this.isNewRecord,
    this.sysDocId,
    this.transactionDate,
    this.voucherId,
  });

  Map<String, dynamic> toMap() {
    return {
      DraftItemListImpNames.taxOption: taxOption,
      DraftItemListImpNames.origin: origin,
      DraftItemListImpNames.productId: productId,
      DraftItemListImpNames.productimage: productimage,
      DraftItemListImpNames.isTrackLot: isTrackLot,
      DraftItemListImpNames.upc: upc,
      DraftItemListImpNames.unitId: unitId,
      DraftItemListImpNames.taxGroupId: taxGroupId,
      DraftItemListImpNames.locationId: locationId,
      DraftItemListImpNames.quantity: quantity,
      DraftItemListImpNames.specialPrice: specialPrice,
      DraftItemListImpNames.price1: price1,
      DraftItemListImpNames.price2: price2,
      DraftItemListImpNames.size: size,
      DraftItemListImpNames.rackBin: rackBin,
      DraftItemListImpNames.description: description,
      DraftItemListImpNames.reorderLevel: reorderLevel,
      DraftItemListImpNames.minPrice: minPrice,
      DraftItemListImpNames.category: category,
      DraftItemListImpNames.style: style,
      DraftItemListImpNames.modelClass: modelClass,
      DraftItemListImpNames.brand: brand,
      DraftItemListImpNames.age: age,
      DraftItemListImpNames.manufacturer: manufacturer,
      DraftItemListImpNames.draftOption: draftOption,
      DraftItemListImpNames.index: index,
      DraftItemListImpNames.updatedUnitId: updatedUnitId,
      DraftItemListImpNames.updatedQuatity: updatedQuatity,
      DraftItemListImpNames.remarks: remarks,
      DraftItemListImpNames.sysDocId: sysDocId,
      DraftItemListImpNames.voucherId: voucherId,
      DraftItemListImpNames.headerDescription: headerDescription,
      DraftItemListImpNames.headerLocationId: headerLocationId,
      DraftItemListImpNames.transactionDate: transactionDate,
      DraftItemListImpNames.isNewRecord: isNewRecord,
    };
  }

  DraftItemListModel.fromMap(Map<String, dynamic> product) {
    taxOption = product[DraftItemListImpNames.taxOption];
    origin = product[DraftItemListImpNames.origin];
    productId = product[DraftItemListImpNames.productId];
    productimage = product[DraftItemListImpNames.productimage];
    isTrackLot = product[DraftItemListImpNames.isTrackLot];
    upc = product[DraftItemListImpNames.upc];
    unitId = product[DraftItemListImpNames.unitId];
    taxGroupId = product[DraftItemListImpNames.taxGroupId];
    locationId = product[DraftItemListImpNames.locationId];
    quantity = product[DraftItemListImpNames.quantity];
    specialPrice = product[DraftItemListImpNames.specialPrice];
    price1 = product[DraftItemListImpNames.price1];
    price2 = product[DraftItemListImpNames.price2];
    size = product[DraftItemListImpNames.size];
    rackBin = product[DraftItemListImpNames.rackBin];
    description = product[DraftItemListImpNames.description];
    reorderLevel = product[DraftItemListImpNames.reorderLevel];
    minPrice = product[DraftItemListImpNames.minPrice];
    category = product[DraftItemListImpNames.category];
    style = product[DraftItemListImpNames.style];
    modelClass = product[DraftItemListImpNames.modelClass];
    brand = product[DraftItemListImpNames.brand];
    age = product[DraftItemListImpNames.age];
    manufacturer = product[DraftItemListImpNames.manufacturer];
    draftOption = product[DraftItemListImpNames.draftOption];
    index = product[DraftItemListImpNames.index];
    updatedUnitId = product[DraftItemListImpNames.updatedUnitId];
    updatedQuatity = product[DraftItemListImpNames.updatedQuatity];
    remarks = product[DraftItemListImpNames.remarks];
    sysDocId = product[DraftItemListImpNames.sysDocId];
    voucherId = product[DraftItemListImpNames.voucherId];
    headerDescription = product[DraftItemListImpNames.headerDescription];
    headerLocationId = product[DraftItemListImpNames.headerLocationId];
    transactionDate = product[DraftItemListImpNames.transactionDate];
    isNewRecord = product[DraftItemListImpNames.isNewRecord];
  }
}
