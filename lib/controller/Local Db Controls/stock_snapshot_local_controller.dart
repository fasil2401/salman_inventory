import 'dart:developer';

import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_header_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_take_save_detail_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class StockSnapshotLocalController extends GetxController {
  final stockSnapshotHeaders = <StockSnapshotHeaderModel>[].obs;
  final stockSnapshotDetail = [].obs;
  Future<void> getStockSnapshotHeaders() async {
    log('getting stock snapshot headers');
    final List<Map<String, dynamic>> headers =
        await DBHelper().queryStockSanpshotHeader();
    log('getting stock snapshot headers ie ${headers}');
    stockSnapshotHeaders.assignAll(
        headers.map((data) => StockSnapshotHeaderModel.fromMap(data)).toList());
    update();
  }

  insertStockSnapshotHeaders({required StockSnapshotHeaderModel header}) async {
    await DBHelper().insertStockSnapshotHeader(header);
  }

  Future<void> getStockSnapshotDetails({required String voucher}) async {
    final List<Map<String, dynamic>> details =
        await DBHelper().queryStockSanpshotDetail(voucher: voucher);
    stockSnapshotDetail.assignAll(
        details.map((data) => StockTakeSaveDetailModel.fromMap(data)).toList());
  }

  insertStockSnapshotDetails(
      {required List<StockTakeSaveDetailModel> detail}) async {
    await DBHelper().insertStockSnapshotDetailList(detail);
  }

  updateStockSnapshotHeaders({
    required String voucherId,
    required int isSynced,
    required int isError,
    required String error,
  }) async {
    log("$isSynced", name: 'Update isSynced');
    await DBHelper()
        .updateStockSnapshotHeader(voucherId, isSynced, isError, error);
    getStockSnapshotHeaders();
  }
   updateStockSnapshotHeadersVoucher({
    required String voucherId,
    required String docNo,
  }) async {
    await DBHelper()
        .updateStockSnapshotHeaderVoucher(voucherId, docNo);
    getStockSnapshotHeaders();
  }

  deleteSnapshot({required String vouchetId}) async {
    await DBHelper().deleteStockSnapshotHeader(vouchetId: vouchetId);
    await DBHelper().deleteStockSnapshotDetail(vouchetId: vouchetId);
    getStockSnapshotHeaders();
    update();
  }

  updateStockSnapshotDetails({required String voucherId}) async {
    await DBHelper().updateStockSnapshotDetail(voucherId);
  }
}
