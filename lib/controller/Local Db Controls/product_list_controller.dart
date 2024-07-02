import 'dart:developer';

import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  final productList = <ProductListModel>[].obs;
  final unitList = <Unitmodel>[].obs;
  final productLocstionList = <Productlocationmodel>[].obs;

  Future<void> getProductList() async {
    final List<Map<String, dynamic>> products =
        await DBHelper().queryAllProducts();

    productList.assignAll(
        products.map((data) => ProductListModel.fromMap(data)).toList());
  }

  Future<ProductListModel> getProduct({required String productid}) async {
    final List<Map<String, dynamic>> products =
        await DBHelper().queryProduct(productid);
    ProductListModel product = ProductListModel.fromMap(products[0]);
    return product;
    // productList.assignAll(
    //     products.map((data) => ProductListModel.fromMap(data)).toList());
  }

  Future<void> getUnitList({required String productId}) async {
    final List<Map<String, dynamic>> units =
        await DBHelper().queryAllUnits(productId: productId);
    unitList.assignAll(units.map((data) => Unitmodel.fromMap(data)).toList());
  }

  Future<void> getAllUnitList() async {
    final List<Map<String, dynamic>> units =
        await DBHelper().queryAllUnitfromProduct();
    unitList.assignAll(units.map((data) => Unitmodel.fromMap(data)).toList());
  }

  Future<void> getProductLocationList({required String productId}) async {
    final List<Map<String, dynamic>> locations =
        await DBHelper().queryAllProductLocation(productId: productId);
    productLocstionList.assignAll(
        locations.map((data) => Productlocationmodel.fromMap(data)).toList());
  }

  // Future<ProductModel> getProductById(
  //     {required double quantity, required String productId}) async {
  //   final List<Map<String, dynamic>> products = await DBHelper()
  //       .queryProductBasedOnStock(quantity: quantity, productId: productId);
  //   return products.map((data) => ProductModel.fromMap(data)).toList().first;
  // }

  insertProductList({required List<ProductListModel> productList}) async {
    await DBHelper().insertProductList(productList);
  }

  insertProduct({required ProductListModel product}) async {
    await DBHelper().insertProduct(product);
  }

  insertUnitList({required List<Unitmodel> unitList}) async {
    await DBHelper().insertUnitList(unitList);
  }

  insertProductLocationList(
      {required List<Productlocationmodel> productLocationList}) async {
    await DBHelper().insertProductLocationList(productLocationList);
  }

  deleteProductTable() async {
    await DBHelper().deleteProductsTable();
  }

  deleteUnitTable() async {
    await DBHelper().deleteUnitsTable();
  }

  deleteProductLocationTable() async {
    await DBHelper().deleteProductLocationTable();
  }

  updateProductIsHold({
    required int isHold,
    required String productid,
  }) async {
    await DBHelper().updateIsHold(isHold, productid);
  }

  updateProductIsInactive({
    required int isInactive,
    required String productid,
  }) async {
    await DBHelper().updateIsInactive(isInactive, productid);
  }

  Future<void> insertOrUpdateProduct(
      {required ProductListModel product}) async {
    await DBHelper().insertOrUpdateProduct(product);
  }
}
