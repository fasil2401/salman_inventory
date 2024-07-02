class CreateTransferOutImportantNames {
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
  static const String quantity = "quantity";
  static const String tableName = "create_transfer_out";
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
    quantity = map['quantity'];
  }
}
