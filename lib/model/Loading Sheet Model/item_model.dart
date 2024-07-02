import 'package:axolon_inventory_manager/model/product_list_model.dart';

class Data {
    String? description;
  ProductListModel? product;
  List<double>? qtyList;

  // List<double>? qtyListnew = [];
  //List<double>? qtyList = [];

  Data(
      {
       this.description,
    this.qtyList,
    this.product,
      // required this.qtyListnew,

      // required this.qtyList,
      });
}
