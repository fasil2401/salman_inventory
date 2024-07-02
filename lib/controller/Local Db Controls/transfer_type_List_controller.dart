import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class TransferTypeListController extends GetxController {
  final transferTypeList = <TransferTypeModel>[].obs;

  Future<void> getTransferTypeList() async {
    final List<Map<String, dynamic>> transferTypes =
        await DBHelper().queryAllTransferType();
    transferTypeList.assignAll(
        transferTypes.map((data) => TransferTypeModel.fromMap(data)).toList());
  }

  insertTransferTypeList(
      {required List<TransferTypeModel> transferTypeList}) async {
    await DBHelper().insertTransferTypeList(transferTypeList);
  }

  deleteTransferTypeTable() async {
    await DBHelper().deleteTransferTypeTable();
  }
}
