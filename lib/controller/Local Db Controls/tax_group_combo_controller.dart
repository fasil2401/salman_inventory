import 'package:axolon_inventory_manager/model/get_tax_group_list_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/state_manager.dart';

class TaxGroupLocalController extends GetxController {
  final taxGroupList = <TaxGroupComboModel>[].obs;

  Future<void> getTaxGroupList() async {
    final List<Map<String, dynamic>> taxGroups =
        await DBHelper().queryAllTaxGroup();
    taxGroupList.assignAll(
        taxGroups.map((data) => TaxGroupComboModel.fromMap(data)).toList());
  }

  insertTaxGroupList({required List<TaxGroupComboModel> taxGroupList}) async {
    await DBHelper().insertTaxGroupList(taxGroupList);
  }

  deleteTaxGroupTable() async {
    await DBHelper().deleteTaxGroupTable();
  }
}
