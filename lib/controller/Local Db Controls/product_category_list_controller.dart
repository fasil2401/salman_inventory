import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  final categoryList = <ProductCommonComboModel>[].obs;

  Future<void> getCategoryList() async {
    final List<Map<String, dynamic>> categorys =
        await DBHelper().queryAllCategory();
    categoryList.assignAll(categorys
        .map((data) => ProductCommonComboModel.fromMap(data))
        .toList());
  }

  insertCategoryList(
      {required List<ProductCommonComboModel> categoryList}) async {
    await DBHelper().insertCategoryList(categoryList);
  }

  deleteCategoryTable() async {
    await DBHelper().deleteCategoryTable();
  }
}
