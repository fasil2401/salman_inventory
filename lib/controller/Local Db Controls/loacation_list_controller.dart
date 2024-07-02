import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class LocationListController extends GetxController {
  final locationList = <LocationModel>[].obs;

  Future<void> getLocationList() async {
    final List<Map<String, dynamic>> locations =
        await DBHelper().queryAllLocation();
    locationList.assignAll(
        locations.map((data) => LocationModel.fromMap(data)).toList());
  }

  insertLocationList({required List<LocationModel> locationList}) async {
    await DBHelper().insertLocationList(locationList);
  }

  deleteLocationTable() async {
    await DBHelper().deleteLocationTable();
  }
}
