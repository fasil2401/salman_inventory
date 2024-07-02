import 'dart:convert';

SystemDocumentModel systemDocumentModelFromJson(String str) =>
    SystemDocumentModel.fromJson(json.decode(str));

String systemDocumentModelToJson(SystemDocumentModel data) =>
    json.encode(data.toJson());

class SystemDocumentModel {
  SystemDocumentModel({
    required this.res,
    required this.mdel,
  });

  int res;
  List<SysDocModel> mdel;

  factory SystemDocumentModel.fromJson(Map<String, dynamic> json) =>
      SystemDocumentModel(
        res: json["res"],
        mdel: List<SysDocModel>.from(
            json["mdel"].map((x) => SysDocModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "res": res,
    "mdel": List<dynamic>.from(mdel.map((x) => x.toJson())),
  };
}

class SysDocModel {
  SysDocModel({
    this.code,
    this.name,
    this.sysDocType,
    this.locationId,
    this.printAfterSave,
    this.doPrint,
    this.printTemplateName,
    this.priceIncludeTax,
    this.divisionId,
    this.nextNumber,
    this.lastNumber,
    this.numberPrefix,
  });

  String? code;
  String? name;
  int? sysDocType;
  String? locationId;
  int? printAfterSave;
  int? doPrint;
  String? printTemplateName;
  int? priceIncludeTax;
  String? divisionId;
  int? nextNumber;
  String? lastNumber;
  String? numberPrefix;

  factory SysDocModel.fromJson(Map<String, dynamic> json) => SysDocModel(
    code: json["Code"],
    name: json["Name"],
    sysDocType: json["SysDocType"],
    locationId: json["LocationID"],
    printAfterSave: json["PrintAfterSave"] == true ? 1 : 0,
    doPrint: json["DoPrint"] == true ? 1 : 0,
    printTemplateName: json["PrintTemplateName"],
    priceIncludeTax: json["PriceIncludeTax"] == true ? 1 : 0,
    divisionId: json["DivisionID"],
    nextNumber: json["NextNumber"],
    lastNumber: json["LastNumber"],
    numberPrefix: json["NumberPrefix"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
    "SysDocType": sysDocType,
    "LocationID": locationId,
    "PrintAfterSave": printAfterSave,
    "DoPrint": doPrint,
    "PrintTemplateName": printTemplateName,
    "PriceIncludeTax": priceIncludeTax,
    "DivisionID": divisionId,
    "NextNumber": nextNumber,
    "LastNumber": lastNumber == null ? null : lastNumber,
    "NumberPrefix": numberPrefix,
  };
  Map<String ,dynamic> toMap(){
    return {
      SystemDocumentName.code:code,
      SystemDocumentName.name:name,
      SystemDocumentName.sysDocType:sysDocType,
      SystemDocumentName.locationId:locationId,
      SystemDocumentName.printAfterSave:printAfterSave,
      SystemDocumentName.doPrint:doPrint,
      SystemDocumentName.printTemplateName:printTemplateName,
      SystemDocumentName.priceIncludeTax:priceIncludeTax,
      SystemDocumentName.divisionId:divisionId,
      SystemDocumentName.nextNumber:nextNumber,
      SystemDocumentName.lastNumber:lastNumber,
      SystemDocumentName.numberPrefix:numberPrefix,

    };
  }
  SysDocModel.fromMap(Map<String,dynamic> map){
    code=map[SystemDocumentName.code];
    name=map[SystemDocumentName.name];
    sysDocType=map[SystemDocumentName.sysDocType];
    locationId=map[SystemDocumentName.locationId];
    printAfterSave=map[SystemDocumentName.printAfterSave] == true ? 1 : 0;
    doPrint=map[SystemDocumentName.doPrint] == true ? 1 : 0;
    printTemplateName=map[SystemDocumentName.printTemplateName];
    priceIncludeTax=map[SystemDocumentName.priceIncludeTax] == true ? 1 : 0;
    divisionId=map[SystemDocumentName.divisionId];
    nextNumber=map[SystemDocumentName.nextNumber];
    lastNumber=map[SystemDocumentName.lastNumber];
    numberPrefix=map[SystemDocumentName.numberPrefix];

  }
}
class SystemDocumentName{
  static const String code = 'code';
  static const String name = 'name';
  static const String sysDocType = 'sysDocType';
  static const String locationId = 'locationId';
  static const String printAfterSave = 'printAfterSave';
  static const String doPrint = 'doPrint';
  static const String printTemplateName = 'printTemplateName';
  static const String priceIncludeTax = 'priceIncludeTax';
  static const String divisionId = 'divisionId';
  static const String nextNumber = 'nextNumber';
  static const String lastNumber = 'lastNumber';
  static const String numberPrefix = 'numberPrefix';
  static const String tableName = 'sysDocId';
}