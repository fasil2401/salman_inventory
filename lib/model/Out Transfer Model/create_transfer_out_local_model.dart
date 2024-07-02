class CreateTransferOutImportantNames {
  static const String tableName = "create_transfer_out_header";
  static const String sysDocId = "sysDocId";
  static const String voucherId = "voucherId";
  static const String transferTypeId = "transferTypeId";
  static const String acceptReference = "acceptReference";
  static const String transactionDate = "transactionDate";
  static const String divisionId = "divisionId";
  static const String locationFromId = "locationFromId";
  static const String locationToId = "locationToId";
  static const String vehicleNumber = "vehicleNumber";
  static const String driverId = "driverId";
  static const String reference = "reference";
  static const String description = "description";
  static const String reason = "reason";
  static const String isRejectedTransfer = "isRejectedTransfer";
  static const String isSynced = "isSynced";
  static const String error = "error";
  static const String isError = "isError";
  static const String quantity = "quantity";
}

class CreateTransferOutLocalModel {
  String? sysDocId;
  String? voucherId;
  String? transferTypeId;
  String? acceptReference;
  String? transactionDate;
  String? divisionId;
  String? locationFromId;
  String? locationToId;
  String? vehicleNumber;
  String? driverId;
  String? reference;
  String? description;
  int? reason;
  int? isRejectedTransfer;
  int? isSynced;
  String? error;
  int? isError;
  double? quantity;

  CreateTransferOutLocalModel({
    this.sysDocId,
    this.voucherId,
    this.transferTypeId,
    this.acceptReference,
    this.transactionDate,
    this.divisionId,
    this.locationFromId,
    this.locationToId,
    this.vehicleNumber,
    this.driverId,
    this.reference,
    this.description,
    this.reason,
    this.isRejectedTransfer,
    this.isSynced,
    this.isError,
    this.error,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'sysDocId': sysDocId,
      'voucherId': voucherId,
      'transferTypeId': transferTypeId,
      'acceptReference': acceptReference,
      'transactionDate': transactionDate,
      'divisionId': divisionId,
      'locationFromId': locationFromId,
      'locationToId': locationToId,
      'vehicleNumber': vehicleNumber,
      'driverId': driverId,
      'reference': reference,
      'description': description,
      'reason': reason,
      'isRejectedTransfer': isRejectedTransfer,
      'isSynced': isSynced,
      'error': error,
      'isError': isError,
      'quantity': quantity,
    };
  }

  CreateTransferOutLocalModel.fromMap(Map<String, dynamic> map) {
    sysDocId = map['sysDocId'];
    voucherId = map['voucherId'];
    transferTypeId = map['transferTypeId'];
    acceptReference = map['acceptReference'];
    transactionDate = map['transactionDate'];
    divisionId = map['divisionId'];
    locationFromId = map['locationFromId'];
    locationToId = map['locationToId'];
    vehicleNumber = map['vehicleNumber'];
    driverId = map['driverId'];
    reference = map['reference'];
    description = map['description'];
    reason = map['reason'];
    isRejectedTransfer = map['isRejectedTransfer'];
    isSynced = map['isSynced'];
    error = map['error'];
    isError = map['isError'];
    quantity = map['quantity'];
  }
}

