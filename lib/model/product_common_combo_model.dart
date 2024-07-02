import 'dart:convert';

CommonComboListModel CommonComboFromJson(String str) =>
    CommonComboListModel.fromJson(json.decode(str));

String CommonComboToJson(CommonComboListModel data) =>
    json.encode(data.toJson());

class CommonComboListModel {
  CommonComboListModel({
    required this.res,
    required this.model,
    required this.msg,
  });

  int res;
  List<ProductCommonComboModel> model;
  String msg;

  factory CommonComboListModel.fromJson(Map<String, dynamic> json) =>
      CommonComboListModel(
        res: json["res"] ?? json["result"],
        model: (json["model"] != null)
            ? List<ProductCommonComboModel>.from(
                json["model"].map((x) => ProductCommonComboModel.fromJson(x)))
            : List<ProductCommonComboModel>.from(json["Modelobject"]
                .map((x) => ProductCommonComboModel.fromJson(x))),
        msg: json["msg"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": List<dynamic>.from(model.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ProductCommonComboModel {
  ProductCommonComboModel({
    this.name,
    this.code,
  });

  String? code;
  String? name;

  factory ProductCommonComboModel.fromJson(Map<String, dynamic> json) =>
      ProductCommonComboModel(
        code: json["Code"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
      };
  Map<String, dynamic> toMap() {
    return {
      ProductCommonComboModelName.code: code,
      ProductCommonComboModelName.name: name,
    };
  }

  ProductCommonComboModel.fromMap(Map<String, dynamic> map) {
    code = map[ProductCommonComboModelName.code];
    name = map[ProductCommonComboModelName.name];
  }
}

class ProductCommonComboModelName {
  static const String originTableName = "origintable";
  static const String categoryTableName = "categorytable";
  static const String classTableName = "classtable";
  static const String brandTableName = "brandtable";
  static const String vehicleTableName = "vehicletable";
  static const String driverTableName = "drivertable";
  static const String customerSalesPersonTableName = "customerSalesPersontable";
  static const String code = "code";
  static const String name = "name";
}
