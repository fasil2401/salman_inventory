// To parse this JSON data, do
//
//     final getVendorComboListModel = getVendorComboListModelFromJson(jsonString);

import 'dart:convert';

GetVendorComboListModel getVendorComboListModelFromJson(String str) =>
    GetVendorComboListModel.fromJson(json.decode(str));

String getVendorComboListModelToJson(GetVendorComboListModel data) =>
    json.encode(data.toJson());

class GetVendorComboListModel {
  int? res;
  List<VendorModel>? modelobject;

  GetVendorComboListModel({
    this.res,
    this.modelobject,
  });

  factory GetVendorComboListModel.fromJson(Map<String, dynamic> json) =>
      GetVendorComboListModel(
        res: json["res"],
        modelobject: List<VendorModel>.from(
            json["Modelobject"].map((x) => VendorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "Modelobject":
            List<dynamic>.from(modelobject?.map((x) => x.toJson()) ?? []),
      };
}

class VendorModelImportantNames {
  static const String tableName = "VendorTable";
  static const String code = "code";
  static const String name = "name";
  static const String searchColumn = "searchColumn";
  static const String currencyId = "currencyId";
  static const String parentVendorId = "parentVendorId";
  static const String allowConsignment = "allowConsignment";
  static const String allowOap = "allowOap";
  static const String consignComPercent = "consignComPercent";
  static const String shippingMethodId = "shippingMethodId";
  static const String paymentTermId = "paymentTermId";
  static const String paymentMethodId = "paymentMethodId";
  static const String buyerId = "buyerId";
  static const String primaryAddressId = "primaryAddressId";
  static const String vendorClassId = "vendorClassId";
  static const String taxOption = "taxOption";
  static const String taxGroupId = "taxGroupId";
}

class VendorModel {
  String? code;
  String? name;
  String? searchColumn;
  String? currencyId;
  String? parentVendorId;
  bool? allowConsignment;
  bool? allowOap;
  dynamic consignComPercent;
  dynamic shippingMethodId;
  String? paymentTermId;
  String? paymentMethodId;
  String? buyerId;
  String? primaryAddressId;
  String? vendorClassId;
  int? taxOption;
  String? taxGroupId;

  VendorModel({
    this.code,
    this.name,
    this.searchColumn,
    this.currencyId,
    this.parentVendorId,
    this.allowConsignment,
    this.allowOap,
    this.consignComPercent,
    this.shippingMethodId,
    this.paymentTermId,
    this.paymentMethodId,
    this.buyerId,
    this.primaryAddressId,
    this.vendorClassId,
    this.taxOption,
    this.taxGroupId,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        code: json["Code"],
        name: json["Name"],
        searchColumn: json["SearchColumn"],
        currencyId: json["CurrencyID"],
        parentVendorId: json["ParentVendorID"],
        allowConsignment: json["AllowConsignment"],
        allowOap: json["AllowOAP"],
        consignComPercent: json["ConsignComPercent"],
        shippingMethodId: json["ShippingMethodID"],
        paymentTermId: json["PaymentTermID"],
        paymentMethodId: json["PaymentMethodID"],
        buyerId: json["BuyerID"],
        primaryAddressId: json["PrimaryAddressID"],
        vendorClassId: json["VendorClassID"],
        taxOption: json["TaxOption"],
        taxGroupId: json["TaxGroupID"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "SearchColumn": searchColumn,
        "CurrencyID": currencyId,
        "ParentVendorID": parentVendorId,
        "AllowConsignment": allowConsignment,
        "AllowOAP": allowOap,
        "ConsignComPercent": consignComPercent,
        "ShippingMethodID": shippingMethodId,
        "PaymentTermID": paymentTermId,
        "PaymentMethodID": paymentMethodId,
        "BuyerID": buyerId,
        "PrimaryAddressID": primaryAddressId,
        "VendorClassID": vendorClassId,
        "TaxOption": taxOption,
        "TaxGroupID": taxGroupId,
      };
  VendorModel.fromMap(Map<String, dynamic> map) {
    code = map[VendorModelImportantNames.code];
    name = map[VendorModelImportantNames.name];
    searchColumn = map[VendorModelImportantNames.searchColumn];
    currencyId = map[VendorModelImportantNames.currencyId];
    parentVendorId = map[VendorModelImportantNames.parentVendorId];
    allowConsignment = map[VendorModelImportantNames.allowConsignment] == null
        ? map[VendorModelImportantNames.allowConsignment]
        : map[VendorModelImportantNames.allowConsignment] == 1
            ? true
            : false;
    allowOap = map[VendorModelImportantNames.allowOap] == null
        ? map[VendorModelImportantNames.allowOap]
        : map[VendorModelImportantNames.allowOap] == 1
            ? true
            : false;
    consignComPercent = map[VendorModelImportantNames.consignComPercent];
    shippingMethodId = map[VendorModelImportantNames.shippingMethodId];
    paymentTermId = map[VendorModelImportantNames.paymentTermId];
    paymentMethodId = map[VendorModelImportantNames.paymentMethodId];
    buyerId = map[VendorModelImportantNames.buyerId];
    primaryAddressId = map[VendorModelImportantNames.primaryAddressId];
    vendorClassId = map[VendorModelImportantNames.vendorClassId];
    taxOption = map[VendorModelImportantNames.taxOption];
    taxGroupId = map[VendorModelImportantNames.taxGroupId];
  }
  Map<String, dynamic> toMap() {
    return {
      VendorModelImportantNames.code: code,
      VendorModelImportantNames.name: name,
      VendorModelImportantNames.searchColumn: searchColumn,
      VendorModelImportantNames.currencyId: currencyId,
      VendorModelImportantNames.parentVendorId: parentVendorId,
      VendorModelImportantNames.allowConsignment: allowConsignment == null
          ? allowConsignment
          : allowConsignment == true
              ? 1
              : 0,
      VendorModelImportantNames.allowOap: allowOap == null
          ? allowOap
          : allowOap == true
              ? 1
              : 0,
      VendorModelImportantNames.consignComPercent: consignComPercent,
      VendorModelImportantNames.shippingMethodId: shippingMethodId,
      VendorModelImportantNames.paymentTermId: paymentTermId,
      VendorModelImportantNames.paymentMethodId: paymentMethodId,
      VendorModelImportantNames.buyerId: buyerId,
      VendorModelImportantNames.primaryAddressId: primaryAddressId,
      VendorModelImportantNames.vendorClassId: vendorClassId,
      VendorModelImportantNames.taxOption: taxOption,
      VendorModelImportantNames.taxGroupId: taxGroupId,
    };
  }
}