class CreateTransferOutDetailsImportantNames {
  static const String sysDocId = 'sysDocId';
  static const String voucherId = 'voucherId';
  static const String remarks = 'remarks';
  static const String acceptedFactorType = 'acceptedFactorType';
  static const String productId = 'productId';
  static const String description = 'description';
  static const String rowIndex = 'rowIndex';
  static const String sourceDocType = 'sourceDocType';
  static const String sourceRowIndex = 'sourceRowIndex';
  static const String listRowIndex = 'listRowIndex';
  static const String listVoucherId = 'listVoucherId';
  static const String listSysDocId = 'listSysDocId';
  static const String sourceVoucherId = 'sourceVoucherId';
  static const String sourceSysDocId = 'sourceSysDocId';
  static const String isSourcedRow = 'isSourcedRow';
  static const String isTrackLot = 'isTrackLot';
  static const String isTrackSerial = 'isTrackSerial';
  static const String acceptedQuantity = 'acceptedQuantity';
  static const String acceptedUnitQuantity = 'acceptedUnitQuantity';
  static const String acceptedFactor = 'acceptedFactor';
  static const String rejectedQuantity = 'rejectedQuantity';
  static const String rejectedUnitQuantity = 'rejectedUnitQuantity';
  static const String rejectedFactor = 'rejectedFactor';
  static const String quantity = 'quantity';
  static const String unitQuantity = 'unitQuantity';
  static const String factor = 'factor';
  static const String factorType = 'factorType';
  static const String rejectedFactorType = 'rejectedFactorType';
  static const String unitId = 'unitId';
  static const String tableName = 'create_transfer_out_details';
}

class CreateTransferOutDetailsLocalModel {
  String? sysDocId;
  String? voucherId;
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
  int? isTrackLot;
  int? isTrackSerial;
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

  CreateTransferOutDetailsLocalModel({
    this.sysDocId,
    this.voucherId,
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

  Map<String, dynamic> toMap() {
    return {
      'sysDocId': sysDocId,
      'voucherId': voucherId,
      'remarks': remarks,
      'acceptedFactorType': acceptedFactorType,
      'productId': productId,
      'description': description,
      'rowIndex': rowIndex,
      'sourceDocType': sourceDocType,
      'sourceRowIndex': sourceRowIndex,
      'listRowIndex': listRowIndex,
      'listVoucherId': listVoucherId,
      'listSysDocId': listSysDocId,
      'sourceVoucherId': sourceVoucherId,
      'sourceSysDocId': sourceSysDocId,
      'isSourcedRow': isSourcedRow,
      'isTrackLot': isTrackLot,
      'isTrackSerial': isTrackSerial,
      'acceptedQuantity': acceptedQuantity,
      'acceptedUnitQuantity': acceptedUnitQuantity,
      'acceptedFactor': acceptedFactor,
      'rejectedQuantity': rejectedQuantity,
      'rejectedUnitQuantity': rejectedUnitQuantity,
      'rejectedFactor': rejectedFactor,
      'quantity': quantity,
      'unitQuantity': unitQuantity,
      'factor': factor,
      'factorType': factorType,
      'rejectedFactorType': rejectedFactorType,
      'unitId': unitId,
    };
  }

  CreateTransferOutDetailsLocalModel.fromMap(Map<String, dynamic> product) {
    sysDocId = product['sysDocId'];
    voucherId = product['voucherId'];
    remarks = product['remarks'];
    acceptedFactorType = product['acceptedFactorType'];
    productId = product['productId'];
    description = product['description'];
    rowIndex = product['rowIndex'];
    sourceDocType = product['sourceDocType'];
    sourceRowIndex = product['sourceRowIndex'];
    listRowIndex = product['listRowIndex'];
    listVoucherId = product['listVoucherId'];
    listSysDocId = product['listSysDocId'];
    sourceVoucherId = product['sourceVoucherId'];
    sourceSysDocId = product['sourceSysDocId'];
    isSourcedRow = product['isSourcedRow'];
    isTrackLot = product['isTrackLot'];
    isTrackSerial = product['isTrackSerial'];
    acceptedQuantity = product['acceptedQuantity'];
    acceptedUnitQuantity = product['acceptedUnitQuantity'];
    acceptedFactor = product['acceptedFactor'];
    rejectedQuantity = product['rejectedQuantity'];
    rejectedUnitQuantity = product['rejectedUnitQuantity'];
    rejectedFactor = product['rejectedFactor'];
    quantity = product['quantity'];
    unitQuantity = product['unitQuantity'];
    factor = product['factor'];
    factorType = product['factorType'];
    rejectedFactorType = product['rejectedFactorType'];
    unitId = product['unitId'];
  }
  Map<String, dynamic> toJson() => {
        "SysDocId": sysDocId,
        "VoucherId": voucherId,
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
