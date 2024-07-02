import 'dart:convert';
import 'dart:developer';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/out_transfer_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/DirectInventoryTeansferModel/get_directinvntry_transfer_byid_model.dart';
import 'package:axolon_inventory_manager/model/DirectInventoryTeansferModel/get_directinvventory_transfer_list_model.dart';
import 'package:axolon_inventory_manager/model/DirectInventoryTeansferModel/get_location_list_model.dart';
import 'package:axolon_inventory_manager/model/DirectInventoryTeansferModel/get_sysdoclist_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_direct_inventory_transfer_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/get_products_available_lots_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/out_transfer_product_item_add_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectInventoryTransferController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  final productListController = Get.put(ProductListController());
  final loginController = Get.put(LoginController());
  final sysDocListController = Get.put(SysDocListController());
  final homeController = Get.put(HomeController());

  var isOpenAccordian = false.obs;

  var productLocationList = <Productlocationmodel>[].obs;
  // var productlocation = RefreshProductlocationmodel().obs;
  var sysDocList = <SysDocModel>[].obs;
  var locationList = <LocationModel>[].obs;
  var transferTypeList = <TransferTypeModel>[].obs;
  var productList = <ProductListModel>[].obs;
  var filterProductList = <ProductListModel>[].obs;
  var selectedSysDoc = SysDocModel().obs;
  var selectedLocation = LocationModel().obs;

  var quantityControl = TextEditingController().obs;
  var stockController = TextEditingController().obs;
  var unitIdController = TextEditingController().obs;
  var notecontroller = TextEditingController().obs;
  var referencecontroller = TextEditingController().obs;
  var lotQuantitycontroller = TextEditingController().obs;
  var voucherNumber = ''.obs;
  var selectedDate = DateTime.now().obs;
  var isLoadingProducts = false.obs;
  var isLoadingOpenList = false.obs;
  var isEditingQuantity = false.obs;
  var quantity = 1.0.obs;
  var productUnitList = <Unitmodel>[].obs;
  var selectedUnit = Unitmodel().obs;
  var selectedItem = ProductListModel().obs;
  var selecteddirectinventory = Detail().obs;
  var selectedavailableLotItem = ProductAvailableLots().obs;
  var directinventorytransferOpenList = <DirectInventoryTransferList>[].obs;

  var inventoryItemList = <AddItemOutTransferModel>[].obs;
  var availableLotsOpenList = <ProductAvailableLots>[].obs;
  var quarantinesysdoclist = <SysDocIDsModel>[].obs;
  var quarantineloctionlist = <QuarantineLocationModel>[].obs;

  var quantityAvailable = 0.0.obs;
  var isSaving = false.obs;
  var isLotsListLoading = false.obs;
  var sysdocListLoading = false.obs;
  var locationListLoading = false.obs;
  var sysDocId = SysDocModel().obs;
  var itemName = ''.obs;
  var unitId = ''.obs;
  var isLoading = false.obs;
  var isNewRecord = true.obs;
  var fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var toDate = DateTime.now().add(Duration(days: 1)).obs;
  var dateIndex = 0.obs;
  var isEqualDate = false.obs;
  var isFromDate = false.obs;
  var isToDate = false.obs;

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
      initialDate: isFrom ? fromDate.value : toDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: Theme.of(context).primaryColor,
              surface: Theme.of(context).primaryColor,
              onSurface: Theme.of(context).primaryColor,
            ),
            dialogBackgroundColor: Theme.of(context).backgroundColor,
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

  scanItem(
    String itemCode,
  ) async {
    log("${productList.length} length");
    await homeController.getProductList();

    ProductListModel product = productList.firstWhere(
      (element) => element.upc == itemCode,
      orElse: () => productList.firstWhere(
          (element) => element.productId == itemCode,
          orElse: () => ProductListModel()),
    );
    log("${product.productId} proiddddd");

    log("${itemCode} itemCode");

    if (product.productId != null) {
      this.selectedUnit.value.code = product.unitId ?? "";
      //this.itemName.value=

      // this.selectedItem.value.description = product.description ?? "";
      this.itemName.value = product.description ?? "";
      log("${itemName} itemName");

      await selectSearchItem(product);
      // addItem();

      // itemName.value = product.description ?? "";
      //  unitId.value = product.unitId ?? "";
    } else {
      SnackbarServices.errorSnackbar('item not found');
    }
  }

  // getNextVoucher({required SysDocModel sysDoc}) async {
  //   int lastNumber = await createTransferOutLocalController.getLastVoucher(
  //         sysDoc: sysDoc,
  //       ) ??
  //       0;
  //   String data = '${lastNumber.toString().padLeft(6, '0')}';

  //   return data;
  // }

  // getDocId() async {
  //   await sysDocListController.getSysDocListByType(
  //       sysDocType: SysdocType.DirectInventoryTransfer.value);
  //   selectedSysDoc.value = sysDocListController.sysDocList[0];
  //   if (selectedSysDoc.value.code != null) {
  //     voucherNumber.value =
  //         await homeController.getVoucherNumber(selectedSysDoc.value.code!);
  //   }

  //   //  homeController.getNextVoucher(sysDoc: sysDocId.value);
  //   // updateSysDoc();
  //   update();
  // }

  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.DirectInventoryTransfer.value);
    sysDocList.value = sysDocListController.sysDocList;
    update();
    await getSysDocList();
    // selectedSysDoc.value = sysDocList[0];
    voucherNumber.value =
        await homeController.getVoucherNumber(selectedSysDoc.value.code!);
    await homeController.getLocationList();
    locationList.value = homeController.locationList;
    update();
    await getLocationList();
    // selectedLocation.value =
    //     locationList.isNotEmpty ? locationList[0] : LocationModel();
    await homeController.getTransferTypeList();
    transferTypeList.value = homeController.transferTypeList;

    update();
  }

  updateVoucher() async {
    voucherNumber.value =
        await homeController.getVoucherNumber(selectedSysDoc.value.code!);
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

  selectSyDoc(int index) {
    selectedSysDoc.value = sysDocList[index];
    voucherNumber.value =
        homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    update();
  }

  selectLocation(int index) async {
    // await getLocationList();
    selectedLocation.value = locationList[index];
    update();
  }

  selectDates(DateTime date) {
    selectedDate.value = date;
    update();
  }

  getProductList() async {
    isLoadingProducts.value = true;
    try {
      await homeController.getProductList();
      productList.value = homeController.productList;
      filterProductList.value = productList;
      // for (var item in productList) {
      //   if (item.isTrackLot == 1) {
      //     log("${item.productId}  ${item.description} item");
      //   }
      // }
      update();
    } catch (e) {
      SnackbarServices.errorSnackbar(e.toString());
    } finally {
      isLoadingProducts.value = false;
    }
  }

  getDirectInventoryTransferList() async {
    if (isLoadingOpenList.value == true) {
      return;
    }
    isLoadingOpenList.value = true;
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String fromDate = this.fromDate.value.toIso8601String();
    final String toDate = this.toDate.value.toIso8601String();
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api:
              'GetDirectInventoryTransferList?token=${token}&fromDate=${fromDate}&toDate=${toDate}&showVoid=false');
      if (feedback != null) {
        // log(feedback.toString());
        directinventorytransferOpenList.clear();
        result = GetDirectInventoryTransferList.fromJson(feedback);
        directinventorytransferOpenList.value = result.model;
        directinventorytransferOpenList.value =
            directinventorytransferOpenList.reversed.toList();
        isLoadingOpenList.value = false;
        update();
      }
    } finally {
      isLoadingOpenList.value = false;
    }
  }

  RxDouble height = 50.0.obs;
  final shouldExpand = false.obs;
  void updateHeight() {
    // Update the height of the TextField based on its content
    shouldExpand.value = notecontroller.value.text.length > 20;
  }

  createDirectinventoryTransfer() async {
    if (inventoryItemList.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Products to Continue');
      return;
    }
    if (isLoading.value == true) {
      return;
    }
    isLoading.value = true;
    isSaving.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    List<DirectInventoryTransferDetail> list = [];
    List<LotDetail> lotList = [];
    String locationId = UserSimplePreferences.getLocationId() ?? '';
    int rowIndex = 0;

    for (var item in inventoryItemList) {
      list.add(DirectInventoryTransferDetail(
        itemcode: item.product!.productId ?? "",
        description: item.product!.description ?? "",
        quantity: item.updatedQuantity ?? 0.0,
        rowindex: rowIndex,
        unitid: item.updatedUnit!.code ?? "",
        unitPrice: 0,
        locationId: locationId,
        sourceVoucherId: "",
        sourceSysDocId: "",
        sourceSysDocType: 0,
        sourceRowIndex: 0,
        remarks: "",
        isSourceRow: true,
      ));
      log("${item.availableLots} lots");
      for (var lots in item.availableLots ?? []) {
        lotList.add(LotDetail(
          token: token,
          sysdocid: selectedSysDoc.value.code,
          voucherid: voucherNumber.value,
          productId: item.product!.productId,
          unitId: item.updatedUnit!.code ?? "",
          fromLocationId: locationId,
          toLocationId: selectedLocation.value.code,
          lotNumber: lots.lotNumber.toString(),
          reference: lots.reference,
          sourceLotNumber: lots.sourceLotNumber.toString(),
          quantity: lots.lotQty ?? 0,
          binId: lots.binId ?? "",
          reference2: lots.reference2 ?? "",
          unitPrice: 0,
          rowIndex: rowIndex,
          cost: 0,
          soldQty: 0,
          lotQty: item.updatedQuantity ?? 0.0,
        ));
        rowIndex++;
      }
    }
    final data = json.encode({
      "token": token,
      "Sysdocid": selectedSysDoc.value.code,
      "SysDocType": SysdocType.DirectInventoryTransfer.value,
      "Voucherid": voucherNumber.value,
      "FromLocationID": locationId,
      "Salespersonid": "",
      "Currencyid": "",
      "TransactionDate": DateTime.now().toIso8601String(),
      "Reference": referencecontroller.value.text,
      "Note": "",
      //notecontroller.value.text,
      "Isvoid": true,
      "Discount": 0,
      // "Total": 0,
      //"IsCompleted": 0,
      "VehicleNo": "",
      "CompanyID": "1",
      "DivisionID": "",
      "Isnewrecord": isNewRecord.value,
      "ToLocationID": selectedLocation.value.code,
      "Description": notecontroller.value.text,
      "DriverID": "",
      "DirectInventoryTransferDetails": list,
      "LotDetails": lotList,
    });
    try {
      log(data.toString());
      var feedback = await ApiManager.fetchDataRawBodyInventory(
          api: 'CreateDirectInventoryTransfer', data: data);
      if (feedback != null) {
        if (feedback['res'] == 1) {
          SnackbarServices.successSnackbar(
              'DirectInventory Trnsfer Ceated and Saved in ${feedback['docNo']}');
          log(selectedSysDoc.value.numberPrefix.toString());

          voucherNumber.value =
              await homeController.getNextVoucher(sysDoc: selectedSysDoc.value);

          clearData();
        } else {
          SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
        }
        isLoading.value = false;
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
      isSaving.value = false;
    }
  }

  Future<SysDocModel> getSysdocById(String sysdoc) async {
    if (sysDocListController.sysDocList.isEmpty) {
      await sysDocListController.getSysDocList();
    }
    SysDocModel doc = await sysDocListController.sysDocList
        .firstWhere((element) => element.code == sysdoc);
    return doc;
  }

  getDirectinventoryTransferById(String sysDoc, String voucher) async {
    if (isLoadingOpenList.value == true) {
      return;
    }
    isLoadingOpenList.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;

    GetDirectInventoryTransferByIdModel result;
    List<Detail> list = [];
    try {
      var feedback = await ApiManager.fetchData(
        api:
            'GetDirectInventoryTransferByID?token=${token}&sysDocID=${sysDoc}&voucherID=${voucher}',
      );
      if (feedback != null) {
        log(feedback.toString());
        result = GetDirectInventoryTransferByIdModel.fromJson(feedback);

        if (result.header != null && result.header!.isNotEmpty) {
          isNewRecord.value = false;
          selectedSysDoc.value =
              await getSysdocById(result.header![0].sysDocId!);
          voucherNumber.value = result.header![0].voucherId.toString() ?? '';
          //selectedSysDoc.value.code = result.header![0].sysDocId.toString();
          referencecontroller.value.text =
              result.header![0].reference.toString();
          notecontroller.value.text = result.header != null &&
                  result.header!.isNotEmpty &&
                  result.header![0].description != null
              ? result.header![0].description.toString()
              : "";
          selectedDate.value =
              result.header![0].transactionDate ?? DateTime.now();

          selectedLocation.value.code = result.header![0].locationToId ?? '';
          referencecontroller.value.text = result.header![0].reference ?? '';
          inventoryItemList.clear();

          for (var item in result.detail ?? []) {
            ProductListModel product = ProductListModel(
              productId: item.productId ?? "",
              unitId: item.unitId ?? "",
              quantity: item.quantity ?? 0,
              isTrackLot: item.isTrackLot == false ? 0 : 1,
              price1: item.price,
              description: item.description ?? "",
            );
            double updatedQuantity = item.quantity!.toDouble();
            Unitmodel updatedUnit = Unitmodel(
              productId: item.productId ?? "",
              factor: item.factor,
              factorType: item.factorType,
              name: item.unitId,
              code: item.unitId,
            );
            List<Unitmodel> unitList = [
              Unitmodel(
                  name: item.unitId,
                  code: item.unitId,
                  productId: item.productId,
                  factor: item.acceptedFactor,
                  factorType: item.acceptedFactorType)
            ];

            List<ProductAvailableLots> lotlist = result.lotReceivedetail!
                .where((lot) => lot.productId == item.productId)
                .map((lot) => ProductAvailableLots(
                      lotNumber: lot.reference != null
                          ? lot.reference
                          : lot.sourceLotNumber,
                      sourceLotNumber: lot.sourceLotNumber,
                      reference: lot.reference,
                      binId: lot.binId,
                      productId: lot.productId,
                      lotQty: lot.lotQty,
                      productionDate: lot.productionDate,
                      expiryDate: lot.expiryDate,
                      reference2: lot.reference2,
                      refSlNo: lot.refSlNo,
                      refText1: lot.refText1,
                      refText2: lot.refText2,
                      refText3: lot.refText3,
                      refText4: lot.refText4,
                      refText5: lot.refText5,
                    ))
                .toList();

            inventoryItemList.add(AddItemOutTransferModel(
              product: product,
              unitList: unitList,
              updatedQuantity: updatedQuantity,
              updatedUnit: updatedUnit,
              availableLots: lotlist,
            ));
          }

          update();
        }
      }
    } finally {
      isLoadingOpenList.value = false;
    }
  }

  getSysDocList() async {
    if (sysdocListLoading.value == true) {
      return;
    }
    sysdocListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    GetQuarantineSysDocIDsModel result;
    try {
      var feedback = await ApiManager.fetchData(
          api: 'GetQuarantineTransferDocuments?token=${token}');
      if (feedback != null) {
        log(feedback.toString());
        // result = GetQuarantineSysDocIDsModel.fromJson(feedback);
        // sysdoclist.value = result.model;

        List<SysDocModel> commonElements = sysDocList
            .where((element) => feedback['Model']
                .map((e) => e['SysDocID'])
                .contains(element.code))
            .toList();
        log("${feedback['Model'][0]['SysDocID']}sysdoclist");
        sysDocList.value = List<SysDocModel>.from(commonElements.map((x) => x));
        selectedSysDoc.value = sysDocList[0];
        sysdocListLoading.value = false;
        update();
      } else {
        sysDocList.value = [];
      }
    } finally {
      sysdocListLoading.value = false;
    }
  }

  getLocationList() async {
    if (locationListLoading.value == true) {
      return;
    }
    locationListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    GetQuarantineLocationModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetQuarantineLocationList?token=${token}');
      if (feedback != null) {
        log(feedback.toString());

        List<LocationModel> commonElement = locationList
            .where((element) =>
                feedback['model'].map((e) => e['Code']).contains(element.code))
            .toList();
        log("${feedback['model'][0]['Code']}Locationlist");
        locationList.value =
            List<LocationModel>.from(commonElement.map((x) => x));
        if (locationList.isNotEmpty) {
          selectedLocation.value = locationList[0];
          update();
        }
        locationListLoading.value = false;
        update();
      }
    } finally {
      locationListLoading.value = false;
    }
  }

  getAvailableLotsProductList() async {
    if (isLotsListLoading.value == true) {
      return;
    }
    isLotsListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String productId = selectedItem.value.productId ?? "";
    String locationId = UserSimplePreferences.getLocationId() ?? '';
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api:
              'GetProductAvailableLots?token=${token}&productID=${productId}&locationID=${locationId}&unitID=${selectedUnit.value.code}');
      if (feedback != null) {
        log(feedback.toString());
        availableLotsOpenList.clear();
        result = GetProductAvailableLotsmModel.fromJson(feedback);
        availableLotsOpenList.value = result.model;
        isLotsListLoading.value = false;
        update();
      }
    } finally {
      isLotsListLoading.value = false;
    }
  }

  openAccordian() {
    isOpenAccordian.value = !isOpenAccordian.value;
    update();
  }

  selectSearchItem(ProductListModel item) async {
    resetQuantity();
    selectedItem.value = item;
    String location = UserSimplePreferences.getLocationId() ?? 'VAN06';
    await productListController.getProductLocationList(
        productId: item.productId ?? '');
    productLocationList = productListController.productLocstionList;
    Productlocationmodel result = productLocationList.firstWhere(
        (element) => element.locationId == location,
        orElse: () => Productlocationmodel());
    if (result.quantity != null) {
      quantityAvailable.value = result.quantity;
    } else {
      quantityAvailable.value = 0.0;
    }
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
    // log("${item.name}  item.unitId");
    selectedUnit.value = productUnitList[0];
    update();
  }

  searchProduct(String value) {
    filterProductList.value = productList
        .where((element) =>
                (element.productId != null
                    ? element.productId!
                        .toLowerCase()
                        .contains(value.toLowerCase())
                    : false) ||
                (element.description != null
                    ? element.description!
                        .toLowerCase()
                        .contains(value.toLowerCase())
                    : false)
            //element.isTrackLot == 1 && element.quantity > 0
            )
        .toList();
    update();
  }

  addItem() {
    if (quantityAvailable.value >= quantity.value) {
      if (quantity.value > 0) {
        List<Unitmodel> UnitList = List<Unitmodel>.from(productUnitList);
        List<ProductAvailableLots> availableLotsList =
            List<ProductAvailableLots>.from(availableLotsOpenList);
        for (var item in availableLotsList) {
          item.acceptedQuantiy = item.controller!.text.isNotEmpty
              ? double.parse(item.controller!.text)
              : 0.0;
        }
        inventoryItemList.add(AddItemOutTransferModel(
            product: selectedItem.value,
            //unitList: productUnitList,
            availableLots: availableLotsList,
            unitList: UnitList,
            updatedQuantity: double.parse(quantity.value.toString()),
            updatedUnit: selectedUnit.value,
            availableStock: quantityAvailable.value));
        log("${productUnitList.length} UNITList");
        log("${availableLotsOpenList.length} availableLotsOpenList");
      } else {
        SnackbarServices.errorSnackbar('Quantity must be greater than 0');
      }
    } else {
      SnackbarServices.errorSnackbar(
          'Quantity must be less than available quantity');
    }

    //  update();
  }

  deleteItem(int index) {
    inventoryItemList.removeAt(index);
    update();
  }

  getDataToUpdate(AddItemOutTransferModel item, List<Unitmodel> units) {
    // productUnitList.clear();
    selectedItem.value = item.product ?? ProductListModel();
    // await Future.delayed(Duration(milliseconds: 100));
    log("first ${productUnitList.toString()}");
    // productUnitList.value = item.unitList ?? [];
    // productUnitList.value = List<Unitmodel>.from(item.unitList ?? []);

    log("second");
    selectedUnit.value = item.updatedUnit ?? Unitmodel();
    log("thitd");
    quantityControl.value.text = "${item.updatedQuantity ?? 0.0}";
    log("fourth");
    quantity.value = item.updatedQuantity ?? 0.0;
    log("fifth");
    quantityAvailable.value = item.availableStock ?? 0.0;
    log("sixth");
    update();
  }

  updateItem(
    int index,
  ) {
    inventoryItemList[index].updatedUnit = selectedUnit.value;
    inventoryItemList[index].updatedQuantity =
        double.parse(quantity.value.toString());
    update();
  }

  clearData() {
    inventoryItemList.clear();
    //fetchDefaults();
    updateVoucher();
    referencecontroller.value.clear();
    notecontroller.value.clear();
    update();
  }
}
