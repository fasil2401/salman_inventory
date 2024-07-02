import 'dart:convert';

StockTakeSaveDetailModel stockTakeSaveDetailModelFromJson(String str) =>
    StockTakeSaveDetailModel.fromJson(json.decode(str));

String stockTakeSaveDetailModelToJson(StockTakeSaveDetailModel data) =>
    json.encode(data.toJson());

class StockSnapshotDetailModelNames {
  static const String tableName = "stockSnapshotDetail";
  static const String itemcode = "itemcode";
  static const String physicalqty = "physicalqty";
  static const String onhand = "onhand";
  static const String remarks = "remarks";
  static const String rowindex = "rowindex";
  static const String unitid = "unitid";
  static const String listrowindex = "listrowindex";
  static const String listsysdocid = "listsysdocid";
  static const String listvoucherid = "listvoucherid";
  static const String refslno = "refslno";
  static const String reftext1 = "reftext1";
  static const String reftext2 = "reftext2";
  static const String refnum1 = "refnum1";
  static const String refnum2 = "refnum2";
  static const String description = "description";
  static const String refdate1 = "refdate1";
  static const String refdate2 = "refdate2";
}

class StockTakeSaveDetailModel {
  StockTakeSaveDetailModel({
    this.itemcode,
    this.physicalqty,
    this.onhand,
    this.remarks,
    this.rowindex,
    this.unitid,
    this.listrowindex,
    this.listsysdocid,
    this.listvoucherid,
    this.refslno,
    this.reftext1,
    this.reftext2,
    this.refnum1,
    this.refnum2,
    this.description,
    this.refdate1,
    this.refdate2,
  });

  String? itemcode;
  dynamic physicalqty;
  dynamic onhand;
  String? remarks;
  int? rowindex;
  String? unitid;
  dynamic listrowindex;
  String? listsysdocid;
  String? listvoucherid;
  String? refslno;
  String? reftext1;
  String? reftext2;
  String? refnum1;
  String? refnum2;
  String? description;
  String? refdate1;
  String? refdate2;

  factory StockTakeSaveDetailModel.fromJson(Map<String, dynamic> json) =>
      StockTakeSaveDetailModel(
        itemcode: json["itemcode"],
        physicalqty: json["physicalqty"],
        onhand: json["Onhand"],
        remarks: json["remarks"],
        rowindex: json["rowindex"],
        unitid: json["unitid"],
        listrowindex: json["listrowindex"],
        listsysdocid: json["listsysdocid"],
        listvoucherid: json["listvoucherid"],
        refslno: json["refslno"],
        reftext1: json["reftext1"],
        reftext2: json["reftext2"],
        refnum1: json["refnum1"],
        refnum2: json["refnum2"],
        description: json["description"],
        refdate1: json["refdate1"],
        refdate2: json["refdate2"],
      );

  Map<String, dynamic> toJson() => {
        "itemcode": itemcode,
        "physicalqty": physicalqty,
        "Onhand": onhand,
        "remarks": remarks,
        "rowindex": rowindex,
        "unitid": unitid,
        "listrowindex": listrowindex,
        "listsysdocid": listsysdocid,
        "listvoucherid": listvoucherid,
        "refslno": refslno,
        "reftext1": reftext1,
        "reftext2": reftext2,
        "refnum1": refnum1,
        "refnum2": refnum2,
        "description": description,
        "refdate1": refdate1,
        "refdate2": refdate2,
      };
  Map<String, dynamic> toMap() {
    return {
      StockSnapshotDetailModelNames.itemcode: itemcode,
      StockSnapshotDetailModelNames.physicalqty: physicalqty,
      StockSnapshotDetailModelNames.onhand: onhand,
      StockSnapshotDetailModelNames.remarks: remarks,
      StockSnapshotDetailModelNames.rowindex: rowindex,
      StockSnapshotDetailModelNames.unitid: unitid,
      StockSnapshotDetailModelNames.listrowindex: listrowindex,
      StockSnapshotDetailModelNames.listsysdocid: listsysdocid,
      StockSnapshotDetailModelNames.listvoucherid: listvoucherid,
      StockSnapshotDetailModelNames.refslno: refslno,
      StockSnapshotDetailModelNames.reftext1: reftext1,
      StockSnapshotDetailModelNames.reftext2: reftext2,
      StockSnapshotDetailModelNames.refnum1: refnum1,
      StockSnapshotDetailModelNames.refnum2: refnum2,
      StockSnapshotDetailModelNames.description: description,
      StockSnapshotDetailModelNames.refdate1: refdate1,
      StockSnapshotDetailModelNames.refdate2: refdate2,
    };
  }

  StockTakeSaveDetailModel.fromMap(Map<String, dynamic> map) {
    itemcode = map[StockSnapshotDetailModelNames.itemcode];
    physicalqty = map[StockSnapshotDetailModelNames.physicalqty];
    onhand = map[StockSnapshotDetailModelNames.onhand];
    remarks = map[StockSnapshotDetailModelNames.remarks];
    rowindex = map[StockSnapshotDetailModelNames.rowindex];
    unitid = map[StockSnapshotDetailModelNames.unitid];
    listrowindex = map[StockSnapshotDetailModelNames.listrowindex];
    listsysdocid = map[StockSnapshotDetailModelNames.listsysdocid];
    listvoucherid = map[StockSnapshotDetailModelNames.listvoucherid];
    refslno = map[StockSnapshotDetailModelNames.refslno];
    reftext1 = map[StockSnapshotDetailModelNames.reftext1];
    reftext2 = map[StockSnapshotDetailModelNames.reftext2];
    refnum1 = map[StockSnapshotDetailModelNames.refnum1];
    refnum2 = map[StockSnapshotDetailModelNames.refnum2];
    description = map[StockSnapshotDetailModelNames.description];
    refdate1 = map[StockSnapshotDetailModelNames.refdate1];
    refdate2 = map[StockSnapshotDetailModelNames.refdate2];
  }
}
