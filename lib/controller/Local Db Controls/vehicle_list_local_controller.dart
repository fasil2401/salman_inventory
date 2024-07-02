import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class VehicleListController extends GetxController {
  final vehicleList = <ProductCommonComboModel>[].obs;

  Future<void> getVehicleList() async {
    final List<Map<String, dynamic>> vehicles =
        await DBHelper().queryAllVehicle();
    vehicleList.assignAll(
        vehicles.map((data) => ProductCommonComboModel.fromMap(data)).toList());
  }

  insertvehicleList({required List<ProductCommonComboModel> vehicleList}) async {
    await DBHelper().insertVehicleList(vehicleList);
  }

  deletevehicleTable() async {
    await DBHelper().deleteVehicleTable();
  }
}
