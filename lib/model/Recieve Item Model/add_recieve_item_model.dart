import 'package:axolon_inventory_manager/controller/App%20Controls/recieve_controller.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/get_products_available_lots_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';

class AddItemRecieveModel {
  AddItemRecieveModel({
    this.product,
    this.unitList,
    this.updatedQuantity,
    this.updatedUnit,
    this.updatedLocation,
    this.remarks,
    this.lotList,
  });

  ProductListModel? product;
  List<Unitmodel>? unitList;
  double? updatedQuantity;
  Unitmodel? updatedUnit;
  LocationModel? updatedLocation;
  String? remarks;
  List<Lotdetail>? lotList;
}
