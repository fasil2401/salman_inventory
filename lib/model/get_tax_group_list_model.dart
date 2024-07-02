import 'dart:convert';

GetTaxGroupComboListModel getTaxGroupComboListModelFromJson(String str) =>
    GetTaxGroupComboListModel.fromJson(json.decode(str));

String getTaxGroupComboListModelToJson(GetTaxGroupComboListModel data) =>
    json.encode(data.toJson());

class GetTaxGroupComboListModel {
  int? res;
  List<TaxGroupComboModel>? model;

  GetTaxGroupComboListModel({
    this.res,
    this.model,
  });

  factory GetTaxGroupComboListModel.fromJson(Map<String, dynamic> json) =>
      GetTaxGroupComboListModel(
        res: json["res"],
        model: json["model"] == null
            ? []
            : List<TaxGroupComboModel>.from(
                json["model"]!.map((x) => TaxGroupComboModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "model": model == null
            ? []
            : List<dynamic>.from(model!.map((x) => x.toJson())),
      };
}

class TaxGroupComboModel {
  String? code;
  String? name;
  int? taxRate;

  TaxGroupComboModel({
    this.code,
    this.name,
    this.taxRate,
  });

  factory TaxGroupComboModel.fromJson(Map<String, dynamic> json) =>
      TaxGroupComboModel(
        code: json["Code"],
        name: json["Name"],
        taxRate: json["TaxRate"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "TaxRate": taxRate,
      };
  TaxGroupComboModel.fromMap(Map<String, dynamic> map) {
    code = map[TaxGroupModelName.code];
    name = map[TaxGroupModelName.name];
    taxRate = map[TaxGroupModelName.taxRate];
  }
  Map<String, dynamic> toMap() {
    return {
      TaxGroupModelName.code: code,
      TaxGroupModelName.name: name,
      TaxGroupModelName.taxRate: taxRate,
    };
  }
}

class TaxGroupModelName {
  static const String tableName = "taxGroup";
  static const String code = "code";
  static const String name = "name";
  static const String taxRate = "taxRate";
}
