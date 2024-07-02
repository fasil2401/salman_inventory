// To parse this JSON data, do
//
//     final CreateInventoryTransferInModel = CreateInventoryTransferInModelFromJson(jsonString);

import 'dart:convert';

CreateInventoryTransferInModel createInventoryTransferInModelFromJson(
        String str) =>
    CreateInventoryTransferInModel.fromJson(json.decode(str));

String createInventoryTransferInModelToJson(
        CreateInventoryTransferInModel data) =>
    json.encode(data.toJson());

class CreateInventoryTransferInModel {
  String? remarks;
  String? acceptedFactorType;
  String? productId;
  String? description;
  int? rowIndex;
  int? sourceDocType;
  int? sourceRowIndex;
  int? listRowIndex;
  String? listVoucherId;
  String? listSysDocId;
  String? sourceVoucherId;
  String? sourceSysDocId;
  int? isSourcedRow;
  bool? isTrackLot;
  bool? isTrackSerial;
  double? acceptedQuantity;
  int? acceptedUnitQuantity;
  int? acceptedFactor;
  int? rejectedQuantity;
  int? rejectedUnitQuantity;
  int? rejectedFactor;
  double? quantity;
  int? unitQuantity;
  int? factor;
  String? factorType;
  String? rejectedFactorType;
  String? unitId;

  CreateInventoryTransferInModel({
    this.remarks,
    this.acceptedFactorType,
    this.productId,
    this.description,
    this.rowIndex,
    this.sourceDocType,
    this.sourceRowIndex,
    this.listRowIndex,
    this.listVoucherId,
    this.listSysDocId,
    this.sourceVoucherId,
    this.sourceSysDocId,
    this.isSourcedRow,
    this.isTrackLot,
    this.isTrackSerial,
    this.acceptedQuantity,
    this.acceptedUnitQuantity,
    this.acceptedFactor,
    this.rejectedQuantity,
    this.rejectedUnitQuantity,
    this.rejectedFactor,
    this.quantity,
    this.unitQuantity,
    this.factor,
    this.factorType,
    this.rejectedFactorType,
    this.unitId,
  });

  factory CreateInventoryTransferInModel.fromJson(Map<String, dynamic> json) =>
      CreateInventoryTransferInModel(
        remarks: json["Remarks"],
        acceptedFactorType: json["AcceptedFactorType"],
        productId: json["ProductId"],
        description: json["Description"],
        rowIndex: json["RowIndex"],
        sourceDocType: json["SourceDocType"],
        sourceRowIndex: json["SourceRowIndex"],
        listRowIndex: json["ListRowIndex"],
        listVoucherId: json["ListVoucherID"],
        listSysDocId: json["ListSysDocID"],
        sourceVoucherId: json["SourceVoucherID"],
        sourceSysDocId: json["SourceSysDocID"],
        isSourcedRow: json["IsSourcedRow"],
        isTrackLot: json["IsTrackLot"],
        isTrackSerial: json["IsTrackSerial"],
        acceptedQuantity: json["AcceptedQuantity"],
        acceptedUnitQuantity: json["AcceptedUnitQuantity"],
        acceptedFactor: json["AcceptedFactor"],
        rejectedQuantity: json["RejectedQuantity"],
        rejectedUnitQuantity: json["RejectedUnitQuantity"],
        rejectedFactor: json["RejectedFactor"],
        quantity: json["Quantity"],
        unitQuantity: json["UnitQuantity"],
        factor: json["Factor"],
        factorType: json["FactorType"],
        rejectedFactorType: json["RejectedFactorType"],
        unitId: json["UnitId"],
      );

  Map<String, dynamic> toJson() => {
        "Remarks": remarks,
        "AcceptedFactorType": acceptedFactorType,
        "ProductId": productId,
        "Description": description,
        "RowIndex": rowIndex,
        "SourceDocType": sourceDocType,
        "SourceRowIndex": sourceRowIndex,
        "ListRowIndex": listRowIndex,
        "ListVoucherID": listVoucherId,
        "ListSysDocID": listSysDocId,
        "SourceVoucherID": sourceVoucherId,
        "SourceSysDocID": sourceSysDocId,
        "IsSourcedRow": isSourcedRow,
        "IsTrackLot": isTrackLot,
        "IsTrackSerial": isTrackSerial,
        "AcceptedQuantity": acceptedQuantity,
        "AcceptedUnitQuantity": acceptedUnitQuantity,
        "AcceptedFactor": acceptedFactor,
        "RejectedQuantity": rejectedQuantity,
        "RejectedUnitQuantity": rejectedUnitQuantity,
        "RejectedFactor": rejectedFactor,
        "Quantity": quantity,
        "UnitQuantity": unitQuantity,
        "Factor": factor,
        "FactorType": factorType,
        "RejectedFactorType": rejectedFactorType,
        "UnitId": unitId,
      };
}
