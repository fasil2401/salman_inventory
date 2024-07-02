import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/refresh_item_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'home_controller.dart';
import 'login_controller.dart';

class ItemDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  var isLoadingProducts = false.obs;
  var res = 0.obs;
  var productImage = ''.obs;
  var itemname = "".obs;
  var stock = 0.0.obs;
  var isRefreshing = false.obs;
  var productId = ''.obs;
  var totalStock = 0.0.obs;
  var selectedmodel = RefreshModel().obs;
  var selectedSearchItem = RefreshItemListModel().obs;
  // var productlocationlist = <RefreshProductlocationmodel>[].obs;
  // var productlocation = RefreshProductlocationmodel().obs;
  // var productunitmodel = RefreshUnitmodel().obs;
  double totalQuantity = 0.0;
  // var productunitmodellist = <RefreshUnitmodel>[].obs;
  // var unitInstanceList = <RefreshUnitmodel>[].obs;
  var model = <RefreshModel>[].obs;

  var selectedproduct = ProductListModel().obs;

  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  final productListController = Get.put(ProductListController());
  var classController = TextEditingController().obs;
  var categoryController = TextEditingController().obs;
  var itemCodeController = TextEditingController().obs;
  var itemNameController = TextEditingController().obs;
  var selectUnitController = TextEditingController().obs;
  var stockController = TextEditingController().obs;
  var price1Controller = TextEditingController().obs;
  var price2Controller = TextEditingController().obs;
  var minimumpriceController = TextEditingController().obs;
  var specialpriceController = TextEditingController().obs;
  var sizeController = TextEditingController().obs;
  var originController = TextEditingController().obs;
  var brandController = TextEditingController().obs;
  var manufacturerController = TextEditingController().obs;
  var styleController = TextEditingController().obs;
  var reorderLevelController = TextEditingController().obs;
  var binController = TextEditingController().obs;
  // var itemCode = TextEditingController().obs;
  var isSelectedClass = false.obs;
  var isSelectedCategory = false.obs;
  var selectedUnit = Unitmodel().obs;
  var productList = <ProductListModel>[].obs;
  var filterProductList = <ProductListModel>[].obs;
  var productLocationList = <Productlocationmodel>[].obs;
  var productUnitList = <Unitmodel>[].obs;
  var classList = [].obs;
  var categoryList = [].obs;
  var stockUnit = "".obs;
  var unitselect = false.obs;
  var stockunit = 0.0.obs;
  var scanItem = 'Scan Item'.obs;
  var selectedValue = 1.obs;
  // var productlist = [].obs;

  var holdSalesToggle = false.obs;
  var isHoldSalesSuccess = false.obs;
  var isErrorHoldSales = false.obs;
  var errorHoldSales = ''.obs;
  var isLoadingHoldSales = true.obs;

  var inactiveToggle = false.obs;
  var isInactiveSuccess = false.obs;
  var isErrorInactive = false.obs;
  var errorInactive = ''.obs;
  var isLoadingInactive = true.obs;

  selectUnit(Unitmodel unit) async {
    selectedUnit.value = unit;
    update();
  }

  toggleHoldSales(bool value, BuildContext context) async {
    holdSalesToggle.value = value;
    holdSales(context);
  }

  toggleInactive(bool value, BuildContext context) {
    inactiveToggle.value = value;

    inactive(context);
  }

  scanItemCode(String itemCode) async {
    ProductListModel product = productList.firstWhere(
      (element) => element.upc == itemCode,
      orElse: () => productList.firstWhere(
          (element) => element.productId == itemCode,
          orElse: () => ProductListModel()),
    );
    if (product.productId != null) {
      this.selectedproduct.value = product;

      this.itemCodeController.value.text =
          this.selectedproduct.value.productId ?? '';
      selectSearchItem(itemCode);
      Get.back();
    } else {
      SnackbarServices.errorSnackbar('item could not found');
    }
  }

  getProductList() async {
    isLoadingProducts.value = true;
    try {
      await homeController.getProductList();
      productList.value = homeController.productList;
      classList.value = productList
          .map((item) => item.modelClass.toString())
          .toList()
          .toSet()
          .toList();
      classList.insert(0, "Set to default");
      categoryList.value = productList
          .map((item) => item.category.toString())
          .toList()
          .toSet()
          .toList();
      categoryList.insert(0, "Set to default");
      categoryList.removeWhere(
          (element) => element.trim() == '' || element.trim() == 'null');
      classList.removeWhere(
          (element) => element.trim() == '' || element.trim() == 'null');
      if (isSelectedClass.value == true) {
        productList.value = productList
            .where(
                (element) => element.modelClass == classController.value.text)
            .toList();
        update();
      }
      if (isSelectedCategory.value == true) {
        productList.value = productList
            .where(
                (element) => element.category == categoryController.value.text)
            .toList();
        update();
      }
      filterProductList.value = productList;
      update();
    } catch (e) {
      SnackbarServices.errorSnackbar(e.toString());
    } finally {
      isLoadingProducts.value = false;
    }
  }

  selectSearchItem(String productid) async {
    update();

    // log("hold==${item.isHold}");
    // log("inactive==${item.isInactive}");
    ProductListModel item =
        await productListController.getProduct(productid: productid);

    itemname.value = item.description ?? "";
    stockUnit.value = item.unitId ?? "";
    classController.value.text = item.modelClass ?? "";
    categoryController.value.text = item.category ?? "";
    itemCodeController.value.text = item.productId ?? "";
    itemNameController.value.text = item.description ?? "";
    productId.value = item.productId ?? "";
    //selectUnitController.value.text=item.se
    price1Controller.value.text = "${item.price1 ?? 0.0}";
    price2Controller.value.text = "${item.price2 ?? 0.0}";
    minimumpriceController.value.text = "${item.minPrice ?? 0.0}";
    specialpriceController.value.text = "${item.specialPrice ?? 0.0}";
    sizeController.value.text = item.size ?? "";
    originController.value.text = item.origin ?? "";
    brandController.value.text = item.brand ?? "";
    manufacturerController.value.text = item.manufacturer ?? "";
    styleController.value.text = item.style ?? "";

    reorderLevelController.value.text = "${item.reorderLevel ?? 0.0}";
    binController.value.text = item.rackBin ?? "";
    //stock.value = item.quantity.toString();
    selectUnitController.value.text = item.unitId.toString();
    stockController.value.text = item.quantity.toString();
    holdSalesToggle.value = item.isHold == 1 ? true : false;
    if (item.isHold == 1) {
      isLoadingHoldSales.value = false;
      isHoldSalesSuccess.value = true;
    }

    inactiveToggle.value = item.isInactive == 1 ? true : false;
    // isLoadingHoldSales.value = false;
    // isHoldSalesSuccess.value = true;

    await productListController.getProductLocationList(
        productId: item.productId ?? '');
    productLocationList.value = productListController.productLocstionList;

    await productListController.getUnitList(productId: item.productId ?? '');
    productUnitList.value = productListController.unitList;
    productUnitList.insert(
        0,
        Unitmodel(
            code: item.unitId,
            name: item.unitId,
            factor: '1',
            factorType: 'M',
            isMainUnit: true));
    selectedUnit.value = productUnitList[0];
    productImage.value =
        await DBHelper().queryProductImage(item.productId ?? "") ?? "";

    update();
  }

  getProductDetails(BuildContext context) async {
    // if (selectedproduct.value.productId == null ||
    //     selectedproduct.value.productId!.isEmpty) {
    //   SnackbarServices.errorSnackbar('Please Select Product');
    //   return;
    // }
    isRefreshing.value = true;
    await loginController.getToken();
    String locationId = UserSimplePreferences.getLocationId() ?? '';
    String endpoint = jsonEncode({
      "token": loginController.token.value,
      "locationid": locationId,
      "productid": itemCodeController.value.text
      //selectedmodel.value.productId,
    });

    RefreshItemListModel result;
    //RefreshModel result;

    try {
      var feedback = await ApiManager.fetchDataRawBodyInventory(
          api: 'GetProductDetails', data: endpoint);

      if (feedback != null) {
        print("feedback==${feedback}");

        result = RefreshItemListModel.fromJson(feedback);
        selectedmodel.value = result.model![0];

        productId.value = itemCodeController.value.text;

        itemNameController.value.text = selectedmodel.value.description ?? "";

        categoryController.value.text = selectedmodel.value.category ?? "";

        itemCodeController.value.text = selectedmodel.value.productId ?? "";

        price1Controller.value.text = selectedmodel.value.price1.toString();

        price2Controller.value.text = selectedmodel.value.price2.toString();

        minimumpriceController.value.text =
            selectedmodel.value.minPrice.toString();

        specialpriceController.value.text =
            selectedmodel.value.specialPrice.toString();

        originController.value.text = selectedmodel.value.origin ?? "";

        brandController.value.text = selectedmodel.value.brand ?? "";

        manufacturerController.value.text =
            selectedmodel.value.manufacturer ?? "";

        productImage.value = selectedmodel.value.productimage ?? "";

        styleController.value.text = selectedmodel.value.style ?? "";

        sizeController.value.text = selectedmodel.value.size ?? "";

        binController.value.text = selectedmodel.value.rackBin ?? "";

        reorderLevelController.value.text =
            selectedmodel.value.reorderLevel.toString();

        //styleController.value.text = selectedmodel.value.toString();
        productLocationList.value = result.productlocationmodel ?? [];
        productUnitList.value = result.unitmodel ?? [];
        productUnitList.insert(
            0,
            Unitmodel(
                code: selectedmodel.value.unitId,
                name: selectedmodel.value.unitId,
                factor: '1',
                factorType: 'M',
                isMainUnit: true));
        selectedUnit.value = productUnitList[0];
        update();
        if (feedback['res'] == 1) {
          SnackbarServices.successSnackbar('Item Refreshed Successfully');
        } else {
          SnackbarServices.errorSnackbar(
              'Error ${feedback['msg'] ?? feedback['err']}');
        }
      } else {
        SnackbarServices.errorSnackbar(
            'Item details Refresh Couldnt Complete!');
      }
    } finally {
      isRefreshing.value = false;
      Navigator.pop(context);
    }
  }

  // productunit() {
  //   for (var product in productunitmodellist) {
  //     productunitmodellist.add(product.code!);
  //       unitInstanceList.add(product);
  //   }
  // }
  clearTotalQuantity() {
    double totalQuantity = 0.0;
  }

  clearProductList() {
    productLocationList.clear();
    clearTotalQuantity();
  }

  clearValues() {
    scanItem.value = "Scan Item";
    itemname.value = '';
    classController.value..clear();
    itemNameController.value.clear();
    if (isSelectedCategory.value != true) {
      categoryController.value.text = "";
    }

    stock.value = 0.0;
    totalQuantity = 0.0;
    clearProductList();
    price1Controller.value.text = 0.0.toString();
    price2Controller.value.text = 0.0.toString();
    minimumpriceController.value.text = 0.0.toString();
    specialpriceController.value.text = 0.0.toString();
    selectUnitController.value.clear();

    if (isSelectedClass.value != true) {
      itemNameController.value.text = '';
    }
    brandController.value.text = '';
    manufacturerController.value.text = '';
    selectedUnit.value = Unitmodel();
    styleController.value.text = '';
    productImage.value = '';
    originController.value.text = '';
    totalStock.value = 0.0;
    stockController.value.text = 0.0.toString();
    sizeController.value.text = '';
    binController.value.text = '';
    reorderLevelController.value.text = 0.0.toString();
    // itemCodeController.value.clear();
    itemCodeController.value.text = "";
    update();
  }

  selectValue(var value) {
    selectedValue.value = value;
    UserSimplePreferences.setIsCameraDisabled(value as int);
  }

  searchProductList(String value) {
    filterProductList.value = productList
        .where((element) =>
            element.productId
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()) ||
            element.description
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()) ||
            element.upc
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
        .toList();
    update();
  }

  inactive(BuildContext context) async {
    isLoadingInactive.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String itemCode = itemCodeController.value.text;
    final bool isInactive = inactiveToggle.value;
    try {
      var feedback = await ApiManager.fetchData(
        api:
            'UpdateIsInactive?token=$token&productID=${itemCode}&IsInactive=${isInactive}',
      );
      if (feedback["result"] == 1) {
        await productListController.updateProductIsInactive(
            isInactive: inactiveToggle.value == true ? 1 : 0,
            productid: itemCode);
        homeController.productList.clear();
        update();
        isLoadingInactive.value = false;
        isInactiveSuccess.value = true;
      } else {
        SnackbarServices.errorSnackbar('An Error Occured');
        isLoadingInactive.value = false;
        isInactiveSuccess.value = false;
      }
    } finally {}
  }

  holdSales(BuildContext context) async {
    isLoadingHoldSales.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String itemCode = itemCodeController.value.text;
    final bool isHoldSales = holdSalesToggle.value;
    try {
      var feedback = await ApiManager.fetchData(
        api:
            'UpdateSalesHold?token=$token&productID=${itemCode}&IsSaleHold=${isHoldSales}',
      );
      if (feedback["result"] == 1) {
        await productListController.updateProductIsHold(
            isHold: holdSalesToggle.value == true ? 1 : 0, productid: itemCode);
        update();
        isLoadingHoldSales.value = false;
        isHoldSalesSuccess.value = true;
      } else {
        SnackbarServices.errorSnackbar('An Error Occured');
        isLoadingHoldSales.value = false;
        isHoldSalesSuccess.value = false;
      }
    } finally {}
  }
}
