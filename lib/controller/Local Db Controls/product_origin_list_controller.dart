import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class ProductOriginListController extends GetxController {
  final productOriginList = <ProductCommonComboModel>[].obs;

  Future<void> getProductOriginList() async {
    final List<Map<String, dynamic>> productOrigins =
        await DBHelper().queryAllOrigin();
    productOriginList.assignAll(productOrigins
        .map((data) => ProductCommonComboModel.fromMap(data))
        .toList());
  }

  insertProductOriginList(
      {required List<ProductCommonComboModel> productOriginList}) async {
    await DBHelper().insertOriginList(productOriginList);
  }

  deleteProductOriginTable() async {
    await DBHelper().deleteOriginTable();
  }
}
