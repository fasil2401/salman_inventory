import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/get_products_available_lots_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';

class AddItemOutTransferModel {
  AddItemOutTransferModel(
      {this.product,
      this.unitList,
      this.updatedQuantity,
      this.updatedUnit,
      this.availableStock,
      this.availableLots});

  ProductListModel? product;
  List<Unitmodel>? unitList;
  double? updatedQuantity;
  Unitmodel? updatedUnit;
  double? availableStock;
  List<ProductAvailableLots>? availableLots;
}
