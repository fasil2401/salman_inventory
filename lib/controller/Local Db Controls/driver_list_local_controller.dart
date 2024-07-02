import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class DriverListController extends GetxController {
  final driverList = <ProductCommonComboModel>[].obs;

  Future<void> getDriverList() async {
    final List<Map<String, dynamic>> drivers =
        await DBHelper().queryAllDriver();
    driverList.assignAll(
        drivers.map((data) => ProductCommonComboModel.fromMap(data)).toList());
  }

  insertDriverList({required List<ProductCommonComboModel> driverList}) async {
    await DBHelper().insertDriverList(driverList);
  }

  deleteDriverTable() async {
    await DBHelper().deleteDriverTable();
  }
}
