import 'dart:developer';

import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_transfer_out_local_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class CreateOutTransferLocalController extends GetxController {
  final outTransferHeaders = <CreateTransferOutLocalModel>[].obs;
  final outTransferDetails = [].obs;
  Future<void> getOutTransferHeaders() async {
    final List<Map<String, dynamic>> headers =
        await DBHelper().queryOutTransferHeader();
    outTransferHeaders.assignAll(headers
        .map((data) => CreateTransferOutLocalModel.fromMap(data))
        .toList());
    update();
  }

  Future<void> getOutTransferDetails({required String voucher}) async {
    final List<Map<String, dynamic>> details =
        await DBHelper().queryOutTransferDetail(voucher: voucher);
    outTransferDetails.assignAll(details
        .map((data) => CreateTransferOutDetailsLocalModel.fromMap(data))
        .toList());
  }

  insertOutTransferHeader({required CreateTransferOutLocalModel header}) async {
    await DBHelper().insertOutTransferHeader(header);
  }

  insertOutTransferDetails(
      {required List<CreateTransferOutDetailsLocalModel> detail}) async {
    await DBHelper().insertOutTransferDetailsList(detail);
  }

  updateoutTransferHeaders({
    required String voucherId,
    required int isSynced,
    required int isError,
    required String error,
  }) async {
    log("$isSynced", name: 'Update isSynced');
    await DBHelper()
        .updateOutTransferHeaders(voucherId, isSynced, isError, error);
    getOutTransferHeaders();
  }

  updateOutTransferDetails({required String voucherId}) async {
    await DBHelper().updateOutTransferDetail(voucherId);
  }

  deleteOutTransferHeader({required String vouchetId}) async {
    await DBHelper().deleteOutTransferHeader(vouchetId: vouchetId);
    update();
  }

  deleteOutTransferDetail({required String vouchetId}) async {
    await DBHelper().deleteOutTransferDetail(vouchetId: vouchetId);
    update();
  }

  updateOutTransferHeader(
      {required String voucherId,
      required CreateTransferOutLocalModel header}) async {
    await DBHelper().updateOutTransferHeader(voucherId, header);
  }

  getLastVoucher({
    //required String prefix,
    required SysDocModel sysDoc,
    //required int nextNumber
  }) async {
    log("${sysDoc} prefix");
    final int? lastNumber = await DBHelper().getLastOutTransferVoucher(
      sysDoc: sysDoc,
    );
    String data =
        '${sysDoc.numberPrefix}${lastNumber.toString().padLeft(6, '0')}';
    return lastNumber;
  }
  updateOutTransferHeaderVoucher({
    required String voucherId,
    required String docNo,
  }) async {
    await DBHelper().updateOutTransferHeaderVoucher(voucherId, docNo);
    getOutTransferHeaders();
  }
}
