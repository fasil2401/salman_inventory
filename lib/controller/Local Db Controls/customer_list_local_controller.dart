import 'package:axolon_inventory_manager/model/get_customer_list_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class CustomerListLocalController extends GetxController {
  final customersList = <CustomerModel>[].obs;

  Future<void> getCustomerList() async {
    final List<Map<String, dynamic>> customers =
        await DBHelper().queryAllCustomer();
    customersList.assignAll(
        customers.map((data) => CustomerModel.fromMap(data)).toList());
  }

  insertCustomerList({required List<CustomerModel> customerList}) async {
    await DBHelper().insertCustomerList(customerList);
  }

  deleteCustomerTable() async {
    await DBHelper().deleteCustomerTable();
  }
}
