import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class ClassListController extends GetxController {
  final classList = <ProductCommonComboModel>[].obs;

  Future<void> getClassList() async {
    final List<Map<String, dynamic>> classs = await DBHelper().queryAllClass();
    classList.assignAll(
        classs.map((data) => ProductCommonComboModel.fromMap(data)).toList());
  }

  insertClassList({required List<ProductCommonComboModel> classList}) async {
    await DBHelper().insertClassList(classList);
  }

  deleteClassTable() async {
    await DBHelper().deleteClassTable();
  }
}
