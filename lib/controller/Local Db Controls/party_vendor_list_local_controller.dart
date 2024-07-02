import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class PartyVendorListController extends GetxController {
  final partyVendorList = <VendorModel>[].obs;

  Future<void> getPartyVendorList() async {
    final List<Map<String, dynamic>> partyVendors =
        await DBHelper().queryAllVendor();
    partyVendorList.assignAll(
        partyVendors.map((data) => VendorModel.fromMap(data)).toList());
  }

  insertPartyVendorList({required List<VendorModel> partyVendorList}) async {
    await DBHelper().insertVendorList(partyVendorList);
  }

  deletePartyVendorTable() async {
    await DBHelper().deleteVendorTable();
  }
}
