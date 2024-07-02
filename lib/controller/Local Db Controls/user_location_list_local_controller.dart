import 'package:axolon_inventory_manager/model/get_user_location_model.dart';

import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class UserLocationListController extends GetxController {
  final userlocationList = <UserLocationModel>[].obs;

  Future<void> getUserLocationList() async {
    final List<Map<String, dynamic>> userlocations =
        await DBHelper().queryAllUserLocation();
    userlocationList.assignAll(
        userlocations.map((data) => UserLocationModel.fromMap(data)).toList());
  }

  insertUserLocationList(
      {required List<UserLocationModel> userlocationList}) async {
        await DBHelper().insertUserLocationList(userlocationList);
  }

  deleteUserLocationTable() async {
    await DBHelper().deleteUserLocationTable();
  }
}
