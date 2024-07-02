import 'dart:developer';

import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_byid_model.dart';
import 'package:axolon_inventory_manager/model/draft_items_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:get/get.dart';

class DraftListController extends GetxController {
  final draftItemList = <DraftItemListModel>[].obs;
  Future<void> getDraftItemList({required DraftItemOption option}) async {
    log('message');
    final List<Map<String, dynamic>> headers =
        await DBHelper().queryDraftItemList(option.value);
    draftItemList.assignAll(
        headers.map((data) => DraftItemListModel.fromMap(data)).toList());
    update();
  }

  insertStockDraftItem(
      {required StockDetailModel item,
      required StockHeaderModel header}) async {
    await DBHelper().insertDraftItem(
        item: mapObjects(item, header),
        draftOption: DraftItemOption.StockTake.value);
  }

  insertStockDraftItemList(
      {required List<StockDetailModel> items,
      required StockHeaderModel header}) async {
    await DBHelper().insertDraftItemList(
        items: items.map((e) => mapObjects(e, header)).toList(),
        draftOption: DraftItemOption.StockTake.value);
  }

  DraftItemListModel mapObjects(
      StockDetailModel sourceObject, StockHeaderModel header) {
    log(sourceObject.rowIndex.toString());
    // Perform the mapping logic here
    String productId = sourceObject.productId ?? '';
    double quantity =
        sourceObject.quantity != null ? sourceObject.quantity.toDouble() : 0.0;
    double physicalQuantity = sourceObject.physicalQuantity != null
        ? sourceObject.physicalQuantity.toDouble()
        : 0.0;
    String description = sourceObject.description ?? '';
    String unitId = sourceObject.unitId ?? '';
    String remarks = sourceObject.remarks ?? '';
    int rowIndex = sourceObject.rowIndex ?? 0;
    int isNewRecord = header.isNewRecord! == true ? 1 : 0;
    String sysDocId = header.sysDocId ?? '';
    String voucherId = header.voucherId ?? '';
    String headerDescription = header.description ?? '';
    String? trnDate = header.transactionDate != null
        ? header.transactionDate!.toIso8601String()
        : null;
    String locationId = header.locationId ?? '';
    // Create and return a new DestinationObject
    return DraftItemListModel(
      productId: productId,
      quantity: quantity,
      updatedQuatity: physicalQuantity,
      description: description,
      unitId: unitId,
      updatedUnitId: unitId,
      remarks: remarks,
      index: rowIndex,
      sysDocId: sysDocId,
      voucherId: voucherId,
      headerDescription: headerDescription,
      headerLocationId: locationId,
      transactionDate: trnDate,
      isNewRecord: isNewRecord,
    );
  }

  updateDraftItem(
      {required String productId,
      required int draftOption,
      required int index,
      required double quantity,
      required String unitId}) async {
    log(index.toString());
    await DBHelper().updateDraftItem(
        productId: productId,
        draftOption: draftOption,
        index: index,
        quantity: quantity,
        unitId: unitId);
  }

  updateDraftItemSysDoc({
    required String sysDocId,
    required String voucherId,
    required String newSysDoc,
  }) async {
    await DBHelper().updateDraftItemSysDoc(
        sysDocId: sysDocId, voucherId: voucherId, newSysDoc: newSysDoc);
  }

  deleteDraftItem({required int draftOption, required int index}) async {
    await DBHelper().deleteDraftItem(draftOption: draftOption, index: index);
    update();
  }

  deleteDraftItemList({required int draftOption}) async {
    await DBHelper().deleteDraftItemList(draftOption: draftOption);
    update();
  }
}
