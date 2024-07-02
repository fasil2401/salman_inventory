import 'dart:convert';

CreateArrivalReportDetailsModel createArrivalReportDetailsModelFromJson(
        String str) =>
    CreateArrivalReportDetailsModel.fromJson(json.decode(str));

String createArrivalReportDetailsModelToJson(
        CreateArrivalReportDetailsModel data) =>
    json.encode(data.toJson());

class CreateArrivalReportDetailsModel {
  CreateArrivalReportDetailsModel({
    this.rowIndex,
    this.lotNumber = '',
    this.comodityId = '',
    this.varietyId = '',
    this.brandId = '',
    this.grower = '',
    this.itemSize = '',
    this.grade = '',
    this.sampleCount = 0.0,
    this.issue1Count = 0.0,
    this.issue2Count = 0.0,
    this.issue3Count = 0.0,
    this.issue4Count = 0.0,
    this.dateCode = '',
    this.temperature = 0.0,
    this.standardWeight = 0.0,
    this.weight = 0.0,
    this.pressure = 0.0,
    this.brix = 0.0,
    this.numericAtr1 = 0.0,
    this.numericAtr2 = 0.0,
    this.numericAtr3 = 0.0,
    this.numericAtr4 = 0.0,
    this.textAtr1 = '',
    this.textAtr2 = '',
    this.textAtr3 = '',
    this.textAtr4 = '',
    this.remarks = '',
  });

  dynamic rowIndex;
  String? lotNumber;
  String? comodityId;
  String? varietyId;
  String? brandId;
  String? grower;
  String? itemSize;
  String? grade;
  dynamic sampleCount;
  dynamic issue1Count;
  dynamic issue2Count;
  dynamic issue3Count;
  dynamic issue4Count;
  String? dateCode;
  dynamic temperature;
  dynamic standardWeight;
  dynamic weight;
  dynamic pressure;
  dynamic brix;
  dynamic numericAtr1;
  dynamic numericAtr2;
  dynamic numericAtr3;
  dynamic numericAtr4;
  String? textAtr1;
  String? textAtr2;
  String? textAtr3;
  String? textAtr4;
  String? remarks;

  factory CreateArrivalReportDetailsModel.fromJson(Map<String, dynamic> json) =>
      CreateArrivalReportDetailsModel(
        rowIndex: json["RowIndex"],
        lotNumber: json["LotNumber"],
        comodityId: json["ComodityID"],
        varietyId: json["VarietyID"],
        brandId: json["BrandID"],
        grower: json["Grower"],
        itemSize: json["ItemSize"],
        grade: json["Grade"],
        sampleCount: json["SampleCount"],
        issue1Count: json["Issue1Count"],
        issue2Count: json["Issue2Count"],
        issue3Count: json["Issue3Count"],
        issue4Count: json["Issue4Count"],
        dateCode: json["DateCode"],
        temperature: json["Temperature"],
        standardWeight: json["StandardWeight"],
        weight: json["Weight"],
        pressure: json["Pressure"],
        brix: json["Brix"],
        numericAtr1: json["NumericAtr1"],
        numericAtr2: json["NumericAtr2"],
        numericAtr3: json["NumericAtr3"],
        numericAtr4: json["NumericAtr4"],
        textAtr1: json["TextAtr1"],
        textAtr2: json["TextAtr2"],
        textAtr3: json["TextAtr3"],
        textAtr4: json["TextAtr4"],
        remarks: json["Remarks"],
      );

  Map<String, dynamic> toJson() => {
        "RowIndex": rowIndex,
        "LotNumber": lotNumber,
        "ComodityID": comodityId,
        "VarietyID": varietyId,
        "BrandID": brandId,
        "Grower": grower,
        "ItemSize": itemSize,
        "Grade": grade,
        "SampleCount": sampleCount,
        "Issue1Count": issue1Count,
        "Issue2Count": issue2Count,
        "Issue3Count": issue3Count,
        "Issue4Count": issue4Count,
        "DateCode": dateCode,
        "Temperature": temperature,
        "StandardWeight": standardWeight,
        "Weight": weight,
        "Pressure": pressure,
        "Brix": brix,
        "NumericAtr1": numericAtr1,
        "NumericAtr2": numericAtr2,
        "NumericAtr3": numericAtr3,
        "NumericAtr4": numericAtr4,
        "TextAtr1": textAtr1,
        "TextAtr2": textAtr2,
        "TextAtr3": textAtr3,
        "TextAtr4": textAtr4,
        "Remarks": remarks,
      };
}
