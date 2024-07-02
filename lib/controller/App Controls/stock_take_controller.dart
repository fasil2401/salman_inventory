import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/draft_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/stock_snapshot_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/list_stock_snapshot_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_byid_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_header_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_take_save_detail_model.dart';
import 'package:axolon_inventory_manager/model/draft_items_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTakeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  final stockSnapshotLocalController = Get.put(StockSnapshotLocalController());
  final sysDocListController = Get.put(SysDocListController());
  final loginController = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  final draftListController = Get.put(DraftListController());

  var selectedSysDoc = SysDocModel().obs;
  var descriptionController = TextEditingController().obs;
  var searchController = TextEditingController().obs;
  var quantityControl = TextEditingController().obs;
  var description = TextEditingController().obs;
  var selectedValue = 1.obs;
  var fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  DateTime date = DateTime.now();
  var toDate = DateTime.now().add(Duration(days: 1)).obs;
  var transactionDate = ''.obs;
  var dueDate = DateTime.now().obs;
  var dateIndex = 0.obs;
  var isEqualDate = false.obs;
  var isFromDate = false.obs;
  var isToDate = false.obs;
  var isEditingQuantity = false.obs;
  var isLoadingProducts = false.obs;
  var isLoadingItems = false.obs;
  var quantity = 1.0.obs;
  var isLoading = false.obs;
  var stockSnapList = [].obs;
  var filterStockSnapList = [].obs;
  var listSysDocId = ''.obs;
  var listVoucherId = ''.obs;
  var locationId = ''.obs;
  var stockItems = [].obs;
  var physicalQuantity = TextEditingController().obs;
  var sysDocList = <SysDocModel>[].obs;
  var voucherNumber = ''.obs;
  var productList = <ProductListModel>[].obs;
  var filterProductList = <ProductListModel>[].obs;
  var itemCode = TextEditingController().obs;
  var stockCtrl = TextEditingController().obs;
  var unitIdCtrl = TextEditingController().obs;
  var product = ProductListModel().obs;
  var isSaving = false.obs;
  var productUnitList = [].obs;
  var selectedUnit = Unitmodel().obs;
  final productListController = Get.put(ProductListController());
  var physicalqty = 0.0.obs;
  var directAddItem = false.obs;
  var clearDataToggle = false.obs;
  var isDraftsChecked = false.obs;
  var statusList = ["All", "Open", "Processing", "Closed"].obs;
  var selectedStatus = "All".obs;
  var draftList = [].obs;
  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.StockSnapShot.value);
    sysDocList.value = sysDocListController.sysDocList;
    selectedSysDoc.value = sysDocList[0];
    voucherNumber.value =
        homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    // if (selectedSysDoc.value.code != null) {
    //   voucherNumber.value = await getNextVoucher(sysDoc: selectedSysDoc.value);
    // }
    locationId.value = UserSimplePreferences.getLocationId() ?? '';
    update();
  }

  getProductList() async {
    isLoadingProducts.value = true;
    try {
      if (productList.isEmpty) {
        await homeController.getProductList();
      }
      productList.value = homeController.productList;
      filterProductList.value = productList;
      update();
    } catch (e) {
      SnackbarServices.errorSnackbar(e.toString());
    } finally {
      isLoadingProducts.value = false;
    }
  }

  selectValue(var value) {
    selectedValue.value = value;
    UserSimplePreferences.setIsCameraDisabled(value as int);
  }

  editQuantity() {
    isEditingQuantity.value = !isEditingQuantity.value;
  }

  incrementQuantity() {
    isEditingQuantity.value = false;
    quantity.value++;
    update();
  }

  decrementQuantity() {
    isEditingQuantity.value = false;
    if (quantity > 1) {
      quantity.value--;
      update();
    }
  }

  setQuantity(String value) {
    quantity.value = double.parse(value);
  }

  resetQuantity() {
    quantity.value = 1;
    isEditingQuantity.value = false;
    update();
  }

  resetProduct() {
    product.value = ProductListModel();
    isEditingQuantity.value = false;
    quantity.value = 1;
  }

  setPhysicalQty(int index) {
    stockItems[index].physicalQuantity = physicalqty.value;

    draftListController.updateDraftItem(
        productId: stockItems[index].productId,
        draftOption: DraftItemOption.StockTake.value,
        index: listSysDocId.value == '' ? 0 : stockItems[index].rowIndex,
        quantity: physicalqty.value,
        unitId: stockItems[index].unitId);
    physicalqty.value = 0.0;
    update();
  }

  editPhysicalQuantity(String value) {
    if (value.isNotEmpty) {
      physicalqty.value = double.parse(value);
    } else {
      physicalqty.value = 0.0;
    }
  }

  selectUnit(Unitmodel unit) async {
    selectedUnit.value = unit;
    update();
  }

  selectDateRange(int value, int index) async {
    dateIndex.value = index;
    isEqualDate.value = false;
    isFromDate.value = false;
    isToDate.value = false;
    if (value == 16) {
      isFromDate.value = true;
      isToDate.value = true;
    } else if (value == 15) {
      isFromDate.value = true;
      isEqualDate.value = true;
    } else {
      DateTimeRange dateTime = await DateRangeSelector.getDateRange(value);
      fromDate.value = dateTime.start;
      toDate.value = dateTime.end;
    }
  }

  selectDate(context, bool isFrom) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.primary,
              surface: AppColors.white,
              onSurface: AppColors.primary,
            ),
            dialogBackgroundColor: AppColors.mutedBlueColor,
          ),
          child: child!,
        );
      },
    );
    if (newDate != null) {
      isFrom ? fromDate.value = newDate : toDate.value = newDate;
      if (isEqualDate.value) {
        toDate.value = fromDate.value;
      }
    }
    update();
  }

  getListStockSnapShot() async {
    if (isLoading.value) {
      SnackbarServices.errorSnackbar(
          'Please wait for the previous request to complete');
      return;
    }
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    String userLocation = UserSimplePreferences.getLocationId() ?? '';

    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api:
              'GetListActiveStockSnapShot?token=${token}&locationID=$userLocation');
      log("${feedback}");
      if (feedback != null) {
        result = ListStockSnapshotModel.fromJson(feedback);
        stockSnapList.value = result.model;
        filterStockSnapList.value = stockSnapList;
        selectedStatus.value = 'All';
        filterStockSnapListAll();
        // searchStockSnap(
        //   "",
        // );
      }
    } finally {
      isLoading.value = false;
    }
  }

  getStockSnapShotById(StockSnapShot stockSnapShot) async {
    listSysDocId.value = stockSnapShot.sysDocId ?? "";
    selectedSysDoc.value.code = stockSnapShot.sysDocId ?? "";
    voucherNumber.value = stockSnapShot.voucherId ?? '';
    listVoucherId.value = stockSnapShot.voucherId ?? "";
    transactionDate.value = stockSnapShot.transactionDate.toString();
    locationId.value = stockSnapShot.locationId ?? "";
    descriptionController.value.text = stockSnapShot.description ?? "";
    if (isLoadingItems.value) {
      SnackbarServices.errorSnackbar(
          'Please wait for the previous request to complete');
      return;
    }
    isLoadingItems.value = true;
    stockItems.clear();
    update();
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final data = jsonEncode({
      "token": loginController.token.value,
      "sysDocID": stockSnapShot.sysDocId!,
      "voucherID": stockSnapShot.voucherId!
    });
    dynamic result;
    try {
      var feedback = await ApiManager.fetchDataRawBodyInventory(
        api: 'GetStockSnapShotByID',
        data: data,
      );
      log("${feedback} feedback");
      if (feedback != null) {
        result = StockSnapshotByIdModel.fromJson(feedback);
        stockItems.value = result.details;
        draftListController.insertStockDraftItemList(
            items: result.details, header: result.model[0]);

        update();
      }
    } finally {
      isLoadingItems.value = false;
      update();
    }
  }

  filterStockSnapListAll() {
    filterStockSnapList.value = stockSnapList
        .where((element) =>
            (element.planedDate ?? element.transactionDate)
                .isAfter(fromDate.value) &&
            (element.planedDate ?? element.transactionDate)
                .isBefore(toDate.value) &&
            (element.sysDocId.toLowerCase().contains(
                    searchController.value.text.trim().toLowerCase()) ||
                element.voucherId.toLowerCase().contains(
                    searchController.value.text.trim().toLowerCase())) &&
            (selectedStatus.value != "All"
                ? element.status.toLowerCase() == selectedStatus.toLowerCase()
                : true))
        .toList();
    update();
  }

  updateUi() async {
    stockItems.clear();
    listSysDocId.value = '';
    // sysDocId.value = '';
    listVoucherId.value = '';
    voucherNumber.value = '';
    transactionDate.value = '';
    locationId.value = '';
    description.value.clear();
    selectedStatus.value = "Select";
    searchController.value.clear();
    descriptionController.value.clear();
    // sysdocIndex.value = 0;
    fetchDefaults();
    // getDocId();
    // await enterStockTake();
  }

  selectSyDoc(int index) async {
    String currentSysDoc = selectedSysDoc.value.code ?? '';
    selectedSysDoc.value = sysDocList[index];
    voucherNumber.value =
        await homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    draftListController.updateDraftItemSysDoc(
        newSysDoc: selectedSysDoc.value.code ?? '',
        voucherId: voucherNumber.value,
        sysDocId: currentSysDoc);
    update();
  }

  addStockItem(StockDetailModel stockItem) {
    bool isExist = false;
    // log(stockItem.productId.toString(), name: 'stock Item increse item code');
    for (var item in stockItems) {
      if (item.productId == stockItem.productId) {
        int index = stockItems.indexOf(item);
        // int rowIndex = stockItems[index].rowIndex ?? 0;
        // stockItems[index] = StockDetailModel(
        //     description: item.description,
        //     productId: item.productId,
        //     quantity: item.quantity != null ? item.quantity.toDouble() : 0.0,
        //     physicalQuantity:
        //         item.physicalQuantity + stockItem.physicalQuantity,
        //     unitId: item.unitId,
        //     rowIndex: rowIndex,
        //     isTrackLot: item.isTrackLot == 0 ? false : true);
        stockItems[index].physicalQuantity =
            item.physicalQuantity + stockItem.physicalQuantity;
        stockItems[index].unitId = item.unitId;
        draftListController.updateDraftItem(
            productId: item.productId,
            draftOption: DraftItemOption.StockTake.value,
            index: listSysDocId.value == '' ? 0 : stockItems[index].rowIndex,
            quantity: stockItems[index].physicalQuantity,
            unitId: item.unitId);
        isExist = true;
      }
    }
    // log("${isExist} idExist");
    if (isExist == false) {
      if (listSysDocId.value == '') {
        stockItems.add(stockItem);
        draftListController.insertStockDraftItem(
            item: stockItem,
            header: StockHeaderModel(
              locationId: locationId.value,
              sysDocId: selectedSysDoc.value.code,
              voucherId: voucherNumber.value,
              description: descriptionController.value.text,
              isNewRecord: true,
            ));
      }
    }
    update();
  }

  scanToAddIncreaseStockItem(String itemCode) async {
    if (productList.isEmpty) {
      await getProductList();
    }

    var stockItem =
        await productList.firstWhere((element) => element.productId == itemCode,
            orElse: () => productList.firstWhere(
                  (element) =>
                      element.upc.toString() == itemCode &&
                      element.upc.toString().isNotEmpty,
                  orElse: () => ProductListModel(productId: null),
                )
            //    ),
            );
    log(stockItem.unitId.toString(), name: 'stock Item incresw');
    if (stockItem.productId != null) {
      this.product.value = ProductListModel(
        productId: stockItem.productId,
        isTrackLot: stockItem.isTrackLot,
        unitId: stockItem.unitId,
        quantity: stockItem.quantity,
        description: stockItem.description,
      );
       this.unitIdCtrl.value.text = this.product.value.unitId ?? '';
      if (directAddItem.value == false) {
       
        this.itemCode.value.text = this.product.value.productId ?? '';
      }
    } else {
      // SnackbarServices.errorSnackbar('item could not found');
    }
  }

  // scanToAddIncreaseStockItem(String itemCode) {
  //   log(itemCode.toString(), name: 'Item COde scanToAddIncreaseStockItem');

  //   ProductListModel stockItem =
  //       productList.firstWhere((element) => element.productId == itemCode,
  //           orElse: () => productList.firstWhere(
  //                 (element) => element.upc == itemCode,
  //                 orElse: () => ProductListModel(),
  //               )
  //           //    ),
  //           );
  //   // log("${stockItem.productId}proiddddd");
  //   // log("${stockItem}pListtt");

  //   log(stockItem.toString());
  //   if (stockItem.productId != null) {
  //     this.product.value = ProductListModel(
  //       productId: stockItem.productId,
  //       isTrackLot: stockItem.isTrackLot,
  //       unitId: stockItem.unitId,
  //       quantity: stockItem.quantity,
  //       description: stockItem.description,
  //     );
  //     this.unitIdCtrl.value.text = this.product.value.unitId ?? '';
  //     this.itemCode.value.text = this.product.value.productId ?? '';
  //   } else {
  //     SnackbarServices.errorSnackbar('item could not found');
  //   }
  // }

  scanToAddStockItem(String itemCode) async {
    if (itemCode.isEmpty) {
      return;
    }
    if (productList.isEmpty) {
      await getProductList();
    }
    ProductListModel product = await productList.firstWhere(
      (element) =>
          element.upc.toString() == itemCode &&
          element.upc.toString().isNotEmpty,
      orElse: () => productList.firstWhere(
          (element) => element.productId == itemCode,
          orElse: () => ProductListModel(productId: null)),
    );

    log(product.unitId.toString(), name: 'stock Item add');

    if (product.productId != null) {
      this.product.value = product;
        unitIdCtrl.value.text = this.product.value.unitId ?? '';
      if (directAddItem.value == false) {
      
        this.itemCode.value.text = this.product.value.productId ?? '';
      }
      //addingItem(product);
    } else {
      // SnackbarServices.errorSnackbar('item could not found');
    }
  }

