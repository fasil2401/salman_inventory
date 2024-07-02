import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/party_vendor_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_direct_inventory_transfer_model.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/add_recieve_item_model.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/create_goods_recieve_note_model.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/get_goods_recieve_note_open_list.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/get_grn_by_id_model.dart';
import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class RecieveController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  final partyVendorListController = Get.put(PartyVendorListController());
  final productListController = Get.put(ProductListController());
  final loginController = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  final sysDocListController = Get.put(SysDocListController());
  var filterProductList = <ProductListModel>[].obs;
  var locationList = <LocationModel>[].obs;
  var productList = <ProductListModel>[].obs;
  var productUnitList = <Unitmodel>[].obs;
  var productLocationList = <Productlocationmodel>[].obs;
  var sysDocList = <SysDocModel>[].obs;
  var vendorList = [].obs;
  var recieveItemList = [].obs;
  var itemCode = TextEditingController().obs;
  var quantityControl = TextEditingController().obs;
  var note = TextEditingController().obs;
  var ref1 = TextEditingController().obs;
  var ref2 = TextEditingController().obs;
  var vendorRef = TextEditingController().obs;
  var vehicleName = TextEditingController().obs;
  var remarksController = TextEditingController().obs;
  var lotnumberController = TextEditingController().obs;
  var lotqty = TextEditingController().obs;

  var unitIdCtrl = TextEditingController().obs;
  var selectedDate = DateTime.now().obs;
  var selectedProDate = DateTime.now().obs;
  var selectedExpDate = DateTime.now().obs;
  var selectedLocation = LocationModel().obs;
  var selectedVendor = VendorModel().obs;
  var selectedSysDoc = SysDocModel().obs;
  var selectedItem = ProductListModel().obs;
  var selectedUnit = Unitmodel().obs;
  var product = ProductListModel().obs;
  var isOpenAccordian = false.obs;
  var isLoadingProducts = false.obs;
  var isEditingQuantity = false.obs;
  var isSaving = false.obs;
  var quantityAvailable = 0.0.obs;
  var quantity = 1.0.obs;
  var selectedValue = 1.obs;
  var voucherNumber = ''.obs;
  var isNewRecord = true.obs;
  var dateIndex = 0.obs;
  var isEqualDate = false.obs;
  var isFromDate = false.obs;
  var addLot = false.obs;
  var isToDate = false.obs;
  var fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var toDate = DateTime.now().add(Duration(days: 1)).obs;
  var isOpenListLoading = false.obs;
  var recieveOpenList = <GoodsRecieveNoteOpenModel>[].obs;
  var lotlistItems = <Lotdetail>[].obs;
  var lotlistItemsForGrid = <Lotdetail>[].obs;
  var GRNByIdList = <GetGrnByIdModel>[].obs;

  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.GoodsReceivedNote.value);
    sysDocList.value = sysDocListController.sysDocList;
    selectedSysDoc.value = sysDocList[0];
    voucherNumber.value =
        await homeController.getVoucherNumber(selectedSysDoc.value.code ?? '');
    await getVendorList();
    // selectedVendor.value =
    //     vendorList.isNotEmpty ? vendorList[0] : VendorModel();
    await getLocationList();
    final String? locationId = UserSimplePreferences.getLocationId();
    final LocationModel initialLocation = locationList.firstWhere(
      (location) => location.code == locationId,
      orElse: () => LocationModel(),
    );
    selectedLocation.value = initialLocation;
    update();
  }

  getLocationList() async {
    await homeController.getLocationList();
    locationList.value = homeController.locationList;
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

  selectDates(DateTime date) {
    selectedDate.value = date;
    update();
  }

  selectProDates(DateTime date) {
    selectedProDate.value = date;
    update();
  }

  selectExpDates(DateTime date) {
    selectedExpDate.value = date;
    update();
  }

  selectVendor(int index) {
    selectedVendor.value = vendorList[index];
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

  resetQuantity() {
    quantity.value = 1;
    isEditingQuantity.value = false;
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

  addItem(AddItemRecieveModel inputItem) {
    bool isExist = false;
    if (quantity.value > 0) {
      for (AddItemRecieveModel item in recieveItemList) {
        if (item.product?.productId == inputItem.product?.productId) {
          int index = recieveItemList.indexOf(item);
          List<Unitmodel> unitList = List<Unitmodel>.from(productUnitList);
          recieveItemList[index].updatedQuantity =
              // recieveItemList[index].updatedQuantity +
              inputItem.updatedQuantity;
          recieveItemList[index].updatedUnit = inputItem.updatedUnit;
          recieveItemList[index].unitList = unitList;
          recieveItemList[index].lotList = inputItem.lotList;


          //inputItem.unitList?.toList() ?? [];

          log("${unitList.length}  lenggth");
          // recieveItemList.add(AddItemRecieveModel(
          //     product: item.product,
          //     //unitList: productUnitList,
          //     unitList: unitList,
          //     updatedQuantity: double.parse(quantity.value.toString()),
          //     updatedUnit: selectedUnit.value));

          isExist = true;
          update();
        }
      }
      if (isExist == false) {
        inputItem.unitList = List<Unitmodel>.from(productUnitList);
        recieveItemList.add(inputItem);
      }
      update();
    } else {
      SnackbarServices.errorSnackbar('Quantity must be greater than 0');
    }
  }

  bool isQuantityMatched() {
    double totalQuantity = 0.0;
    for (var lotItem in lotlistItems) {
      totalQuantity += lotItem.quantity ?? 0.0;
    }
    log('Total Quantity: $totalQuantity');
    update();
    return totalQuantity == quantity.value;
  }
  bool isQuantityMatchedForGrid() {
    double totalQuantity = 0.0;
    for (var lotItem in lotlistItemsForGrid) {
      totalQuantity += lotItem.quantity ?? 0.0;
    }
    log('Total Quantity: $totalQuantity');
    update();
    return totalQuantity == quantity.value;
  }

  clearlotData() {
    lotnumberController.value.clear();
    lotqty.value.clear();
    selectedExpDate.value = DateTime.now();
    selectedProDate.value = DateTime.now();
    update();
  }

  getDataToUpdate(AddItemRecieveModel item, List<Unitmodel> units) {
    // productUnitList.clear();
    selectedItem.value = item.product ?? ProductListModel();
    log("first ${productUnitList.toString()}");
    log("second");
    // await Future.delayed(Duration(milliseconds: 100));
    // productUnitList.value = item.unitList ?? [];
    // productUnitList.value = List<Unitmodel>.from(item.unitList ?? []);

    selectedUnit.value = item.updatedUnit ?? Unitmodel();
    log("thitd");
    quantityControl.value.text = "${item.updatedQuantity ?? 0.0}";
    log("fourth");
    quantity.value = item.updatedQuantity ?? 0.0;
    log("fifth");
    remarksController.value.text = item.remarks ?? '';
    log("sixth");
    selectedLocation.value = item.updatedLocation ?? LocationModel();
    log("seventh");
    // quantityAvailable.value = item.availableStock ?? 0.0;
    lotlistItemsForGrid.value = item.lotList ?? [];
    log("8");
    update();
  }

  getLotDataToUpdate(item, int index) {
    lotqty.value.text = item.quantity?.toString() ?? '';

    lotnumberController.value.text = item.lotNumber.toString();
    selectedExpDate.value = item.expDate ?? DateTime.now();
    selectedProDate.value = item.proDate ?? DateTime.now();
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

  deleteItem(int index) {
    recieveItemList.removeAt(index);
    update();
  }

  deleteLotItem(int index) {
    lotlistItems.removeAt(index);
    update();
  }

  updateItem(
    int index,
  ) {
    recieveItemList[index].updatedUnit = selectedUnit.value;
    recieveItemList[index].updatedQuantity =
        double.parse(quantity.value.toString());
    recieveItemList[index].updatedLocation = selectedLocation.value;
    update();
  }

  updateLotItem(
    int index,
  ) {
    lotlistItems[index].lotNumber = lotnumberController.value.text;
    lotlistItems[index].quantity = double.parse(lotqty.value.text);
    lotlistItems[index].expDate = selectedExpDate.value;
    lotlistItems[index].proDate = selectedProDate.value;
    update();
  }

  selectLocation(int index) {
    selectedLocation.value = locationList[index];
    update();
  }

  selectUnit(Unitmodel unit) async {
    selectedUnit.value = unit;
    update();
  }

  scanToAddIncreaseStockItem(String itemCode) async {
    if (productList.isEmpty) {
      await getProductList();
    }

    var stockItem =
        productList.firstWhere((element) => element.productId == itemCode,
            orElse: () => productList.firstWhere(
                  (element) => element.upc == itemCode,
                  orElse: () => ProductListModel(),
                )
            //    ),
            );
    if (stockItem.productId != null) {
      this.product.value = ProductListModel(
        productId: stockItem.productId,
        isTrackLot: stockItem.isTrackLot,
        unitId: stockItem.unitId,
        quantity: stockItem.quantity,
        description: stockItem.description,
      );
      // if (directAddItem.value == false) {
      this.unitIdCtrl.value.text = this.product.value.unitId ?? '';
      this.itemCode.value.text = this.product.value.productId ?? '';
      // }
    } else {
      // SnackbarServices.errorSnackbar('item could not found');
    }
  }

  scanToAddStockItem(String itemCode) async {
    if (itemCode.isEmpty) {
      return;
    }
    if (productList.isEmpty) {
      await getProductList();
    }
    ProductListModel product = productList.firstWhere(
      (element) => element.upc == itemCode,
      orElse: () => productList.firstWhere(
          (element) => element.productId == itemCode,
          orElse: () => ProductListModel()),
    );

    if (product.productId != null) {
      log("${product.productId.toString()} product id");

      this.product.value = product;
      unitIdCtrl.value.text = this.product.value.unitId ?? '';
      this.itemCode.value.text = this.product.value.productId ?? '';
      //addingItem(product);
    } else {
      // SnackbarServices.errorSnackbar('item could not found');
    }
  }

  selectValue(var value) {
    selectedValue.value = value;
    UserSimplePreferences.setIsCameraDisabled(value as int);
  }

  resetProduct() {
    product.value = ProductListModel();
    isEditingQuantity.value = false;
    quantity.value = 1;
  }

  createGoodsRecieveNotes() async {
    if (recieveItemList.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Products!');
      return;
    }

    if (selectedVendor.value.code == null) {
      SnackbarServices.errorSnackbar('Please Select Vendor!');
      return;
    }
    final String userLocationId = UserSimplePreferences.getLocationId() ?? '';

    isSaving.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    List<GrnDetail> list = [];
    List<ProductLotReceivingDetail> lotList = [];
    int rowIndex = 0;
    for (AddItemRecieveModel product in recieveItemList) {
      list.add(GrnDetail(
          description: product.product?.description ?? '',
          quantity: product.updatedQuantity?.round() ?? 0,
          rowindex: rowIndex,
          unitId: product.updatedUnit?.code ?? '',
          amount: product.product?.price1 ?? 0,
          cost: 0,
          costcategoryid: "",
          isNew: 0,
          itemcode: product.product?.productId ?? '',
          itemtype: 0,
          jobCategoryid: '',
          jobSubCategoryid: '',
          jobid: '',
          locationid: product.updatedLocation?.code ?? '',
          refDate1: DateTime.now(),
          refNum1: 0,
          refNum2: 0,
          refSlNo: 0,
          refText1: '',
          refText2: '',
          refdate2: DateTime.now(),
          remarks: product.remarks ?? '',
          rowSource: 0,
          specificationId: '',
          styleid: '',
          taxGroupId: product.product?.taxGroupId ?? '',
          taxoption: int.parse(product.product?.taxOption ?? '0'),
          unitprice: product.product?.price1 ?? 0));

      for (var lots in product.lotList ?? []) {
        lotList.add(ProductLotReceivingDetail(
            lotNumber: lots.lotNumber ?? "",
            expiryDate: lots.expDate ?? DateTime.now(),
            productId: product.product?.productId ?? "",
            token: token,
            sysdocid: selectedSysDoc.value.code,
            voucherid: voucherNumber.value,
            unitId: product.updatedUnit?.code ?? '',
            locationId: product.updatedLocation?.code ?? '',
            refDate1: DateTime.now(),
            sourceLotNumber: "",
            quantity: lots.quantity ?? 0,
            binId: "",
            reference2: "",
            unitPrice: product.product?.price1 ?? 0,
            rowIndex: rowIndex,
            cost: 0,
            soldQty: 0,
            rackId: "",
            lotQty: lots.quantity ?? 0,
            refSlNo: 0,
            refext1: '',
            reftext2: '',
            reftext3: '',
            reftext4: '',
            reftext5: '',
            refNum1: 0,
            refNum2: 0,
            refDate2: DateTime.now()));
      }
      rowIndex++;
    }
    final data = jsonEncode({
      "token": token,
      "Isnewrecord": isNewRecord.value,
      "Sysdocid": selectedSysDoc.value.code,
      "Voucherid": voucherNumber.value,
      "Companyid": "1",
      "Divisionid": "",
      "VendorID": selectedVendor.value.code,
      "TransporterID": "",
      "TermID": "",
      "Transactiondate": selectedDate.value.toIso8601String(),
      "PurchaseFlow": 0,
      "Currencyid": "",
      "Currencyrate": 0,
      "Shippingmethodid": "",
      "Reference": ref1.value.text,
      "Reference2": ref2.value.text,
      "VendorReferenceNo": vendorRef.value.text,
      "Note": note.value.text,
      "Isvoid": false,
      "IsImport": false,
      "Payeetaxgroupid": "",
      "Taxoption": 0,
      "DriverID": "",
      "VehicleID": vehicleName.value.text,
      "Advanceamount": 0,
      "ActivateGRNEdit": true,
      "GRNDetails": list,
      "ProductLotReceivingDetail": lotList,
    });

    try {
      log(data.toString(), name: 'data');
      var feedback = await ApiManager.fetchDataRawBodyvendor(
          api: 'CreateGoodsReceiveNote', data: data);
      // log(feedback.toString(), name: 'feedback');
      if (feedback != null) {
        // log(feedback.toString(), name: 'data');
        if (feedback['res'] == 1) {
          recieveItemList.clear();
          lotlistItems.clear();
          // getSalesOrderPdf(voucherNumber.value);
          clearData();
          SnackbarServices.successSnackbar('Successfully updated in Server');
        } else {}
      }
    } finally {
      isSaving.value = false;
    }
  }

  getSalesOrderPdf(
    String voucher,
  ) async {
    final String token = loginController.token.value;
    final String sysDoc = selectedSysDoc.value.code.toString();
    var data = jsonEncode({
      "FileName": "Purchase Receipt",
      "SysDocType": SysdocType.GoodsReceivedNote.value,
      "FileType": 1
    });
    var result;
    log("${data} ${sysDoc} ${voucher} ${token} approve");
    try {
      var feedback = await ApiManager.fetchDataRawBodyReport(
          api:
              'GetApprovalPreview?token=${token}&SysDocID=${sysDoc}&VoucherID=${voucher}',
          data: data);
      if (feedback != null) {
        if (feedback['Modelobject'] != null &&
            feedback['Modelobject'].isNotEmpty) {
          Uint8List bytes = await base64.decode(feedback['Modelobject']);
          printUint8ListPdf(bytes);
          return bytes;
        } else {
          if (feedback['result'] != null && feedback['result'] == 0) {
            SnackbarServices.errorSnackbar(feedback['msg'].toString());
          }
        }
      }
    } finally {}
  }

  Future<void> printUint8ListPdf(Uint8List pdfBytes) async {
    try {
      Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfBytes);
    } catch (e) {
      print('Printing error: $e');
    }
  }

  clearData() {
    isNewRecord.value = true;
    note.value.clear();
    ref1.value.clear();
    ref2.value.clear();
    vendorRef.value.clear();
    vehicleName.value.clear();
    selectedVendor.value.code = null;

    fetchDefaults();
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

  getRecieveReportOpenList() async {
    if (isOpenListLoading.value == true) {
      return;
    }
    isOpenListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String fromDate = this.fromDate.value.toIso8601String();
    final String toDate = this.toDate.value.toIso8601String();
    dynamic result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetGRNOpenList?token=$token&fromDate=$fromDate&toDate=$toDate&showVoid=false&includeLocal=true&includeImport=false&sysDocID=${selectedSysDoc.value.code}');
      if (feedback != null) {
        log(feedback.toString());
        recieveOpenList.clear();
        result = GetGoodsRecieveNoteListModel.fromJson(feedback);
        recieveOpenList.value = result.modelobject;
        recieveOpenList.value = recieveOpenList.reversed.toList();
        isOpenListLoading.value = false;
        update();
      }
    } finally {
      isOpenListLoading.value = false;
    }
  }

  getGRNById({
    required GoodsRecieveNoteOpenModel item,
  }) async {
    if (isOpenListLoading.value == true) {
      return;
    }
    isOpenListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    GetGrnByIdModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetGRNByID?token=${token}&sysDocID=${item.docId ?? ''}&voucherID=${item.docNumber ?? ''}');
      if (feedback != null) {
        log(feedback.toString());
        result = GetGrnByIdModel.fromJson(feedback);
        // GRNByIdList.value = [result] ;

        if (result.header != null && result.header!.isNotEmpty) {
          if (vendorList.isEmpty) {
            await getVendorList();
          }
          selectedSysDoc.value =
              await getSysdocById(result.header![0].sysDocId!);
          voucherNumber.value = result.header![0].voucherId ?? '';
          selectedDate.value =
              result.header?[0].transactionDate ?? DateTime.now();
          selectedVendor.value = vendorList.firstWhere(
            (element) => element.code == result.header?[0].vendorId,
            orElse: () => VendorModel(),
          );
          note.value.text = result.header?[0].note ?? '';
          ref1.value.text = result.header?[0].reference ?? '';
          ref2.value.text = result.header?[0].reference2 ?? '';
          vendorRef.value.text = result.header?[0].vendorReferenceNo ?? '';
          vehicleName.value.text = result.header?[0].vehicleId ?? '';
          isNewRecord.value = false;
          recieveItemList.clear();
          for (var item in result.detail!) {
            if (locationList.isEmpty) {
              await getLocationList();
            }
            if (productList.isEmpty) {}
            // List<Lotdetail> lotlist = result.lotdetail!
            //     .where((lot) => lot.productId == item.productId)
            //     .map((lot) => Lotdetail(
            //     lotNumber: lot.lotNumber,
            //     expDate: lot.expiryDate,
            //     proDate: lot.productionDate,
            //     quantity: lot.lotQty!.toDouble(),
            // ))
            //     .toList();

            await productListController.getUnitList(
                productId: item.productId ?? '');
            productUnitList.value = productListController.unitList;
            productUnitList.insert(
                0,
                Unitmodel(
                    code: item.unitId,
                    name: item.unitId,
                    factor: '1',
                    factorType: 'M',
                    isMainUnit: true));
            recieveItemList.add(
              AddItemRecieveModel(
                  product: productList.firstWhere(
                      (element) => element.productId == item.productId),
                  remarks: item.remarks ?? '',
                  unitList: productUnitList,
                  updatedLocation: locationList.firstWhere(
                    (element) => element.code == item.locationId,
                  ),
                  updatedQuantity: double.parse("${item.quantity ?? 0}"),
                  // lotList: lotlist,
                  updatedUnit: productUnitList
                      .firstWhere((element) => element.code == item.unitId)),
            );
            // for (var item in recieveItemList) {
            //   List<Lotdetail>? lotlist = item.lotList;
            //
            //   if (lotlist != null && lotlist.isNotEmpty) {
            //     for (var lotdetail in lotlist) {
            //
            //      lotlistItems[index].lotNumber = lotdetail.lotNumber;
            //      lotlistItems[index].expDate = lotdetail.expDate;
            //      lotlistItems[index].proDate = lotdetail.proDate;
            //      lotlistItems[index].quantity = lotdetail.quantity;
            //
            //     }
            //   }
            // }

            // lotlistItems.addAll(lotlist);

            update();
          }
        }

        isOpenListLoading.value = false;
      }
    } finally {
      isOpenListLoading.value = false;
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

  getVendorList() async {
    await partyVendorListController.getPartyVendorList();
    vendorList.value = partyVendorListController.partyVendorList;
  }

  addLotItem(String productId) {
    Lotdetail newItem = Lotdetail(
      lotNumber: lotnumberController.value.text,
      proDate: selectedProDate.value,
      expDate: selectedExpDate.value,
      quantity: double.parse(lotqty.value.text),
      productid: productId,
    );
    update();

    lotlistItems.add(newItem);
    for (var lotItem in lotlistItems) {
      print('Lot Number: ${lotItem.lotNumber}');
      print('Production Date: ${lotItem.proDate}');
      print('Expiration Date: ${lotItem.expDate}');
      print('Quantity: ${lotItem.quantity}');
      print('Product ID: ${lotItem.productid}');
      print('---------------');
    }
    update();
  }
}

double calculateTotalQuantity(List<Lotdetail> lotlistItems) {
  double totalQuantity = 0.0;
  for (var lotItem in lotlistItems) {
    if (lotItem.quantity != null) {
      totalQuantity += lotItem.quantity!;
    }
  }
  return totalQuantity;
}

class Lotdetail {
  String? lotNumber;
  DateTime? proDate;
  DateTime? expDate;
  double? quantity;
  String? productid;

  Lotdetail(
      {this.lotNumber,
      this.proDate,
      this.expDate,
      this.quantity,
      this.productid});
}
