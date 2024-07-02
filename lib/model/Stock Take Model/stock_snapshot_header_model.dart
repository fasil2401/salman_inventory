class StockSnapshotHeaderModelNames {
  static const String tableName = "stockSnapshotHeader";
  static const String token = "token";
  static const String sysdocid = "sysdocid";
  static const String voucherid = "voucherid";
  static const String companyid = "companyid";
  static const String divisionid = "divisionid";
  static const String locationid = "locationid";
  static const String adjustmenttype = "adjustmenttype";
  static const String refrence = "refrence";
  static const String description = "description";
  static const String isnewrecord = "isnewrecord";
  static const String status = "status";
  static const String transactiondate = "transactiondate";
  static const String isSynced = 'isSynced';
  static const String isError = 'isError';
  static const String error = 'error';
}

class StockSnapshotHeaderModel {
  String? token;
  String? sysdocid;
  String? voucherid;
  String? companyid;
  String? divisionid;
  String? locationid;
  String? adjustmenttype;
  String? refrence;
  String? description;
  int? isnewrecord;
  int? status;
  String? transactiondate;
  int? isSynced;
  int? isError;
  String? error;

  StockSnapshotHeaderModel({
    this.token,
    this.sysdocid,
    this.voucherid,
    this.companyid,
    this.divisionid,
    this.locationid,
    this.adjustmenttype,
    this.refrence,
    this.description,
    this.isnewrecord,
    this.status,
    this.transactiondate,
    this.isSynced,
    this.isError,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      StockSnapshotHeaderModelNames.token: token,
      StockSnapshotHeaderModelNames.sysdocid: sysdocid,
      StockSnapshotHeaderModelNames.voucherid: voucherid,
      StockSnapshotHeaderModelNames.companyid: companyid,
      StockSnapshotHeaderModelNames.divisionid: divisionid,
      StockSnapshotHeaderModelNames.locationid: locationid,
      StockSnapshotHeaderModelNames.adjustmenttype: adjustmenttype,
      StockSnapshotHeaderModelNames.refrence: refrence,
      StockSnapshotHeaderModelNames.description: description,
      StockSnapshotHeaderModelNames.isnewrecord: isnewrecord,
      StockSnapshotHeaderModelNames.status: status,
      StockSnapshotHeaderModelNames.transactiondate: transactiondate,
      StockSnapshotHeaderModelNames.isSynced: isSynced,
      StockSnapshotHeaderModelNames.isError: isError,
      StockSnapshotHeaderModelNames.error: error,
    };
  }

  StockSnapshotHeaderModel.fromMap(Map<String, dynamic> map) {
    token = map[StockSnapshotHeaderModelNames.token];
    sysdocid = map[StockSnapshotHeaderModelNames.sysdocid];
    voucherid = map[StockSnapshotHeaderModelNames.voucherid];
    companyid = map[StockSnapshotHeaderModelNames.companyid];
    divisionid = map[StockSnapshotHeaderModelNames.divisionid];
    locationid = map[StockSnapshotHeaderModelNames.locationid];
    adjustmenttype = map[StockSnapshotHeaderModelNames.adjustmenttype];
    refrence = map[StockSnapshotHeaderModelNames.refrence];
    description = map[StockSnapshotHeaderModelNames.description];
    isnewrecord = map[StockSnapshotHeaderModelNames.isnewrecord];
    status = map[StockSnapshotHeaderModelNames.status];
    transactiondate = map[StockSnapshotHeaderModelNames.transactiondate];
    isSynced = map[StockSnapshotHeaderModelNames.isSynced];
    isError = map[StockSnapshotHeaderModelNames.isError];
    error = map[StockSnapshotHeaderModelNames.error];
  }
}
