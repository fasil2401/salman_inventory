import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class BrandListController extends GetxController {
  final brandList = <ProductCommonComboModel>[].obs;

  Future<void> getBrandList() async {
    final List<Map<String, dynamic>> brands = await DBHelper().queryAllBrand();
    brandList.assignAll(
        brands.map((data) => ProductCommonComboModel.fromMap(data)).toList());
  }

  insertBrandList({required List<ProductCommonComboModel> brandList}) async {
    await DBHelper().insertBrandList(brandList);
  }

  deleteBrandTable() async {
    await DBHelper().deleteBrandTable();
  }
}
