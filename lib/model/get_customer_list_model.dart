// To parse this JSON data, do
//
//     final getCustomerListModel = getCustomerListModelFromJson(jsonString);

import 'dart:convert';

GetCustomerListModel getCustomerListModelFromJson(String str) =>
    GetCustomerListModel.fromJson(json.decode(str));

String getCustomerListModelToJson(GetCustomerListModel data) =>
    json.encode(data.toJson());

class GetCustomerListModel {
  int? result;
  List<CustomerModel>? modelobject;

  GetCustomerListModel({
    this.result,
    this.modelobject,
  });

  factory GetCustomerListModel.fromJson(Map<String, dynamic> json) =>
      GetCustomerListModel(
        result: json["result"],
        modelobject: List<CustomerModel>.from(
            json["Modelobject"].map((x) => CustomerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "Modelobject":
            List<dynamic>.from(modelobject?.map((x) => x.toJson()) ?? []),
      };
}

class CustomerListImportantNames {
  static const String tableName = 'Customertable';
  static const String code = 'code';
  static const String name = 'name';
  static const String searchColumn = 'searchColumn';
  static const String currencyId = 'currencyId';
  static const String allowConsignment = 'allowConsignment';
  static const String isHold = 'isHold';
  static const String priceLevelId = 'priceLevelId';
  static const String balance = 'balance';
  static const String parentCustomerId = 'parentCustomerId';
  static const String paymentTermId = 'paymentTermId';
  static const String paymentMethodId = 'paymentMethodId';
  static const String shippingMethodId = 'shippingMethodId';
  static const String billToAddressId = 'billToAddressId';
  static const String shipToAddressId = 'shipToAddressId';
  static const String salesPersonId = 'salesPersonId';
  static const String isWeightInvoice = 'isWeightInvoice';
  static const String customerClassId = 'customerClassId';
  static const String taxOption = 'taxOption';
  static const String taxGroupId = 'taxGroupId';
  static const String childCustomers = 'childCustomers';
  static const String isLpo = 'isLpo';
  static const String isPro = 'isPro';
  static const String mobile = 'mobile';
}

class CustomerModel {
  String? code;
  String? name;
  String? searchColumn;
  String? currencyId;
  bool? allowConsignment;
  bool? isHold;
  String? priceLevelId;
  dynamic balance;
  String? parentCustomerId;
  dynamic paymentTermId;
  dynamic paymentMethodId;
  dynamic shippingMethodId;
  dynamic billToAddressId;
  dynamic shipToAddressId;
  String? salesPersonId;
  bool? isWeightInvoice;
  String? customerClassId;
  dynamic taxOption;
  String? taxGroupId;
  dynamic childCustomers;
  bool? isLpo;
  bool? isPro;
  String? mobile;

  CustomerModel({
    this.code,
    this.name,
    this.searchColumn,
    this.currencyId,
    this.allowConsignment,
    this.isHold,
    this.priceLevelId,
    this.balance,
    this.parentCustomerId,
    this.paymentTermId,
    this.paymentMethodId,
    this.shippingMethodId,
    this.billToAddressId,
    this.shipToAddressId,
    this.salesPersonId,
    this.isWeightInvoice,
    this.customerClassId,
    this.taxOption,
    this.taxGroupId,
    this.childCustomers,
    this.isLpo,
    this.isPro,
    this.mobile,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        code: json["Code"],
        name: json["Name"],
        searchColumn: json["SearchColumn"],
        currencyId: json["CurrencyID"],
        allowConsignment: json["AllowConsignment"],
        isHold: json["IsHold"],
        priceLevelId: json["PriceLevelID"],
        balance: json["Balance"],
        parentCustomerId: json["ParentCustomerID"],
        paymentTermId: json["PaymentTermID"],
        paymentMethodId: json["PaymentMethodID"],
        shippingMethodId: json["ShippingMethodID"],
        billToAddressId: json["BillToAddressID"],
        shipToAddressId: json["ShipToAddressID"],
        salesPersonId: json["SalesPersonID"],
        isWeightInvoice: json["IsWeightInvoice"],
        customerClassId: json["CustomerClassID"],
        taxOption: json["TaxOption"],
        taxGroupId: json["TaxGroupID"],
        childCustomers: json["ChildCustomers"],
        isLpo: json["IsLPO"],
        isPro: json["IsPRO"],
        mobile: json["Mobile"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "SearchColumn": searchColumn,
        "CurrencyID": currencyId,
        "AllowConsignment": allowConsignment,
        "IsHold": isHold,
        "PriceLevelID": priceLevelId,
        "Balance": balance,
        "ParentCustomerID": parentCustomerId,
        "PaymentTermID": paymentTermId,
        "PaymentMethodID": paymentMethodId,
        "ShippingMethodID": shippingMethodId,
        "BillToAddressID": billToAddressId,
        "ShipToAddressID": shipToAddressId,
        "SalesPersonID": salesPersonId,
        "IsWeightInvoice": isWeightInvoice,
        "CustomerClassID": customerClassId,
        "TaxOption": taxOption,
        "TaxGroupID": taxGroupId,
        "ChildCustomers": childCustomers,
        "IsLPO": isLpo,
        "IsPRO": isPro,
        "Mobile": mobile,
      };
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      code: map[CustomerListImportantNames.code],
      name: map[CustomerListImportantNames.name],
      searchColumn: map[CustomerListImportantNames.searchColumn],
      currencyId: map[CustomerListImportantNames.currencyId],
      allowConsignment: map[CustomerListImportantNames.allowConsignment] == null
          ? map[CustomerListImportantNames.allowConsignment]
          : map[CustomerListImportantNames.allowConsignment] == 1
              ? true
              : false,
      isHold: map[CustomerListImportantNames.isHold] == null
          ? map[CustomerListImportantNames.isHold]
          : map[CustomerListImportantNames.isHold] == 1
              ? true
              : false,
      priceLevelId: map[CustomerListImportantNames.priceLevelId],
      balance: map[CustomerListImportantNames.balance],
      parentCustomerId: map[CustomerListImportantNames.parentCustomerId],
      paymentTermId: map[CustomerListImportantNames.paymentTermId],
      paymentMethodId: map[CustomerListImportantNames.paymentMethodId],
      shippingMethodId: map[CustomerListImportantNames.shippingMethodId],
      billToAddressId: map[CustomerListImportantNames.billToAddressId],
      shipToAddressId: map[CustomerListImportantNames.shipToAddressId],
      salesPersonId: map[CustomerListImportantNames.salesPersonId],
      isWeightInvoice: map[CustomerListImportantNames.isWeightInvoice] == null
          ? map[CustomerListImportantNames.isWeightInvoice]
          : map[CustomerListImportantNames.isWeightInvoice] == 1
              ? true
              : false,
      customerClassId: map[CustomerListImportantNames.customerClassId],
      taxOption: map[CustomerListImportantNames.taxOption],
      taxGroupId: map[CustomerListImportantNames.taxGroupId],
      childCustomers: map[CustomerListImportantNames.childCustomers],
      isLpo: map[CustomerListImportantNames.isLpo] == null
          ? map[CustomerListImportantNames.isLpo]
          : map[CustomerListImportantNames.isLpo] == 1
              ? true
              : false,
      isPro: map[CustomerListImportantNames.isPro] == null
          ? map[CustomerListImportantNames.isPro]
          : map[CustomerListImportantNames.isPro] == 1
              ? true
              : false,
      mobile: map[CustomerListImportantNames.mobile],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      CustomerListImportantNames.code: code,
      CustomerListImportantNames.name: name,
      CustomerListImportantNames.searchColumn: searchColumn,
      CustomerListImportantNames.currencyId: currencyId,
      CustomerListImportantNames.allowConsignment: allowConsignment == null
          ? allowConsignment
          : allowConsignment == true
              ? 1
              : 0,
      CustomerListImportantNames.isHold: isHold == null
          ? isHold
          : isHold == true
              ? 1
              : 0,
      CustomerListImportantNames.priceLevelId: priceLevelId,
      CustomerListImportantNames.balance: balance,
      CustomerListImportantNames.parentCustomerId: parentCustomerId,
      CustomerListImportantNames.paymentTermId: paymentTermId,
      CustomerListImportantNames.paymentMethodId: paymentMethodId,
      CustomerListImportantNames.shippingMethodId: shippingMethodId,
      CustomerListImportantNames.billToAddressId: billToAddressId,
      CustomerListImportantNames.shipToAddressId: shipToAddressId,
      CustomerListImportantNames.salesPersonId: salesPersonId,
      CustomerListImportantNames.isWeightInvoice: isWeightInvoice == null
          ? isWeightInvoice
          : isWeightInvoice == true
              ? 1
              : 0,
      CustomerListImportantNames.customerClassId: customerClassId,
      CustomerListImportantNames.taxOption: taxOption,
      CustomerListImportantNames.taxGroupId: taxGroupId,
      CustomerListImportantNames.childCustomers: childCustomers,
      CustomerListImportantNames.isLpo: isLpo == null
          ? isLpo
          : isLpo == true
              ? 1
              : 0,
      CustomerListImportantNames.isPro: isPro == null
          ? isPro
          : isPro == true
              ? 1
              : 0,
      CustomerListImportantNames.mobile: mobile,
    };
  }
}
