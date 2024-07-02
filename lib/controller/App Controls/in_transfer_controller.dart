import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/create_transfer_in_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/model/transfer_by_id_model.dart';
import 'package:axolon_inventory_manager/model/transfer_to_accept_model.dart';

import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_list_model.dart';
import 'home_controller.dart';
import 'login_controller.dart';

class InTransferController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  final sysDocListController = Get.put(SysDocListController());
  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  var sysDocIdController = TextEditingController().obs;
  var locationToController = TextEditingController().obs;
  var transferDateController = TextEditingController().obs;
  var totalTransferQuantityController = TextEditingController(text: "0.0").obs;
  var totalAcceptedQuantityController = TextEditingController(text: "0.0").obs;
  var totalShortQuantityController = TextEditingController(text: "0.0").obs;
  var recieveDateController = TextEditingController(
          text: DateFormatter.dateFormat.format(DateTime.now()))
      .obs;

  // var selectedVoucherDate = TextEditingController(text: DateFormatter.dateFormat.format(DateTime.now())).obs;
  var isOpenAccordian = false.obs;
  //var selectedLocationId = 'ADC'.obs;
  var selectedLocation = LocationModel().obs;
  var isAccordionOpen = true.obs;
  var isLoading = false.obs;
  var isSaving = false.obs;
  var locationList = <LocationModel>[].obs;

  var sysDocList = <SysDocModel>[].obs;
  var selectedSysDoc = SysDocModel().obs;
  var vouchersList = <IntransferVoucherModel>[].obs;
  var selectedInTransferVoucher = IntransferVoucherModel().obs;
  var selectedInTransferItemDetail = InventoryTransferDetail().obs;
  var selectedInTransferVoucherbyid = IntransferIdModel().obs;
  var selectedVoucher = ''.obs;
  var selectedSysDocnumber = ''.obs;
  var selectedVoucherDate = ' '.obs;
  var selectedVoucherDateIso = ' '.obs;
  var voucherNumber = ''.obs;

  var selectedValue = 1.obs;
  var itemCode = TextEditingController().obs;
  var product = ProductListModel().obs;

  var selectedTransferTypeid = ' '.obs;
  var selectedVoucherLocationFrom = ' '.obs;
  var selectedVoucherLocationTo = ' '.obs;
  // var selectedTransferType = ''.obs;
  var transferItemList = <InventoryTransferDetail>[].obs;
  var transferTypeList = <TransferTypeModel>[].obs;
  var message = ''.obs;
  var res = 0.obs;
  var transferDetails = [].obs;
  var totalTransferQty = 0.0.obs;
  var selectedDateView = ' '.obs;
  var selectedDate = ' '.obs;
  var totalAcceptedQty = 0.0.obs;
  var totalShortQty = 0.0.obs;
  var acceptQtyController = TextEditingController().obs;
  var date = DateTime.now().obs;
  var isNewRecord = true.obs;
  var isRejectedRecord = true.obs;
  var selectedTransferType = TransferTypeModel().obs;

  var transferNumber = "Transfer Number".obs;
  // var locationToId = "ADC".obs;
  // var sysdocId = "SCA".obs;
  //var voucherId = "AW000022".obs;

  // DateTime date = DateTime.now();
  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(sysDocType: 20);
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
  }

  selectValue(var value) {
    selectedValue.value = value;
    UserSimplePreferences.setIsCameraDisabled(value as int);
  }

  selectDate(DateTime selectDate) {
    date.value = selectDate;
    update();
  }

  selectLocation(int index) {
    selectedLocation.value = locationList[index];
    update();
  }

  selectSyDoc(int index) {
    selectedSysDoc.value = sysDocList[index];
    voucherNumber.value =
        homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    update();
  }

  openAccordian() {
    isOpenAccordian.value = !isOpenAccordian.value;
    update();
  }

  selectInventoryTransfer(IntransferVoucherModel item) {
    selectedInTransferVoucher.value = item;
    selectedSysDocnumber.value = item.sysDocId ?? "";
    selectedVoucherDate.value = item.date.toString();
    selectedVoucherDateIso.value = item.date.toString();
    selectedVoucherLocationFrom.value = item.from ?? "";
    selectedVoucherLocationTo.value = item.to ?? "";
    selectedTransferTypeid.value = item.type ?? "";

    getTransferById();
  }

  setAcceptedQty(int index, BuildContext context) {
    if (transferItemList[index].quantity >=
        double.parse(acceptQtyController.value.text)) {
      transferItemList[index].acceptedQuantity =
          double.parse(acceptQtyController.value.text);
      acceptQtyController.value.clear();
      // Get.back();
      Navigator.pop(context);
    } else {
      SnackbarServices.errorSnackbar(
          'Accepted quantity cannot be greater than transfer quantity');
    }
  }

  getInventoryTransferToAccept(BuildContext context) async {
    if (selectedLocation.value.code == null ||
        selectedLocation.value.code!.isEmpty) {
      SnackbarServices.errorSnackbar('Please Select Location');
      return;
    }
    if (isLoading.value) {
      return;
    }
    isAccordionOpen.value = false;
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    String token = loginController.token.value;
    String locationId = selectedLocation.value.code ?? '';
    // String userLocationName = UserSimplePreferences.getLocation() ?? '';
    //"ADC";
    //selectedLocation.value.code ??'';
    TransferToAcceptModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetInventoryTransferToAccept?token=${token}&locationid=${locationId} ');
      if (feedback != null) {
        result = TransferToAcceptModel.fromJson(feedback);
        vouchersList.value = result.model ?? [];
        update();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getTransferById() async {
    if (selectedInTransferVoucher.value.sysDocId == null ||
        selectedInTransferVoucher.value.number == null ||
        selectedInTransferVoucher.value.sysDocId!.isEmpty ||
        selectedInTransferVoucher.value.number!.isEmpty) {
      SnackbarServices.errorSnackbar(' Selected Value Is Empty');
      return;
    }
    if (isLoading.value) {
      return;
    }
    if (isLoading.value == false) {
      isLoading.value = true;
      await loginController.getToken();
      String sysdoc = selectedInTransferVoucher.value.sysDocId ?? '';
      String voucher = selectedInTransferVoucher.value.number ?? '';
      final String endpoint =
          'GetInventoryTransferById?token=${loginController.token.value}&sysdocid='
          '${sysdoc}&voucherid=${voucher}';
      InventoryTransferByIdModel result;
      try {
        var feedback = await ApiManager.fetchDataCommon(api: endpoint);
        if (feedback != null) {
          result = InventoryTransferByIdModel.fromJson(feedback);
          selectedInTransferVoucherbyid.value = result.model![0];

          transferItemList.value =
              result.model![0].inventoryTransferDetails ?? [];

          transferDateController.value.text = DateFormatter.dateFormat
              .format(selectedInTransferVoucherbyid.value.transactionDate!);

          double totalTransferQuantity =
              result.model![0].inventoryTransferDetails!.fold(0,
                  (previousValue, element) => previousValue + element.quantity);
          totalTransferQuantityController.value.text = "$totalTransferQuantity";

          double totalAcceptedQuantity =
              result.model![0].inventoryTransferDetails!.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + (element.acceptedQuantity ?? 0.0));
          totalAcceptedQuantityController.value.text =
              "${totalAcceptedQuantity}";

          update();
          //feedback.model;
        } else {
          message.value = 'failure';
        }
      } finally {
        isLoading.value = false;
        if (res.value == 1) {
          // transferDetails.value = transferId[0].inventoryTransferDetails;
          calculateTotalTransferQty();
          calculateTotalAcceptedtQty();

          // Get.back();
        } else {
          // Get.back();
          // Get.snackbar('Error', 'No User Found');
        }
      }
    } else {
      SnackbarServices.errorSnackbar(
          'Please wait for the previous request to complete');
    }
  }

  calculateTotalTransferQty() {
    // totalTransferQty.value = 0.0;
    for (var product in transferItemList) {
      totalTransferQuantityController.value.text =
          totalTransferQuantityController.value.text + product.quantity;
    }
  }

  recieveAll() async {
    for (var product in transferItemList) {
      product.acceptedQuantity = product.quantity;
    }
    update();
  }

  calculateTotalAcceptedtQty() {
    //totalAcceptedQty.value = 0.0;
    for (var product in transferItemList) {
      totalAcceptedQuantityController.value.text =
          totalAcceptedQuantityController.value.text + product.acceptedQuantity;
    }
  }

  createIntransfer() async {
    if (selectedInTransferVoucher.value.sysDocId != '') {
      if (transferItemList.isNotEmpty) {
        isSaving.value = true;
        if (loginController.token.value.isEmpty) {
          await loginController.getToken();
        }
        final String token = loginController.token.value;
        String locationId = UserSimplePreferences.getLocationId() ?? '';
        List<CreateInventoryTransferInModel> list = [];
        for (var item in transferItemList) {
          list.add(CreateInventoryTransferInModel(
            remarks: "",
            productId: item.productId ?? "",
            description: item.description ?? "",
            rowIndex: item.rowIndex,
            sourceDocType: item.sourceDocType,
            sourceRowIndex: item.sourceRowIndex,
            listRowIndex: item.listRowIndex,
            listVoucherId: item.listVoucherId,
            listSysDocId: item.listSysDocId,
            acceptedQuantity: item.acceptedQuantity != null
                ? item.acceptedQuantity.toDouble()
                : 0.0,
            sourceVoucherId: item.sourceVoucherId,
            sourceSysDocId: item.sourceSysDocId,
            isSourcedRow: item.isSourcedRow,
            isTrackLot: false,
            isTrackSerial: false,
            acceptedFactor: item.acceptedFactor,
            rejectedQuantity: item.rejectedQuantity,
            rejectedUnitQuantity: item.rejectedUnitQuantity,
            rejectedFactor: item.rejectedFactor,
            quantity: item.quantity != null ? item.quantity.toDouble() : 0.0,
            factor: item.factor,
            factorType: item.factorType,
            rejectedFactorType: item.rejectedFactorType,
            unitId: item.unitId ?? "",
          ));
        }
        final data = json.encode({
          "token": token,
          "IsnewRecord": isNewRecord.value,
          "InventoryTransfer": {
            "SysDocId": selectedInTransferVoucher.value.sysDocId ?? '',
            "VoucherId": selectedInTransferVoucher.value.number ?? '',
            "TransferTypeId": selectedTransferTypeid.value,
            "AcceptReference": "",
            "AcceptSysdocID": selectedSysDoc.value.code,
            "AcceptVoucherID": selectedInTransferVoucher.value.number,
            // voucherId.value,
            "TransactionDate": DateTime.parse(selectedVoucherDateIso.value)
                .toIso8601String()
                .toString(),
            "DivisionId": "",
            "LocationFromId": locationId,
            "LocationToId": selectedLocation.value.code ?? '',

            "VehicleNumber": "",
            "DriverId": "",
            "Reference": "",
            "Description": "",
            "Reason": 0,
            "isRejectedTransfer": false
          },
          "InventoryTransferDetails": list
        });
        log("$data ");
        try {
          var feedback = await ApiManager.fetchCommonDataRawBody(
              api: "CreateTransferIn", data: data);
          log("${feedback} feedback");
          if (feedback != null) {
            if (feedback['res'] == 1) {
              // isNewRecord.value = false;
              SnackbarServices.successSnackbar('Transfer In Created');
              await sysDocListController.updateSysDocVoucher(
                  nextNumber: selectedSysDoc.value.nextNumber!,
                  code: selectedSysDoc.value.code!);
              // SnackbarServices.successSnackbar(
              //     'In Tranfer Ceated and Saved in ${feedback['docNo']}');
              log(selectedSysDoc.value.code.toString());
              // String docNumber = selectedSysDoc.value.numberPrefix != null &&
              //         selectedSysDoc.value.numberPrefix != ''
              //     ? feedback['docNo']
              //         .toString()
              //         .split(selectedSysDoc.value.numberPrefix ?? '')
              //         .toList()[1]
              //     : feedback['docNo'];

              voucherNumber.value =
                  homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
              clearAllData();
            } else {
              SnackbarServices.errorSnackbar(
                  feedback['msg'] ?? feedback['err']);
              voucherNumber.value =
                  homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
              clearAllData();
            }
            isSaving.value = false;
          }
          isSaving.value = false;
        } finally {
          isSaving.value = false;
        }
      }
    }
  }

  clearAllData() {
    selectedInTransferVoucher.update((voucher) {
      voucher?.number = "Transfer Number";
    });
    voucherNumber.value = '';
    transferItemList.clear();
    totalTransferQuantityController.value.clear();
    transferDateController.value.clear();
    totalAcceptedQuantityController.value.clear();
    totalShortQuantityController.value.clear();
    totalAcceptedQty.value = 0.0;
    totalTransferQty.value = 0.0;
    selectedVoucher.value = '';
    fetchDefaults();
    update();
  }
  // getProductList() async {
  //   try {
  //     if (productList.isEmpty) {
  //       await homeController.getProductList();
  //     }
  //     productList.value = homeController.productList;
  //     filterProductList.value = productList;
  //     update();
  //   } catch (e) {
  //     SnackbarServices.errorSnackbar(e.toString());
  //   } finally {
  //
  //   }
  // }
  // var filterProductList = <ProductListModel>[].obs;
  // var productList = <ProductListModel>[].obs;
  // scanToAddIncreaseStockItem(String itemCode) async {
  //   if (productList.isEmpty) {
  //     await getProductList();
  //   }
  //
  //   var stockItem =
  //   productList.firstWhere((element) => element.productId == itemCode,
  //       orElse: () => productList.firstWhere(
  //             (element) => element.upc == itemCode,
  //         orElse: () => ProductListModel(),
  //       )
  //     //    ),
  //   );
  //   if (stockItem.productId != null) {
  //     this.product.value = ProductListModel(
  //       productId: stockItem.productId,
  //       isTrackLot: stockItem.isTrackLot,
  //       unitId: stockItem.unitId,
  //       quantity: stockItem.quantity,
  //       description: stockItem.description,
  //     );
  //     this.itemCode.value.text = this.product.value.productId ?? '';
  //     // }
  //   } else {
  //     // SnackbarServices.errorSnackbar('item could not found');
  //   }
  // }
}
