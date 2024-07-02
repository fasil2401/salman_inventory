import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class SalesPersonListController extends GetxController {
  final salesPersonList = <ProductCommonComboModel>[].obs;

  Future<void> getSalesPersonList() async {
    final List<Map<String, dynamic>> salesPersons = await DBHelper().queryAllSalesPerson();
    salesPersonList.assignAll(
        salesPersons.map((data) => ProductCommonComboModel.fromMap(data)).toList());
  }

  insertSalesPersonList({required List<ProductCommonComboModel> salesPersonList}) async {
    await DBHelper().insertSalesPersonList(salesPersonList);
  }

  deleteSalesPersonTable() async {
    await DBHelper().deleteSalePersonTable();
  }
}
