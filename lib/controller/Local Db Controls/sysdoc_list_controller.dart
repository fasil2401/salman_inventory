import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class SysDocListController extends GetxController {
  final sysDocList = <SysDocModel>[].obs;

  Future<void> getSysDocList() async {
    final List<Map<String, dynamic>> sysDocs =
        await DBHelper().queryAllSysDocId();
    sysDocList
        .assignAll(sysDocs.map((data) => SysDocModel.fromMap(data)).toList());
  }
  updateSysDocVoucher({required int nextNumber, required String code}) async {
    print('entering updatee ========  $nextNumber');
    int result = await DBHelper().updateSysDoc(nextNumber + 1, code);
    print('result: $result');
    getSysDocList();
  }
  Future<void> getSysDocListByType({required int sysDocType}) async {
    final List<Map<String, dynamic>> sysDocs =
        await DBHelper().queryAllSysDocIdByType(sysDocType:sysDocType);
    sysDocList
        .assignAll(sysDocs.map((data) => SysDocModel.fromMap(data)).toList());
  }

  Future<void> getSysDocListById({required int sysDocType,required String sysDocId}) async {
    final List<Map<String, dynamic>> sysDocs =
        await DBHelper().queryAllSysDocIdById(sysDocType:sysDocType,sysDocId: sysDocId);
    sysDocList
        .assignAll(sysDocs.map((data) => SysDocModel.fromMap(data)).toList());
  }

  insertSysDocList({required List<SysDocModel> sysDocList}) async {
    await DBHelper().insertSysDocIdList(sysDocList);
  }

  deleteSysDocTable() async {
    await DBHelper().deleteSysDocIdTable();
  }
}