//   scanToAddStockItem(String itemCode) {
//     log(itemCode.toString(), name: 'Item Code scanToAddStockItem');

//     ProductListModel product;
//     try {
//         product = productList.firstWhere(
//           (element) => element.upc == itemCode || element.productId == itemCode,
//           orElse: () => throw Exception('Product not found'),
//         );
//     } catch (e) {
//         // Handle the case when product is not found
//         SnackbarServices.errorSnackbar('Item could not be found');
//         return;
//     }

//     if ( product.productId != null) {
//         log("${product.productId} product id");

//         this.product.value = product;
//         unitIdCtrl.value.text = this.product.value.unitId ?? '';
//         this.itemCode.value.text = this.product.value.productId ?? '';
//         // addingItem(product);
//     } else {
//         // Handle the case when the product or its ID is null
//         SnackbarServices.errorSnackbar('Invalid product or ID');
//     }
// }

//  scanToAddStockItem(String itemCode) {
//     log(itemCode.toString(), name: 'Item COde scanToAddStockItem');
//     var product = productList.firstWhere(
//           (element) => element.upc == itemCode,
//       orElse: () => productList.firstWhere(
//               (element) => element.productId == itemCode,
//           orElse: () => ProductListModel()),
//     );
//     if (product != ProductListModel) {
//       this.product.value = product;
//       unitIdCtrl.value.text = this.product.value.unitId ?? '';
//       this.itemCode.value.text = this.product.value.productId ?? '';
//       //addingItem(product);
//     } else {
//       SnackbarServices.errorSnackbar('item could not found');
//     }
//   }

  createStockSnapshot() async {
    if (isSaving.value) {
      return;
    }
    if (stockItems.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Items to Continue');
      return;
    }
    log("${voucherNumber.value}");
    if (voucherNumber.value == '') {
      SnackbarServices.errorSnackbar('Please Select SysDoc');
      return;
    }
    final String location = UserSimplePreferences.getLocationId() ?? '';
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    List<StockTakeSaveDetailModel> list = [];
    int rowIndex = 1;
    for (var product in stockItems) {
      list.add(StockTakeSaveDetailModel(
          itemcode: product.productId,
          onhand: product.quantity,
          physicalqty: product.physicalQuantity,
          description: product.description,
          unitid: product.unitId,
          remarks: product.remarks,
          rowindex: rowIndex));
      rowIndex++;
    }

    final data = json.encode({
      "token": token,
      "sysdocid": selectedSysDoc.value.code,
      "voucherid": voucherNumber.value,
      "companyid": null,
      "divisionid": null,
      "locationid": locationId.value,
      "adjustmenttype": "SAM",
      "refrence": null,
      "description": descriptionController.value.text,
      "isnewrecord": listSysDocId.value == '' ? true : false,
      "Status": StockSnapShotStatus.Open.value,
      //Status testing for persist snapshot in open list
      // "Status": listSysDocId.value == ''
      //     ? StockSnapShotStatus.Open.value
      //     : StockSnapShotStatus.Closed.value,
      "transactiondate": listSysDocId.value == ''
          ? DateTime.now().toIso8601String().toString()
          : DateTime.parse(transactionDate.value).toIso8601String().toString(),
      "details": list
    });
    log(data, name: 'Stock Take data');
    try {
      isSaving.value = true;
      var feedback = await ApiManager.fetchDataRawBodyInventory(
        api: 'CreateStockSnapShot',
        data: data,
      );
      if (feedback != null) {
        if (feedback['res'] == 1) {
          if (listSysDocId.value == '') {
            await sysDocListController.updateSysDocVoucher(
                nextNumber: selectedSysDoc.value.nextNumber!,
                code: selectedSysDoc.value.code!);
          }
          updateUi();
          draftListController.deleteDraftItemList(
              draftOption: DraftItemOption.StockTake.value);
          SnackbarServices.successSnackbar(
              'Created Successfully in ${feedback['docNo']}');
        } else {
          SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
        }
      } else {}
    } finally {
      isSaving.value = false;
    }
  }

  filterProduct(String value) {
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

  addingItem(ProductListModel item) async {
    quantity.value = 1.0;
    stockCtrl.value.text = "${item.quantity ?? 0.0}";
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
    unitIdCtrl.value.text = productUnitList[0].code ?? '';
    update();
  }

  saveStockSnapshotInLocal() async {
    if (isSaving.value) {
      return;
    }
    if (stockItems.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Items to Continue');
      return;
    }
    isSaving.value = true;
    if (voucherNumber.value != '') {
      final String location = UserSimplePreferences.getLocationId() ?? '';
      final header = StockSnapshotHeaderModel(
        adjustmenttype: "SAM",
        token: loginController.token.value,
        isSynced: 0,
        error: '',
        isError: 0,
        sysdocid: selectedSysDoc.value.code,
        voucherid: voucherNumber.value,
        companyid: null,
        divisionid: null,
        locationid: locationId.value == '' ? location : locationId.value,
        refrence: null,
        description: descriptionController.value.text,
        isnewrecord: listSysDocId.value == '' ? 1 : 0,
        status: StockSnapShotStatus.Open.value,
        //Status testing for persist snapshot in open list
        // status: listSysDocId.value == ''
        //     ? StockSnapShotStatus.Open.value
        //     : StockSnapShotStatus.Closed.value,
        transactiondate: listSysDocId.value == ''
            ? DateTime.now().toIso8601String().toString()
            : DateTime.parse(transactionDate.value)
                .toIso8601String()
                .toString(),
      );
      var detailRowindex = 0;
      List<StockTakeSaveDetailModel> list = [];
      int rowIndex = 1;
      for (var product in stockItems) {
        list.add(StockTakeSaveDetailModel(
            itemcode: product.productId,
            onhand: product.quantity,
            physicalqty: product.physicalQuantity,
            description: product.description,
            unitid: product.unitId,
            listvoucherid: voucherNumber.value,
            listsysdocid: selectedSysDoc.value.code,
            remarks: product.remarks,
            listrowindex: detailRowindex,
            rowindex: rowIndex));
        rowIndex++;
        detailRowindex++;
      }
      await stockSnapshotLocalController.insertStockSnapshotHeaders(
          header: header);
      await stockSnapshotLocalController.insertStockSnapshotDetails(
          detail: list);
      await stockSnapshotLocalController.getStockSnapshotHeaders();
      await stockSnapshotLocalController.getStockSnapshotDetails(
          voucher: voucherNumber.value);
      log("${stockSnapshotLocalController.stockSnapshotHeaders}",
          name: "header");
      log("${stockSnapshotLocalController.stockSnapshotDetail}",
          name: "detail");
      if (listSysDocId.value == '') {
        await sysDocListController.updateSysDocVoucher(
            nextNumber: selectedSysDoc.value.nextNumber!,
            code: selectedSysDoc.value.code!);
      }
      isSaving.value = false;
      //getDocId();
      updateUi();
      draftListController.deleteDraftItemList(
          draftOption: DraftItemOption.StockTake.value);
      SnackbarServices.successSnackbar('Saved successfully in local');
    } else {
      SnackbarServices.errorSnackbar('Please Select SysDoc');
    }
  }

  toggleDirectAddItem() async {
    directAddItem.value = !directAddItem.value;
    await UserSimplePreferences.setIsDirectAddItemDisabled(
        directAddItem.value == true ? 1 : 0);
    update();
  }

  fetchItems() async {
    stockItems.value =
        draftListController.draftItemList.map(mapObjects).toList();
    if (draftListController.draftItemList[0].isNewRecord == 0) {
      listSysDocId.value = draftListController.draftItemList[0].sysDocId ?? '';
      await sysDocListController.getSysDocListByType(
          sysDocType: SysdocType.StockSnapShot.value);
      List<SysDocModel> list = sysDocListController.sysDocList;
      if (list.isNotEmpty) {
        selectedSysDoc.value = list[0];
      } else {
        selectedSysDoc.value =
            SysDocModel(code: draftListController.draftItemList[0].sysDocId);
      }
      descriptionController.value.text =
          draftListController.draftItemList[0].headerDescription ?? '';
      voucherNumber.value =
          draftListController.draftItemList[0].voucherId ?? '';
      locationId.value = draftListController.draftItemList[0].locationId ?? '';
      transactionDate.value =
          draftListController.draftItemList[0].transactionDate ?? '';
    }

    update();
  }

  StockDetailModel mapObjects(DraftItemListModel sourceObject) {
    // Perform the mapping logic here
    String productId = sourceObject.productId ?? '';
    double quantity = sourceObject.quantity ?? 0.0;
    double physicalQuantity = sourceObject.updatedQuatity ?? 0.0;
    String description = sourceObject.description ?? '';
    String unitId = sourceObject.updatedUnitId ?? '';
    String remarks = sourceObject.remarks ?? '';
    int rowIndex = sourceObject.index ?? 0;
    // Create and return a new DestinationObject
    return StockDetailModel(
        description: description,
        productId: productId,
        quantity: quantity,
        physicalQuantity: physicalQuantity,
        unitId: unitId,
        remarks: remarks,
        rowIndex: rowIndex);
  }

  getDraftList() async {
    draftList.clear();
    await draftListController.getDraftItemList(
        option: DraftItemOption.StockTake);
    log("${draftListController.draftItemList.isNotEmpty}");
    if (draftListController.draftItemList.isNotEmpty) {
      draftList.value = draftListController.draftItemList;
      update();
    }
  }

  // filterStockSnapshotAccordingToStatus(String value) {
  //   filterStockSnapList.value =
  //       stockSnapList.where((element) => element.status == value).toList();
  //   update();
  // }
}
