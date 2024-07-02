import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/grn_local_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

import 'dart:developer';

class GoodsRecieveNoteLocalController extends GetxController {
  final goodsRecieveNoteHeaders = <GoodsRecieveNoteHeaderModel>[].obs;
  final goodsRecieveNoteDetail = [].obs;
  final goodsRecieveNoteLotDetail = [].obs;

  Future<void> getGoodsRecieveNoteHeaders() async {
    final List<Map<String, dynamic>> headers =
        await DBHelper().queryAllGoodsRecieveNoteHeaders();
    goodsRecieveNoteHeaders.assignAll(headers
        .map((data) => GoodsRecieveNoteHeaderModel.fromMap(data))
        .toList());
  }

  // Future<GoodsRecieveNoteHeaderModel> getgoodsRecieveNoteHeaderUsingVoucher(
  //     {required String voucher}) async {
  //   final Map<String, dynamic>? header = await DBHelper()
  //       .querygoodsRecieveNoteHeaderUsingVoucher(voucher: voucher);
  //   return GoodsRecieveNoteHeaderModel.fromMap(header!);
  // }

  Future<int?> getLastVoucher({required SysDocModel sysDoc}) async {
    final int? lastNumber = await DBHelper().getLastVoucher(sysDoc: sysDoc);
    return lastNumber;
  }

  // Future<bool> isVoucherAlreadyPresent({required String voucher}) async {
  //   final bool status = await DBHelper().isVoucherPresentInTable(voucher);
  //   return status;
  // }

  Future<void> getGodsRecieveNoteDetails({required String voucher}) async {
    final List<Map<String, dynamic>> details =
        await DBHelper().queryGoodsRecieveNoteDetails(voucher: voucher);
    log(details.toString(), name: 'Detail list');
    goodsRecieveNoteDetail.assignAll(details
        .map((data) => GRNDetailsModel.fromMap(data))
        .toList());
  }

  Future<void> getGoodsRecieveNoteLotDetails({required String voucher}) async {
    final List<Map<String, dynamic>> details =
        await DBHelper().queryGoodsRecieveNoteLotDetails(voucher: voucher);
    goodsRecieveNoteLotDetail.assignAll(details
        .map((data) => ProductLotReceivingDetailModel.fromMap(data))
        .toList());
  }

 

  insertGoodsRecieveNoteHeaders(
      {required GoodsRecieveNoteHeaderModel header}) async {
    await DBHelper().insertGoodsRecieveNoteHeader(header);
  }

  insertgoodsRecieveNoteDetails(
      {required List<GRNDetailsModel> detail}) async {
    await DBHelper().insertGoodsRecieveNoteDetail(detail);
  }

  insertgoodsRecieveNoteLotDetails(
      {required List<ProductLotReceivingDetailModel> lot}) async {
    await DBHelper().insertgoodsRecieveNoteLotDetail(lot);
  }

  // updateAsNewgoodsRecieveNoteHeader(
  //     {required String voucherId,
  //     required GRNDetailsModel header}) async {
  //   await DBHelper().updateAsNewgoodsRecieveNoteHeader(voucherId, header);
  // }

  updategoodsRecieveNoteHeaders(
      {required String voucherId,
      required int isSynced,
      required int isError,
      required String error,
      required String docNo}) async {
    await DBHelper().updateGoodsRecieveNoteHeader(
        voucherId, isSynced, isError, error, docNo);
  }

  updategoodsRecieveNoteDetails(
      {required String voucherId, required String docNo}) async {
    await DBHelper().updateGoodsRecieveNoteDetail(voucherId, docNo);
  }

  updategoodsRecieveNoteLotDetails(
      {required String voucherId, required String docNo}) async {
    await DBHelper().updategoodsRecieveNoteLotDetail(voucherId, docNo);
  }


  deletegoodsRecieveNoteHeader({required String voucherId}) async {
    await DBHelper().deletegoodsRecieveNoteHeader(voucherId);
  }

  deletegoodsRecieveNoteDetails({required String voucherId}) async {
    await DBHelper().deletegoodsRecieveNoteDetails(voucherId);
  }

  deletegoodsRecieveNoteLotDetails({required String voucherId}) async {
    await DBHelper().deletegoodsRecieveNoteLotDetails(voucherId);
  }

}
