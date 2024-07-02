import 'package:axolon_inventory_manager/model/get_user_security_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class UserSecurityListController extends GetxController {
  final defaultObjectList = <DefaultsObj>[].obs;
  final menuSecurityObjectList = <MenuSecurityObj>[].obs;
  final screenSecurityObjectList = <ScreenSecurityObj>[].obs;

  Future<void> getDefaultObjects() async {
    final List<Map<String, dynamic>> defaultObjects =
        await DBHelper().queryAllDefaultObjects();
    defaultObjectList.assignAll(
        defaultObjects.map((data) => DefaultsObj.fromMap(data)).toList());
  }

  Future<void> getMenuScurityObjects() async {
    final List<Map<String, dynamic>> menuSecurityObjects =
        await DBHelper().queryAllMenuSecurityObjects();
    menuSecurityObjectList.assignAll(
        menuSecurityObjects.map((data) => MenuSecurityObj.fromMap(data)).toList());
  }

  Future<void> getScreenScurityObjects() async {
    final List<Map<String, dynamic>> screenSecurityObjects =
        await DBHelper().queryAllScreenSecurityObjects();
    screenSecurityObjectList.assignAll(
        screenSecurityObjects.map((data) => ScreenSecurityObj.fromMap(data)).toList());
  }

  addDefaultObjectList({required List<DefaultsObj> objects}) async {
    await DBHelper().insertDefaultObjectList(objects);
  }

  addMenuSecurityObjectList({required List<MenuSecurityObj> objects}) async {
    await DBHelper().insertMenuSecurityObjectList(objects);
  }

   addScreenSecurityObjectList({required List<ScreenSecurityObj> objects}) async {
    await DBHelper().insertScreenSecurityObjectList(objects);
  }

  deleteDefaultObjTable() async {
    await DBHelper().deleteDefaultObjTable();
  }
  deleteMenuSecurityTable() async {
    await DBHelper().deleteMenuSecurityObjTable();
  }
  deleteScreenSecurityTable() async {
    await DBHelper().deleteScreenSecurityObjTable();
  }
}
