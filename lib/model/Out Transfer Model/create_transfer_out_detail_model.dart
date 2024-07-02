import 'dart:convert';

CreateTransferOutDetailModel createTransferOutDetailModelFromJson(String str) => CreateTransferOutDetailModel.fromJson(json.decode(str));

String createTransferOutDetailModelToJson(CreateTransferOutDetailModel data) => json.encode(data.toJson());

class CreateTransferOutDetailModel {
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
    double? acceptedUnitQuantity;
    double? acceptedFactor;
    double? rejectedQuantity;
    double? rejectedUnitQuantity;
    double? rejectedFactor;
    double? quantity;
    double? unitQuantity;
    double? factor;
    String? factorType;
    String? rejectedFactorType;
    String? unitId;

    CreateTransferOutDetailModel({
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

    factory CreateTransferOutDetailModel.fromJson(Map<String, dynamic> json) => CreateTransferOutDetailModel(
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
