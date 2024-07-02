import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/out_transfer_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_transfer_out_detail_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_transfer_out_local_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/out_transfer_product_item_add_model.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/invoice.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/location.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/transaction.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/refresh_item_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/pdf_api.dart';
import 'package:axolon_inventory_manager/utils/pdf_invoice_api.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/add_item_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutTransferController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  final productListController = Get.put(ProductListController());
  final loginController = Get.put(LoginController());
  final sysDocListController = Get.put(SysDocListController());
  final homeController = Get.put(HomeController());
  final createTransferOutLocalController =
      Get.put(CreateOutTransferLocalController());
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
  var selectedTransferType = TransferTypeModel().obs;
  var quantityControl = TextEditingController().obs;
  var stockController = TextEditingController().obs;
  var unitIdController = TextEditingController().obs;
  var voucherNumber = ''.obs;
  var selectedDate = DateTime.now().obs;
  var isLoadingProducts = false.obs;
  var isEditingQuantity = false.obs;
  var quantity = 1.0.obs;
  var productUnitList = <Unitmodel>[].obs;
  var selectedUnit = Unitmodel().obs;
  var selectedItem = ProductListModel().obs;
  var inventoryItemList = <AddItemOutTransferModel>[].obs;
  var quantityAvailable = 0.0.obs;
  var isSaving = false.obs;
  var sysDocId = SysDocModel().obs;
  var itemName = ''.obs;
  var unitId = ''.obs;

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

  getNextVoucher({required SysDocModel sysDoc}) async {
    int lastNumber = await createTransferOutLocalController.getLastVoucher(
          sysDoc: sysDoc,
        ) ??
        0;
    String data = '${lastNumber.toString().padLeft(6, '0')}';

    return data;
  }

  getDocId() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.TransitTransferOut.value);
    selectedSysDoc.value = sysDocListController.sysDocList[0];
    if (selectedSysDoc.value.code != null) {
      voucherNumber.value = await getNextVoucher(sysDoc: selectedSysDoc.value);
    }

    //  homeController.getNextVoucher(sysDoc: sysDocId.value);
    // updateSysDoc();
    update();
  }

  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(sysDocType: 19);
    sysDocList.value = sysDocListController.sysDocList;
    selectedSysDoc.value = sysDocList[0];
    voucherNumber.value =
        homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    await homeController.getLocationList();
    locationList.value = homeController.locationList;
    selectedLocation.value =
        locationList.isNotEmpty ? locationList[0] : LocationModel();
    await homeController.getTransferTypeList();
    transferTypeList.value = homeController.transferTypeList;
    selectedTransferType.value =
        transferTypeList.isNotEmpty ? transferTypeList[0] : TransferTypeModel();

    update();
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

  selectLocation(int index) {
    selectedLocation.value = locationList[index];
    update();
  }

  selectTransferType(int index) {
    selectedTransferType.value = transferTypeList[index];
    update();
  }

  selectDate(DateTime date) {
    selectedDate.value = date;
    update();
  }

  getProductList() async {
    isLoadingProducts.value = true;
    try {
      await homeController.getProductList();
      productList.value = homeController.productList;
      filterProductList.value = productList;
      update();
    } catch (e) {
      SnackbarServices.errorSnackbar(e.toString());
    } finally {
      isLoadingProducts.value = false;
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
                ? element.productId!.toLowerCase().contains(value.toLowerCase())
                : false) ||
            (element.description != null
                ? element.description!
                    .toLowerCase()
                    .contains(value.toLowerCase())
                : false))
        .toList();
    update();
  }

  addItem() {
    if (selectedItem.value.quantity >= quantity.value) {
      if (quantity.value > 0) {
        List<Unitmodel> UnitList = List<Unitmodel>.from(productUnitList);
        inventoryItemList.add(AddItemOutTransferModel(
            product: selectedItem.value,
            //unitList: productUnitList,
            unitList: UnitList,
            updatedQuantity: double.parse(quantity.value.toString()),
            updatedUnit: selectedUnit.value,
            availableStock: selectedItem.value.quantity));
        log("${productUnitList.length} UNITList");
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

  createTransferOut() async {
    if (inventoryItemList.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Products!');
      return;
    }
    if (selectedTransferType.value.code == null) {
      SnackbarServices.errorSnackbar('Please Select TransferType!');
      return;
    }
    if (selectedLocation.value.code == null) {
      SnackbarServices.errorSnackbar('Please Select Location!');
      return;
    }
    final String userLocationId = UserSimplePreferences.getLocationId() ?? '';

    if (userLocationId == selectedLocation.value.code) {
      SnackbarServices.errorSnackbar('Cannot Transfer to Same Location');
      return;
    }

    isSaving.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    //  log("${userLocationId} userLocationId");
    // log("${selectedLocation.value.code} selectedLocation");
    final String token = loginController.token.value;
    List<CreateTransferOutDetailModel> list = [];
    List<InvoiceItem> pdfList = [];
    int rowIndex = 1;
    for (var product in inventoryItemList) {
      list.add(CreateTransferOutDetailModel(
        productId: product.product?.productId ?? '',
        description: product.product?.description ?? '',
        isTrackLot: product.product?.isTrackLot == 1 ? true : false,
        quantity: product.updatedQuantity,
        rowIndex: rowIndex,
        unitId: product.updatedUnit?.code ?? '',
        acceptedQuantity: 0.0,
      ));
      pdfList.add(InvoiceItem(
        number: rowIndex,
        itemCode: product.product?.productId ?? '',
        itemDescription: product.product?.description ?? '',
        unit: product.updatedUnit?.code ?? '',
        transferQty: product.updatedQuantity ?? 0.0,
      ));
      rowIndex++;
    }
    final data = jsonEncode({
      "token": token,
      "IsnewRecord": true,
      "InventoryTransfer": {
        "SysDocId": selectedSysDoc.value.code,
        "VoucherId": voucherNumber.value,
        "TransferTypeId": selectedTransferType.value.code,
        "AcceptReference": null,
        "TransactionDate": selectedDate.value.toIso8601String(),
        "DivisionId": null,
        "LocationFromId": userLocationId,
        "LocationToId": selectedLocation.value.code,
        "VehicleNumber": null,
        "DriverId": null,
        "Reference": null,
        "Description": null,
        "Reason": null,
        "isRejectedTransfer": false
      },
      "InventoryTransferDetails": list
    });

    try {
      //log(data.toString(), name: 'data');
      var feedback = await ApiManager.fetchCommonDataRawBody(
          api: 'CreateTransferOut', data: data);
      if (feedback != null) {
        // log(feedback.toString(), name: 'data');
        if (feedback['res'] == 1) {
          inventoryItemList.clear();
          printInvoice(pdfList);
          SnackbarServices.successSnackbar('Successfully updated in Server');
        } else {}
      }
    } finally {
      isSaving.value = false;
    }
  }

  printInvoice(List<InvoiceItem> pdfList) async {
    final String userLocationId = UserSimplePreferences.getLocationId() ?? '';
    final String userLocationName = UserSimplePreferences.getLocation() ?? '';
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final invoice = Invoice(
        transaction: const Transaction(
          transferNumber: '',
        ),
        location: Location(
            locationTocode: selectedLocation.value.code ?? '',
            locationToname: selectedLocation.value.name ?? '',
            locationFromcode: userLocationId,
            locationFromname: userLocationName),
        info: InvoiceInfo(
          date: date,
          dueDate: dueDate,
          description: 'My description...',
          number: '${DateTime.now().year}-9999',
        ),
        items: pdfList);

    final pdfFile = await PdfInvoiceApi.generate(invoice);
    await PdfApi.openFile(pdfFile);
  }

  saveOutTransferInLocal() async {
    if (inventoryItemList.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Products to Continue');
      return;
    }
    isSaving.value = true;
    await createTransferOutLocalController.deleteOutTransferDetail(
        vouchetId: voucherNumber.value);
    await createTransferOutLocalController.getOutTransferDetails(
        voucher: voucherNumber.value);
    // List<InvoiceItem> pdfList = [];
    final String location = UserSimplePreferences.getLocationId() ?? '';
    double totalQuantity = inventoryItemList.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.updatedQuantity ?? 0.0));
    final header = CreateTransferOutLocalModel(
      isSynced: 0,
      error: 'Syncing Pending',
      isError: 0,
      sysDocId: selectedSysDoc.value.code,
      voucherId: voucherNumber.value,
      transferTypeId: selectedTransferType.value.code,
      transactionDate: selectedDate.value.toIso8601String(),
      locationFromId: location,
      quantity: totalQuantity,
      locationToId: selectedLocation.value.code,
    );
    var detailRowindex = 0;
    var rowIndex = 0;
    List<CreateTransferOutDetailsLocalModel> list = [];

    for (var product in inventoryItemList) {
      list.add(CreateTransferOutDetailsLocalModel(
        productId: product.product?.productId ?? '',
        sysDocId: selectedSysDoc.value.code ?? "",
        voucherId: voucherNumber.value,
        remarks: "",
        rowIndex: rowIndex,
        acceptedQuantity: 0,
        quantity: product.updatedQuantity,
        unitId: product.updatedUnit?.code ?? '',
      ));

      rowIndex++;
      detailRowindex++;
    }
    List<InvoiceItem> pdfList = [];
    int index = 1;
    for (var product in inventoryItemList) {
      pdfList.add(InvoiceItem(
        number: index,
        itemCode: product.product?.productId ?? '',
        itemDescription: product.product?.description ?? "",
        unit: product.updatedUnit?.code ?? '',
        transferQty: product.updatedQuantity ?? 0.0,
      ));
    }

    await createTransferOutLocalController.insertOutTransferHeader(
        header: header);
    await createTransferOutLocalController.insertOutTransferDetails(
        detail: list);
    await createTransferOutLocalController.getOutTransferHeaders();
    await createTransferOutLocalController.getOutTransferDetails(
        voucher: voucherNumber.value);

    // log("${createTransferOutLocalController.outTransferHeaders.last.voucherId}",
    //     name: "header");
    // log("${createTransferOutLocalController.outTransferDetails}",
    //     name: "detail");

    getDocId();
    clearData();
    printInvoice(pdfList);

    isSaving.value = false;
    SnackbarServices.successSnackbar('Saved successfully in local');
  }

  clearData() {
    inventoryItemList.clear();
  }
}
