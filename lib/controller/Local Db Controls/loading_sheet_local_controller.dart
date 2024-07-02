import 'dart:developer';

import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/loading_sheet_local_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class LoadingSheetsLocalController extends GetxController {
  final loadingSheetsHeaders = <LoadingSheetsHeaderModel>[].obs;
  final loadingSheetsDetail = [].obs;
  Future<void> getLoadingSheetsHeaders() async {
    final List<Map<String, dynamic>> headers =
        await DBHelper().queryLoadingSheetsHeader();
    loadingSheetsHeaders.assignAll(
        headers.map((data) => LoadingSheetsHeaderModel.fromMap(data)).toList());
    update();
  }

  insertLoadingSheetsHeaders({required LoadingSheetsHeaderModel header}) async {
    await DBHelper().insertLoadingSheetsHeader(header);
  }

  insertLoadingSheetItems({required ItemTransactionDetailsModel item}) async {
    await DBHelper().insertItemTransactionItem(item);
  }

  updateLoadingSheetItems(
      {required String voucherId,
      required double quantity,
      required String itemCode}) async {
    await DBHelper().updateLoadingSheetsItem(voucherId, quantity, itemCode);
  }

  Future<void> getloadingSheetsDetails({required String voucher}) async {
    final List<Map<String, dynamic>> details =
        await DBHelper().queryLoadingSheetsDetail(voucher: voucher);
    loadingSheetsDetail.assignAll(details
        .map((data) => ItemTransactionDetailsModel.fromMap(data))
        .toList());
  }

  insertLoadingSheetsDetails(
      {required List<ItemTransactionDetailsModel> detail}) async {
    await DBHelper().insertItemTransactionDetailsList(detail);
  }

  updateloadingSheetsHeaders({
    required String voucherId,
    required int isSynced,
    required int isError,
    required String error,
  }) async {
    log("$isSynced", name: 'Update isSynced');
    await DBHelper()
        .updateLoadingSheetsHeader(voucherId, isSynced, isError, error);
    getLoadingSheetsHeaders();
  }

  updateloadingSheetsHeadersIscompleted(
      {required String voucherId, required int isCompleted}) async {
    await DBHelper()
        .updateloadingSheetsHeadersIscompleted(voucherId, isCompleted);
    getLoadingSheetsHeaders();
  }

  updateLoadingSheetsHeadersVoucher({
    required String voucherId,
    required String docNo,
  }) async {
    await DBHelper().updateLoadingSheetsHeaderVoucher(voucherId, docNo);
    getLoadingSheetsHeaders();
  }

  deleteLoadingSheet({required String vouchetId}) async {
    await DBHelper().deleteLoadingSheetsHeader(vouchetId: vouchetId);
    await DBHelper().deleteLoadingSheetsDetail(vouchetId: vouchetId);
    getLoadingSheetsHeaders();
    update();
  }

  updateLoadingSheetHeaderPartyIdOrDocType(
      {required String voucherId,
      required String txt,
      required bool partyId}) async {
    await DBHelper()
        .updateLoadingSheetHeaderPartyIdOrDocumentType(voucherId, txt, partyId);
  }

  updateLoadingSheetsDetails({required String voucherId}) async {
    await DBHelper().updateLoadingSheetsDetail(voucherId);
  }

  updateLoadingSheetHeaderPartyId(
      {required String voucherId, required String partyId}) async {
    await DBHelper().updateLoadingSheetHeaderPartyId(
      voucherId,
      partyId,
    );
  }

  deleteLoadingSheetHeader({required String vouchetId}) async {
    await DBHelper().deleteLoadingSheetsHeader(vouchetId: vouchetId);
    update();
  }

  deleteLoadingSheetItem(
      {required String voucherid, required String itemCode}) async {
    await DBHelper()
        .deleteLoadingSheetsItem(voucherId: voucherid, itemCode: itemCode);
  }

  deleteLoadingSheetDetail({required String vouchetId}) async {
    await DBHelper().deleteLoadingSheetsDetail(vouchetId: vouchetId);
    update();
  }

  updateLoadingSheetHeader(
      {required String voucherId,
      required LoadingSheetsHeaderModel header}) async {
    await DBHelper().updateLoadingSheetHeader(voucherId, header);
  }

  updateLoadingSheetDetail(
      {required String voucherId,
      required String itemCode,
      required ItemTransactionDetailsModel detail}) async {
    await DBHelper().updateItemTransactionDetails(voucherId, itemCode, detail);
  }

  isLoadingSheetHeaderAlreadyExist({required String voucherId}) async {
    int isExist = await DBHelper().isLoadingSheeHeaderExist(voucherId);
    return isExist;
  }

  isLoadingSheetDetailAlreadyExist(
      {required String voucherId, required String itemCode}) async {
    int isExist =
        await DBHelper().isLoadingSheeDetailExist(voucherId, itemCode);
    return isExist;
  }
}
