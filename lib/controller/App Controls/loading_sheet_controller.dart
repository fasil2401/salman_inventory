import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/customer_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/customer_sales_person_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/driver_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/loading_sheet_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/party_vendor_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_brand_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_category_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_class_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_origin_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/vehicle_list_local_controller.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/item_model.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/loading_sheet_local_model.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/transaction_by_id_model.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/transactionlist_model.dart';
import 'package:axolon_inventory_manager/model/get_customer_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_location_model.dart';
import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/services/external_json_generator.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Loading%20Sheet%20Screen/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingSheetsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getLoadingSheetListFromLocal();
    //getOPenTransactionList();
  }

  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  final sysDocListController = Get.put(SysDocListController());
  final classListController = Get.put(ClassListController());
  final driverNameListController = Get.put(DriverListController());
  final salesPersonListController = Get.put(SalesPersonListController());
  final vehicleNoListController = Get.put(VehicleListController());
  final categoryListController = Get.put(CategoryListController());
  final brandListController = Get.put(BrandListController());
  final originListController = Get.put(ProductOriginListController());
  final loadingSheetsLocalController = Get.put(LoadingSheetsLocalController());
  final productListLocalController = Get.put(ProductListController());
  final partyVendorListController = Get.put(PartyVendorListController());
  final customerListLocalController = Get.put(CustomerListLocalController());
  var ref1Controller = TextEditingController().obs;
  var ref2Controller = TextEditingController().obs;
  var ref3Controller = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var remarksController = TextEditingController().obs;
  var containerNoController = TextEditingController().obs;
  var classController = TextEditingController().obs;
  var categoryController = TextEditingController().obs;
  var brandController = TextEditingController().obs;
  var originController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var quantityController = TextEditingController(text: "1").obs;
  var productList = <ProductListModel>[].obs;
  var filterProductList = <ProductListModel>[].obs;
  var loadingItemLIst = <OpenList>[].obs;
  var localLoadingItemList = <LoadingSheetsHeaderModel>[].obs;
  var locationList = <LocationModel>[].obs;
  var userLocationList = <UserLocationModel>[].obs;
  var sysDocList = <SysDocModel>[].obs;
  var classList = [].obs;
  var categoryList = [].obs;
  var nameList = [].obs;
  var brandList = [].obs;
  var originList = [].obs;
  var partyList = [].obs;
  var customerList = [].obs;
  var filterPartyList = [].obs;
  var documentTypeList = [].obs;
  var filterDocumentTypeList = [].obs;
  var filterList = [].obs;
  var qtyList = [].obs;
  var salesPersonList = [].obs;
  var vehicleNoList = [].obs;
  var driverNameList = [].obs;
  var selectedDocument = DoccumentType.clear.obs;
  var selectedParty = VendorModel().obs;
  var selectedCustomer = CustomerModel().obs;
  var selectedFromLocation = UserLocationModel().obs;
  var selectedToLocation = LocationModel().obs;
  var selectedProduct = ProductListModel().obs;
  var selectedSalesPerson = ProductCommonComboModel().obs;
  var selectedVehicleNo = ProductCommonComboModel().obs;
  var selectedDriverName = ProductCommonComboModel().obs;
  var sysDocId = SysDocModel().obs;
  var voucherNumber = "".obs;
  var totalQuanity = 0.0.obs;
  var quantity = 1.obs;
  var text = ''.obs;
  var isNewRecord = true.obs;
  var isLoadingProducts = false.obs;
  var isLoading = false.obs;
  var isPartListLoading = false.obs;
  var isSaving = false.obs;
  var isEditingQuantity = false.obs;
  var isloadingDatas = false.obs;
  var isLoadingDataList = false.obs;
  var isUpdate = false.obs;
  var isOpenAccordian = false.obs;
  var completedToggle = false.obs;
  var isCompleted = false.obs;
  var isDataPosting = false.obs;
  var isEditingEditQuantities = false.obs;
  var selectedIndex = 0.obs;
  var editQuantities = 1.obs;
  var isPreviewLoading = false.obs;
  setCompleted({required bool value, required int index}) {
    localLoadingItemList[index].completedToggle = value;

    update();
  }

  getNextVoucher({required SysDocModel sysDoc}) async {
    // String data = '${numberPrefix}${nextNumber.toString().padLeft(6, '0')}';

    int lastNumber = await getLastVoucher(
          sysDoc: sysDoc,
        ) ??
        0;
    log("${lastNumber}prefix data updated");
    String data = '${lastNumber.toString().padLeft(6, '0')}';

    return data;
  }

  Future<int?> getLastVoucher({
    //required String prefix,
    required SysDocModel sysDoc,
    //required int nextNumber
  }) async {
    // log("${sysDoc} prefix");
    final int? lastNumber = await DBHelper().getLastVoucher(
      sysDoc: sysDoc,
    );
    return lastNumber;
  }

  getDocId() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.ItemTransaction.value);
    sysDocList.value = sysDocListController.sysDocList;
    sysDocId.value = sysDocListController.sysDocList[0];
    if (sysDocId.value.code != null) {
      voucherNumber.value = await getNextVoucher(sysDoc: sysDocId.value);

      log(voucherNumber.value + sysDocId.value.lastNumber.toString(),
          name: 'Voucher Number & Prefix');
    }

    //  homeController.getNextVoucher(sysDoc: sysDocId.value);
    // updateSysDoc();
    update();
  }

  updateSysDoc() {
    String data =
        '${sysDocId.value.numberPrefix}${sysDocId.value.nextNumber.toString().padLeft(6, '0')}';
    voucherNumber.value = data;
  }

  selectSyDoc(int index) async {
    sysDocId.value = sysDocList[index];
    voucherNumber.value = await getNextVoucher(sysDoc: sysDocId.value);
    update();
  }

  save() {
    // getNextVoucher(sysDoc: sysDocId.value);
    if (dataList.isNotEmpty) {
      cleardata();
      // sysDocListController.updateSysDocVoucher(
      //     nextNumber: sysDocId.value.nextNumber ?? 0,
      //     code: sysDocId.value.code ?? '');
      getDocId();
    } else {
      SnackbarServices.errorSnackbar("add items");
    }
  }

  getDocumentTypeList() {
    documentTypeList.value = DoccumentType.values
        .where((type) => type != DoccumentType.clear)
        .toList();
    filterDocumentTypeList.value = documentTypeList;
    update();
  }

  getItemList(BuildContext context) async {
    classList.clear();
    brandList.clear();
    categoryList.clear();
    originList.clear();
    nameList.clear();
    isLoadingProducts.value = true;
    isLoading.value = true;
    update();

    if (productList.isEmpty) {
      await productListLocalController.getProductList();
    }
    productList.value = productListLocalController.productList;
    nameList.value = productList;
    isLoadingProducts.value = false;
    update();
    isLoading.value = true;
    getClassList();
    getCategoryList();
    getBrandList();
    getOriginList();
    isLoading.value = false;
    // filterProductList.value = productList;
    //   update();
    // } catch (e) {
    //   SnackbarServices.errorSnackbar(e.toString());
    // } finally {
    //   isLoadingProducts.value = false;
    // }
    // await homeController.getCategoryList(context);
    // categoryList.value = homeController.categoryList;
    update();
  }

  getClassList() async {
    if (classList.isEmpty) {
      await classListController.getClassList();
    }
    classList.value = classListController.classList;
    classList.insert(0, ProductCommonComboModel(code: "Clear"));
    update();
  }

  getCategoryList() async {
    if (categoryList.isEmpty) {
      await categoryListController.getCategoryList();
    }
    categoryList.value = categoryListController.categoryList;
    categoryList.insert(0, ProductCommonComboModel(code: "Clear"));
    update();
  }

  getBrandList() async {
    if (brandList.isEmpty) {
      await brandListController.getBrandList();
    }
    brandList.value = brandListController.brandList;
    brandList.insert(0, ProductCommonComboModel(code: "Clear"));
    update();
  }

  getOriginList() async {
    if (originList.isEmpty) {
      await originListController.getProductOriginList();
    }
    originList.value = originListController.productOriginList;
    originList.insert(0, ProductCommonComboModel(code: "Clear"));
    update();
  }

  // cleardata() {
  //   isSaving.value = false;
  //   brandController.value.clear();
  //   originController.value.clear();
  //   classController.value.clear();
  //   categoryController.value.clear();
  //   nameController.value.clear();
  //   descriptionController.value.clear();
  //   quantityController.value.clear();
  //  // selectedParty.value = CommonComboModel();
  //  // selectedDocument.value = SysdocType.AirLineTicketRequest;
  //   selectedProduct.value = ProductListModel();
  //   quantity.value = 0;
  //   //updateVoucher();
  //   update();
  // }
  cleardata() {
    getDocId();
    isNewRecord.value = true;
    isLoadingDataList.value = false;
    isSaving.value = false;
    isCompleted.value = false;
    getPartyList();
    getCustomerList();
    selectedDocument.value = DoccumentType.clear;
    getLocationList();
    totalQuanity.value = 0;
    dataList.clear();
    isUpdate.value = false;
    addressController.value.clear();
    phoneNumberController.value.clear();
    getSalesPersonList();
    getDriverList();
    getVehicleList();
    containerNoController.value.clear();
    ref1Controller.value.clear();
    ref2Controller.value.clear();
    ref3Controller.value.clear();
    remarksController.value.clear();
    update();
  }

  clearInputValue() {
    brandController.value.clear();
    originController.value.clear();
    classController.value.clear();
    categoryController.value.clear();
    quantity.value = 0;
    nameController.value.clear();
    descriptionController.value.clear();
    selectedProduct.value = ProductListModel();
    quantityController.value.clear();
    isEditingQuantity.value = false;
    update();
  }

  updateVoucher() async {
    voucherNumber.value =
        await homeController.getVoucherNumber(sysDocId.value.code!);
    update();
  }

  getOPenTransactionList() async {
    loadingItemLIst.clear();
    isLoading.value = true;
    update();
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api: 'GetItemTransactionOpenList?token=$token&showVoid=false');
      if (feedback != null) {
        if (feedback["res"] == 1) {
          result = GetTransactionOpenList.fromJson(feedback);
          loadingItemLIst.value = result.model;
          update();
        }
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  getLoadingSheetListFromLocal() async {
    loadingItemLIst.clear();
    isLoading.value = true;
    update();

    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    if (loadingSheetsLocalController.loadingSheetsHeaders.isNotEmpty) {
      localLoadingItemList.value =
          loadingSheetsLocalController.loadingSheetsHeaders;
      update();
    }
    isLoading.value = false;
    update();
  }

  getItemTransactionByID(String sysdoc, String voucher) async {
    isLoading.value = true;
    update();
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api:
              'GetItemTransactionByID?token=$token&sysDocID=${sysdoc}&voucherID=${voucher}');
      if (feedback != null) {
        if (feedback["result"] == 1) {
          result = GetItemTransactionByIdModel.fromJson(feedback);
          sysDocId.value.code = sysdoc;
          voucherNumber.value = voucher;
          Header header = result.header[0];
          if (partyList.isEmpty) {
            await getPartyList();
          }
          selectedParty.value = partyList.firstWhere(
            (element) => element.code == header.partyId,
            orElse: () => VendorModel(),
          );
          if (documentTypeList.isEmpty) {
            await getDocumentTypeList();
          }
          selectedDocument.value = documentTypeList.firstWhere(
            (element) => element.value == header.sysDocType,
            orElse: () {
              DoccumentType.clear;
            },
          );
          if (locationList.isEmpty) {
            await getLocationList();
          }
          selectedFromLocation.value = await getLocationFromId(
              header.locationId ?? UserSimplePreferences.getLocationId() ?? '');
          for (Detail items in result.detail) {
            selectedProduct.value = productList.firstWhere(
              (element) => element.productId == items.productId,
              orElse: () => ProductListModel(),
            );
            dataList.add(Data(
                description: items.description,
                qtyList: [double.parse(items.quantity.toString())],
                product: selectedProduct.value));
          }

          isNewRecord.value = false;
          update();
        }
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  getItemTransactionIdFromLocal(
      {required LoadingSheetsHeaderModel header}) async {
    dataList.clear();
    isLoadingDataList.value = true;
    update();

    if (sysDocList.isEmpty) {
      await sysDocListController.getSysDocListByType(
          sysDocType: SysdocType.ItemTransaction.value);
      sysDocList.value = sysDocListController.sysDocList;
    }
    sysDocId.value = sysDocList.firstWhere(
        (element) =>
            element.code!.toLowerCase() == header.sysdocid!.toLowerCase(),
        orElse: () => SysDocModel(code: header.sysdocid!));
    voucherNumber.value = header.voucherid ?? '';
    if (documentTypeList.isEmpty) {
      await getDocumentTypeList();
    }

    selectedDocument.value = documentTypeList.firstWhere(
      (element) => header.documentType == element.value.toString(),
      orElse: () => DoccumentType.clear,
    );
    if (selectedDocument.value.type == 2) {
      if (partyList.isEmpty) {
        await getPartyList();
      }
      selectedParty.value = partyList.firstWhere(
        (element) => element.code == header.partyId,
        orElse: () => VendorModel(),
      );
    } else if (selectedDocument.value.type == 1) {
      if (customerList.isEmpty) {
        await getCustomerList();
      }
      selectedCustomer.value = customerList.firstWhere(
        (element) => element.code == header.partyId,
        orElse: () => CustomerModel(),
      );
    }
    if (locationList.isEmpty) {
      await getLocationList();
    }
    if (header.fromLocationId != null ||
        header.toLocationId != null ||
        locationList.isNotEmpty) {
      selectedFromLocation.value = await getLocationFromId(
          header.fromLocationId ?? UserSimplePreferences.getLocationId() ?? '');
      selectedToLocation.value = locationList.firstWhere(
          (element) => element.code == header.toLocationId,
          orElse: () => LocationModel());
    } else {
      selectedFromLocation.value =
          await getLocationFromId(UserSimplePreferences.getLocationId() ?? '');
      selectedToLocation.value = LocationModel();
    }
    if (salesPersonList.isEmpty) {
      await getSalesPersonList();
    }
    selectedSalesPerson.value = salesPersonList.firstWhere(
      (element) => element.code == header.salespersonid,
      orElse: () => ProductCommonComboModel(),
    );
    if (vehicleNoList.isEmpty) {
      await getVehicleList();
    }
    selectedVehicleNo.value = vehicleNoList.firstWhere(
      (element) => element.code == header.vehicleNo,
      orElse: () => ProductCommonComboModel(),
    );
    if (driverNameList.isEmpty) {
      await getDriverList();
    }
    selectedDriverName.value = driverNameList.firstWhere(
      (element) => element.code == header.driverName,
      orElse: () => ProductCommonComboModel(),
    );
    addressController.value.text = header.address ?? '';
    phoneNumberController.value.text = header.phoneNumber ?? '';
    // selectedSalesPerson.value =
    //     ProductCommonComboModel(code: header.salespersonid ?? '');
    // selectedDriverName.value =
    //     ProductCommonComboModel(code: header.driverName ?? '');
    // selectedVehicleNo.value =
    //     ProductCommonComboModel(code: header.vehicleNo ?? '');
    containerNoController.value.text = header.containerNo ?? '';
    ref1Controller.value.text = header.reference1 ?? '';
    ref2Controller.value.text = header.reference2 ?? '';
    ref3Controller.value.text = header.reference3 ?? '';
    remarksController.value.text = header.note ?? '';
    selectedStartTime.value = getTimeOfDayFromString(header.startTime ?? '');
    selectedEndTime.value = getTimeOfDayFromString(header.endTime ?? '');
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: header.voucherid ?? '');
    for (ItemTransactionDetailsModel item
        in loadingSheetsLocalController.loadingSheetsDetail) {
      if (productList.isEmpty) {
        await productListLocalController.getProductList();
      }
      productList.value = productListLocalController.productList;
      selectedProduct.value = productList.firstWhere(
        (element) => item.itemcode == element.productId,
        orElse: () => ProductListModel(),
      );

      dataList.add(Data(
        description: item.remarks,
        product: selectedProduct.value,
        qtyList: getQtyList(item.listQuantity.toString()),
      ));

      update();
    }
    isNewRecord.value = false;
    isCompleted.value = false;
    isUpdate.value = true;
    calculateTotal();

    isLoadingDataList.value = false;
    update();
  }

  List<double> getQtyList(String data) {
    String numbersString = data;

    // Split the string based on the '+' delimiter
    List<String> numberStrings = numbersString.split('+');

    // Convert the strings to double values
    List<double> numbersList =
        numberStrings.map((String str) => double.parse(str)).toList();
    return numbersList;
  }

  RxList<Data> dataList = <Data>[].obs;
  void addData(String description, int intValue) async {
    int existingIndex = dataList.indexWhere(
        (item) => item.product!.productId == selectedProduct.value.productId);

    if (existingIndex != -1) {
      dataList[existingIndex].qtyList!.add(intValue.toDouble());
      // updateDetailsQuantity(
      //     dataList[existingIndex].qtyList?.fold(
      //             0,
      //             (previousValue, element) =>
      //                 (previousValue ?? 0.0) + element) ??
      //         0.0,
      //     selectedProduct.value.productId ?? '');
    } else {
      List<double> doubleList = [intValue.toDouble()];
      dataList.add(Data(
        description: description,
        product: selectedProduct.value,
        qtyList: doubleList,
      ));
    }
    calculateTotal();

    update();
    await saveJsonExternaly();
  }

  var filterSearchList = [].obs;

  addQuantity({required int index, required double qty}) {
    dataList[index].qtyList!.add(qty);
    // updateDetailsQuantity(
    //     dataList[index].qtyList?.fold(0,
    //             (previousValue, element) => (previousValue ?? 0.0) + element) ??
    //         0.0,
    //     dataList[index].product?.productId ?? '');

    calculateTotal();
    saveLoadingSheet();
    update();
  }

  editquantity({required int index, required double qty}) {
    dataList[index].qtyList!.add(qty);
    update();
  }

  /// start time and end time selection--------------------///

  Rx<TimeOfDay> selectedStartTime = TimeOfDay.now().obs;

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime.value,
    );
    if (picked != null && picked != selectedStartTime.value) {
      selectedStartTime.value = picked;
    }
  }

  Rx<TimeOfDay> selectedEndTime = TimeOfDay.now().obs;

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime.value,
    );
    if (picked != null && picked != selectedEndTime.value) {
      selectedEndTime.value = picked;
    }
  }

  ///------------------------------------------------------////

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  // updatePartyName(VendorModel value) {
  //   selectedParty.value = value;
  //   update();
  // }

  updateSelectedDocumentType(DoccumentType value) {
    selectedDocument.value = value;
    if (value.type == 1) {
      getCustomerList(isInitial: false);
    } else if (value.type == 2) {
      getPartyList(isInitial: false);
    }
    if (dataList.isNotEmpty) {
      saveLoadingSheet();
    }
    update();
  }

  getLocationList() async {
    locationList.clear();
    await homeController.getLocationList();
    if (homeController.locationList.isNotEmpty) {
      locationList.value = homeController.locationList;
      // selectedFromLocation.value =
      //     await getLocationFromId(UserSimplePreferences.getLocationId() ?? '');
      selectedToLocation.value = LocationModel();
    }

    update();
  }

  getUserLocationList() async {
    userLocationList.clear();
    await homeController.getUserLocationLocalList();
    if (homeController.userLocallLocationList.isNotEmpty) {
      userLocationList.value = homeController.userLocallLocationList;
      selectedFromLocation.value =
          await getLocationFromId(UserSimplePreferences.getLocationId() ?? '');
      // selectedToLocation.value = LocationModel();
    }

    update();
  }

  selectFromLocation(int index) {
    selectedFromLocation.value = userLocationList[index];
    update();
  }

  selectToLocation(int index) {
    selectedToLocation.value = locationList[index];
    update();
  }

  scanItemCode(String code) async {
    if (productList.isEmpty) {
      await productListLocalController.getProductList();
    }
    productList.value = productListLocalController.productList;
    ProductListModel product = productList.firstWhere(
        (element) =>
            element.productId == code ||
            (element.upc != null &&
                element.upc!.isNotEmpty &&
                element.upc == code),
        orElse: () => ProductListModel());
    nameController.value.text = "${product.productId} - ${product.description}";
    selectedProduct.value = product;
    update();
  }

  void updateSelectedProduct(var value) {
    selectedProduct.value = value;
    log("${selectedProduct.value.unitId} unit");
    update();
  }

  RxString inputValue = ''.obs;

  void updateInputValue(String value) {
    inputValue.value = value;
  }

  RxInt result = 0.obs;

  void calculateSum(int num1, int num2) {
    result.value = num1 + num2;
  }

  @override
  void onClose() {
    quantityController.value.clear();

    super.onClose();
  }

  editQuantity() {
    isEditingQuantity.value = !isEditingQuantity.value;
    quantityController.value.text = quantity.value.toString();
    update();
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
    quantity.value = int.parse(value);
  }

  resetQuantity() {
    quantity.value = 1;
    isEditingQuantity.value = false;
    update();
  }

  editEditQuantities() {
    isEditingEditQuantities.value = !isEditingEditQuantities.value;
    quantityController.value.text = editQuantities.value.toString();
    update();
  }

  incrementEditQuantities() {
    isEditingEditQuantities.value = false;
    editQuantities.value++;
    update();
  }

  decrementEditQuantities() {
    isEditingEditQuantities.value = false;
    if (editQuantities > 1) {
      editQuantities.value--;
      update();
    }
  }

  setEditQuantities(String value) {
    editQuantities.value = int.parse(value);
  }

  resetEditQuantities() {
    quantity.value = 1;
    isEditingQuantity.value = false;
    update();
  }

  updateDetailsQuantity(double quantity, String itemCode) async {
    await loadingSheetsLocalController.updateLoadingSheetItems(
        voucherId: voucherNumber.value, quantity: quantity, itemCode: itemCode);
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: voucherNumber.value);
    await saveJsonExternaly();
    for (ItemTransactionDetailsModel item
        in loadingSheetsLocalController.loadingSheetsDetail) {
      log("${item.quantity}", name: "update quantity");
    }
  }

  saveHeader({bool isUpdate = false}) async {
    final header = LoadingSheetsHeaderModel(
      token: "",
      isSynced: 0,
      error: '',
      isError: 0,
      sysdocid: sysDocId.value.code,
      voucherid: voucherNumber.value,
      isnewrecord: isNewRecord.value == true ? 1 : 0,
      transactionDate: selectedDate.value.toIso8601String(),
      total: totalQuanity.value,
      fromLocationId: selectedFromLocation.value.code ?? '',
      documentType: selectedDocument.value.name == ''
          ? ''
          : selectedDocument.value.value.toString(),
      partyId: selectedDocument.value.type == 1
          ? selectedCustomer.value.code
          : selectedDocument.value.type == 2
              ? selectedParty.value.code
              : '',
      partyType: 'V',
      startTime: selectedStartTime.value.toString(),
      endTime: selectedEndTime.value.toString(),
      note: remarksController.value.text,
      reference3: ref3Controller.value.text,
      address: addressController.value.text,
      containerNo: containerNoController.value.text,
      driverName: selectedDriverName.value.code,
      reference1: ref1Controller.value.text,
      reference2: ref2Controller.value.text,
      vehicleNo: selectedVehicleNo.value.code,
      phoneNumber: phoneNumberController.value.text,
      toLocationId:
          selectedDocument.value.type == 3 ? selectedToLocation.value.code : '',
      salespersonid: selectedSalesPerson.value.code,
      isCompleted: isCompleted.value == false ? 0 : 1,
    );
    if (isUpdate) {
      await loadingSheetsLocalController.updateLoadingSheetHeader(
          voucherId: voucherNumber.value, header: header);
    } else {
      await loadingSheetsLocalController.insertLoadingSheetsHeaders(
          header: header);
    }
    log("${voucherNumber.value}", name: "insert header voucher");
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    // await saveJsonExternaly();
    log("${loadingSheetsLocalController.loadingSheetsHeaders.last.documentType}",
        name: "insert header");
  }

  saveDetails(Data product, int index) async {
    // List<ItemTransactionDetailsModel> list = [];
    // for (var product in dataList) {
    log("${product.product?.unitId ?? ''} selectedUnit");
    var item = ItemTransactionDetailsModel(
        itemcode: product.product?.productId ?? '',
        quantity: product.qtyList?.fold(
            0, (previousValue, element) => (previousValue ?? 0.0) + element),
        description: product.product?.description ?? '',
        sourceVoucherId: voucherNumber.value,
        sourceSysDocId: sysDocId.value.code,
        remarks: product.description,
        sourceRowIndex: index,
        rowindex: index,
        unitid: product.product?.unitId ?? '',
        locationId: product.product?.locationId ?? '',
        unitQuantity: product.product?.quantity ?? 0,
        costCategoryId: "",
        factorType: "",
        jobId: "",
        quantityReturned: 0,
        quantityShipped: 0,
        refDate1: "",
        refDate2: "",
        refNum1: 0,
        refNum2: 0,
        refSlNo: "",
        refText1: "",
        refText2: "",
        refText3: "",
        refText4: "",
        refText5: "",
        rowSource: "",
        subunitPrice: 0,
        unitFactor: 0,
        unitPrice: 0);
    //   rowIndex++;
    //   detailRowindex++;
    // }

    await loadingSheetsLocalController.insertLoadingSheetItems(item: item);
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: voucherNumber.value);
    await saveJsonExternaly();
    log("${loadingSheetsLocalController.loadingSheetsDetail}",
        name: "insert detail");
  }

  saveLoadingSheetsInLocal() async {
    // if (isSaving.value) {
    //   return;
    // }
    if (dataList.isEmpty) {
      SnackbarServices.errorSnackbar('Please Add Items to Continue');
      return;
    }
    isSaving.value = true;
    await loadingSheetsLocalController.deleteLoadingSheetDetail(
        vouchetId: voucherNumber.value);
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: voucherNumber.value);
    // if (voucherNumber.value != '') {
    final String location = UserSimplePreferences.getLocationId() ?? '';

    log(selectedFromLocation.value.code.toString());
    final header = LoadingSheetsHeaderModel(
      token: "",
      isSynced: 0,
      error: '',
      isError: 0,
      sysdocid: sysDocId.value.code,
      voucherid: voucherNumber.value,
      isnewrecord: isNewRecord.value == true ? 1 : 0,
      transactionDate: selectedDate.value.toIso8601String(),
      total: totalQuanity.value,
      fromLocationId: selectedFromLocation.value.code ?? '',
      documentType: selectedDocument.value.name == ''
          ? ''
          : selectedDocument.value.value.toString(),
      partyId: selectedDocument.value.type == 1
          ? selectedCustomer.value.code
          : selectedDocument.value.type == 2
              ? selectedParty.value.code
              : '',
      partyType: 'V',
      startTime: selectedStartTime.value.toString(),
      endTime: selectedEndTime.value.toString(),
      note: remarksController.value.text,
      reference3: ref3Controller.value.text,
      address: addressController.value.text,
      containerNo: containerNoController.value.text,
      driverName: selectedDriverName.value.code,
      reference1: ref1Controller.value.text,
      reference2: ref2Controller.value.text,
      vehicleNo: selectedVehicleNo.value.code,
      phoneNumber: phoneNumberController.value.text,
      toLocationId:
          selectedDocument.value.type == 3 ? selectedToLocation.value.code : '',
      salespersonid: selectedSalesPerson.value.code,
    );
    var detailRowindex = 0;
    var rowIndex = 0;
    List<ItemTransactionDetailsModel> list = [];
    for (var product in dataList) {
      list.add(ItemTransactionDetailsModel(
          itemcode: product.product?.productId ?? '',
          quantity: product.qtyList?.fold(
              0, (previousValue, element) => (previousValue ?? 0.0) + element),
          listQuantity: product.qtyList != null && product.qtyList!.isNotEmpty
              ? product.qtyList!.join('+').toString()
              : '',
          description: product.product?.description ?? '',
          sourceVoucherId: voucherNumber.value,
          sourceSysDocId: sysDocId.value.code,
          remarks: product.description,
          sourceRowIndex: detailRowindex,
          rowindex: rowIndex,
          unitid: product.product?.unitId ?? '',
          locationId: location,
          unitQuantity: product.product?.quantity ?? 0,
          costCategoryId: "",
          factorType: "",
          jobId: "",
          quantityReturned: 0,
          quantityShipped: 0,
          refDate1: "",
          refDate2: "",
          refNum1: 0,
          refNum2: 0,
          refSlNo: "",
          refText1: "",
          refText2: "",
          refText3: "",
          refText4: "",
          refText5: "",
          rowSource: "",
          subunitPrice: 0,
          unitFactor: 0,
          unitPrice: 0));
      rowIndex++;
      detailRowindex++;
    }

    if (isUpdate.value) {
      await loadingSheetsLocalController.updateLoadingSheetHeader(
          voucherId: voucherNumber.value, header: header);
    } else {
      await loadingSheetsLocalController.insertLoadingSheetsHeaders(
          header: header);
    }
    await loadingSheetsLocalController.insertLoadingSheetsDetails(detail: list);
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: voucherNumber.value);
    log("${loadingSheetsLocalController.loadingSheetsHeaders.first.documentType}",
        name: "header");
    log("${loadingSheetsLocalController.loadingSheetsDetail}", name: "detail");

    // bool isConnected = await ApiManager.isConnected();
    // if (isConnected) {
    //   syncLoadingSheet();
    // }

    cleardata();
    getDocId();
    isSaving.value = false;

    SnackbarServices.successSnackbar('Saved successfully in local');
  }

  syncLoadingSheet() async {
    // if (dataList.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please Add Items");
    //   return;
    // }
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String location = UserSimplePreferences.getLocationId() ?? '';
    final String token = loginController.token.value;
    var detailRowindex = 0;
    var rowIndex = 0;
    List<ItemTransactionDetailsModel> list = [];
    for (var product in dataList) {
      list.add(ItemTransactionDetailsModel(
          itemcode: product.product?.productId ?? '',
          quantity: product.qtyList?.fold(
              0, (previousValue, element) => (previousValue ?? 0.0) + element),
          listQuantity: product.qtyList != null && product.qtyList!.isNotEmpty
              ? product.qtyList!.join('+').toString()
              : '',
          description: product.product?.description ?? '',
          sourceVoucherId: voucherNumber.value,
          sourceSysDocId: sysDocId.value.code,
          remarks: product.description,
          sourceRowIndex: detailRowindex,
          rowindex: rowIndex,
          unitid: product.product?.unitId ?? '',
          locationId: location,
          unitQuantity: product.product?.quantity ?? 0,
          costCategoryId: "",
          factorType: "",
          jobId: "",
          quantityReturned: 0,
          quantityShipped: 0,
          refDate1: "",
          refDate2: "",
          refNum1: 0,
          refNum2: 0,
          refSlNo: "",
          refText1: "",
          refText2: "",
          refText3: "",
          refText4: "",
          refText5: "",
          rowSource: "",
          subunitPrice: 0,
          unitFactor: 0,
          unitPrice: 0,
          expiryDate: DateTime.now().toIso8601String()));
      rowIndex++;
      detailRowindex++;
    }
    final data = jsonEncode({
      "token": "${token}",
      "Sysdocid": sysDocId.value.code ?? '',
      "SysDocType": int.parse(selectedDocument.value.value.toString()),
      "Voucherid": voucherNumber.value,
      "PartyType": selectedDocument.value.type == 1
          ? 'C'
          : selectedDocument.value.type == 2
              ? 'V'
              : '',
      "PartyID": selectedDocument.value.type == 1
          ? selectedCustomer.value.code
          : selectedDocument.value.type == 2
              ? selectedParty.value.code
              : '',
      "LocationID": selectedFromLocation.value.code ?? '',
      "Salespersonid": selectedSalesPerson.value.code ?? '',
      "Currencyid": "",
      "TransactionDate": selectedDate.value.toIso8601String(),
      "Reference1": ref1Controller.value.text,
      "Reference2": ref2Controller.value.text,
      "Reference3": ref3Controller.value.text,
      // "${dataList.map((element) => element.product?.category).toList().toSet().toList().join(', ')}",
      "Note": remarksController.value.text,
      "Isvoid": false,
      "Discount": 0,
      "Total": 0,
      "Roundoff": 0,
      "Address": addressController.value.text,
      "Phone": phoneNumberController.value.text,
      "IsCompleted": isCompleted.value == false ? 0 : 1,
      "DriverID": selectedDriverName.value.code ?? '',
      "VehicleID": selectedVehicleNo.value.code ?? '',
      "ToLocationID":
          selectedDocument.value.type == 3 ? selectedToLocation.value.code : '',
      "ContainerNo": containerNoController.value.text,
      "Isnewrecord": isNewRecord.value,
      "Status": isDataPosting == true ? 2 : 0,
      "TransactionType": 1,
      "ItemTransactionDetails": list,
    });
    log("${data}");
    try {
      var feedback = await ApiManager.fetchDataRawBodyInventory(
        api: 'CreateItemTransaction',
        data: data,
      );
      log("$feedback");
      if (feedback != null) {
        if (feedback['res'] == 1) {
          await loadingSheetsLocalController.updateloadingSheetsHeaders(
              voucherId: voucherNumber.value,
              isSynced: 1,
              isError: 0,
              error: '');
          // cleardata();
          // getDocId();
          isNewRecord.value = false;
          update();
        } else {
          SnackbarServices.errorSnackbar(
              "${feedback['msg'] ?? feedback['err']}");
        }
      }
    } finally {}
  }

  syncLoadingSheetFromLocal() async {
    await loadingSheetsLocalController.getLoadingSheetsHeaders();

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }

    log('Syncing continues ${loadingSheetsLocalController.loadingSheetsHeaders.length}');

    final String token = loginController.token.value;
    for (var header in loadingSheetsLocalController.loadingSheetsHeaders) {
      if (header.isSynced == 1) {
        continue;
      } else {
        await loadingSheetsLocalController.getloadingSheetsDetails(
            voucher: header.voucherid ?? '');

        final data = jsonEncode({
          "token": "${token}",
          "Sysdocid": header.sysdocid ?? '',
          "Voucherid": header.voucherid ?? '',
          "PartyType": header.partyType ?? '',
          "PartyID": header.partyId ?? '',
          "LocationID": header.fromLocationId ?? '',
          "Salespersonid": header.salespersonid ?? '',
          "Currencyid": header.currencyid ?? '',
          "TransactionDate": header.transactionDate,
          "Reference1": header.reference1 ?? '',
          "Reference2": header.reference2 ?? '',
          "Reference3": header.reference3 ?? '',
          "Note": header.note ?? '',
          "Isvoid": false,
          "Discount": header.discount ?? 0,
          "Total": header.total ?? 0,
          "Roundoff": header.roundoff ?? 0,
          "Isnewrecord": header.isnewrecord == 0 ? false : true,
          "Status": isDataPosting == true ? 2 : 0,
          "TransactionType": 1,
          "ItemTransactionDetails":
              loadingSheetsLocalController.loadingSheetsDetail
        });
        log("${data}");
        try {
          var feedback = await ApiManager.fetchDataRawBodyInventory(
            api: 'CreateItemTransaction',
            data: data,
          );
          log("$feedback");
          if (feedback != null) {
            if (feedback['res'] == 1) {
              await loadingSheetsLocalController.updateloadingSheetsHeaders(
                  voucherId: header.voucherid ?? '',
                  isSynced: 1,
                  isError: 0,
                  error: '');
              await loadingSheetsLocalController.updateLoadingSheetsDetails(
                voucherId: header.voucherid ?? '',
              );
              await loadingSheetsLocalController
                  .updateLoadingSheetsHeadersVoucher(
                      voucherId: header.voucherid!, docNo: feedback['docNo']);
            } else {
              // SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
              await loadingSheetsLocalController.updateloadingSheetsHeaders(
                  voucherId: header.voucherid ?? '',
                  isSynced: 0,
                  isError: 1,
                  error: feedback['msg'] ?? feedback['err']);
            }
          }
        } finally {}
      }
    }
  }

  saveJsonExternaly() {
    log("saveJsonExternaly......");
    final String location = UserSimplePreferences.getLocationId() ?? '';

    List<ItemTransactionDetailsModel> list = [];
    int detailRowindex = 0;
    int rowIndex = 0;
    for (var product in dataList) {
      list.add(ItemTransactionDetailsModel(
          itemcode: product.product?.productId ?? '',
          quantity: product.qtyList?.fold(
              0, (previousValue, element) => (previousValue ?? 0.0) + element),
          description: product.product?.description ?? '',
          sourceVoucherId: voucherNumber.value,
          sourceSysDocId: sysDocId.value.code,
          remarks: product.description,
          sourceRowIndex: detailRowindex,
          rowindex: rowIndex,
          // taxoption: int.parse(product.product?.taxOption ?? "0"),
          unitid: product.product?.unitId ?? '',
          // taxGroupId: product.product?.taxGroupId ?? '',
          locationId: product.product?.locationId ?? '',
          unitQuantity: product.product?.quantity ?? 0));
      rowIndex++;
      detailRowindex++;
    }
    final data = jsonEncode({
      "token": "",
      "Sysdocid": sysDocId.value.code,
      "Voucherid": voucherNumber.value,
      "PartyType": 'V',
      "PartyID": selectedDocument.value.type == 1
          ? selectedCustomer.value.code
          : selectedDocument.value.type == 2
              ? selectedParty.value.code
              : '',
      "LocationID": location,
      "Salespersonid": "",
      "Currencyid": "",
      "TransactionDate": DateTime.now().toIso8601String().toString(),
      "Reference1": "",
      "Reference2": '',
      "Reference3": '',
      "Note": '',
      "Isvoid": false,
      "Discount": 0,
      "Total": totalQuanity.value,
      "Roundoff": 0,
      "Isnewrecord": isNewRecord.value == true ? 1 : 0,
      "ItemTransactionDetails": list
    });

    ExternalJsonGenerator.saveJsonDataToDownloadsFolder(
        data, '${sysDocId.value.code}-${voucherNumber.value}.json');
    log("save......");
  }

  calculateTotal() {
    totalQuanity.value = dataList.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.qtyList!
                .fold(0, (previousValue, element) => previousValue + element));
    update();
  }

  getPartyList({bool isInitial = true}) async {
    partyList.clear();
    // filterPartyList.clear();
    isPartListLoading.value = true;
    update();
    if (partyVendorListController.partyVendorList.isEmpty) {
      await partyVendorListController.getPartyVendorList();
    }

    partyList.value = partyVendorListController.partyVendorList;
    // filterPartyList.value = partyList;
    if (isInitial) {
      selectedParty.value = partyList[0];
    }

    update();

    isPartListLoading.value = false;
    update();
  }

  getCustomerList({bool isInitial = true}) async {
    customerList.clear();
    filterPartyList.clear();
    isPartListLoading.value = true;
    update();
    if (customerListLocalController.customersList.isEmpty) {
      await customerListLocalController.getCustomerList();
    }

    customerList.value = customerListLocalController.customersList;
    filterPartyList.value = customerList;
    if (isInitial) {
      selectedCustomer.value = customerList[0];
    }

    update();

    isPartListLoading.value = false;
    update();
  }

  filterItemName() {
    nameList.value = productList.where((element) {
      bool matchesClass = classController.value.text.isNotEmpty &&
          classController.value.text == element.modelClass;

      bool matchesCategory = categoryController.value.text.isNotEmpty &&
          categoryController.value.text == element.category;

      bool matchesBrand = brandController.value.text.isNotEmpty &&
          brandController.value.text == element.brand;

      bool matchesOrigin = originController.value.text.isNotEmpty &&
          originController.value.text == element.origin;

      // Apply multiple conditions using &&
      return (matchesClass || !classController.value.text.isNotEmpty) &&
          (matchesCategory || !categoryController.value.text.isNotEmpty) &&
          (matchesBrand || !brandController.value.text.isNotEmpty) &&
          (matchesOrigin || !originController.value.text.isNotEmpty);
    }).toList();
    update();
  }

  setToDefault(TextEditingController controller) {
    controller.clear();
    update();
  }

  filterdocList(String value) {
    filterDocumentTypeList.value = documentTypeList
        .where((element) =>
            element.name.toString().toLowerCase().contains(value.toLowerCase()))
        .toList();
    filterDocumentTypeList..sort((a, b) => a.name.compareTo(b.name));
    update();
  }

  filterPartyLists(String value) {
    if (selectedDocument.value.type == 2) {
      filterPartyList.value = partyList
          .where((element) =>
              element.code
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      update();
    } else if (selectedDocument.value.type == 1) {
      filterPartyList.value = customerList
          .where((element) =>
              element.code
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      update();
    }
  }

  commonFilter(String value, var list) {
    filterList.value = list
        .where((element) =>
            element.code
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            element.name.toString().toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  deleteItem(int index) async {
    deleteLoadingSheetDetailItem(index);

    dataList.removeAt(index);
    // if (dataList.isEmpty) {
    //   deleteHeader(voucherNumber.value);
    // }
    calculateTotal();
    update();
    syncLoadingSheet();
    // await saveJsonExternaly();
  }

  deleteLoadingSheetDetailItem(int index) async {
    loadingSheetsLocalController.deleteLoadingSheetItem(
        voucherid: voucherNumber.value,
        itemCode: dataList[index].product?.productId ?? '');
    await loadingSheetsLocalController.getloadingSheetsDetails(
        voucher: voucherNumber.value);
    log("${loadingSheetsLocalController.loadingSheetsDetail}",
        name: "delete Detail");
  }

  deleteHeader(String voucherId) async {
    loadingSheetsLocalController.deleteLoadingSheetHeader(
        vouchetId: voucherNumber.value);
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    log("${loadingSheetsLocalController.loadingSheetsHeaders}",
        name: "Delete Header");
  }

  updatePartyIdHeaderOrDocumentType(bool partyId) async {
    loadingSheetsLocalController.updateLoadingSheetHeaderPartyIdOrDocType(
        voucherId: voucherNumber.value,
        txt: partyId
            ? selectedParty.value.code ?? ''
            : selectedDocument.value.name,
        partyId: partyId);
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    await saveJsonExternaly();
    log("${loadingSheetsLocalController.loadingSheetsHeaders.first.documentType}");
  }

  // updatePartyIdHeader() async {
  //   loadingSheetsLocalController.updateLoadingSheetHeaderPartyId(
  //       voucherId: voucherNumber.value,
  //       partyId: selectedParty.value.code ?? '');
  //   await loadingSheetsLocalController.getLoadingSheetsHeaders();
  //   log("${loadingSheetsLocalController.loadingSheetsHeaders.first.partyId}");
  // }

  getUnsavedItem() async {
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    if (loadingSheetsLocalController.loadingSheetsHeaders.isNotEmpty) {
      LoadingSheetsHeaderModel header =
          loadingSheetsLocalController.loadingSheetsHeaders.last;
      selectedParty.value = partyList.firstWhere(
        (element) => element.code == header.partyId,
        orElse: () => VendorModel(),
      );
      sysDocId.value.code = header.sysdocid ?? '';
      voucherNumber.value = header.voucherid ?? '';
      selectedDocument.value = documentTypeList
          .firstWhere((element) => header.documentType == element.name);
      await loadingSheetsLocalController.getloadingSheetsDetails(
          voucher: header.voucherid ?? '');
      for (ItemTransactionDetailsModel item
          in loadingSheetsLocalController.loadingSheetsDetail) {
        log("${item.itemcode}");
        if (productList.isEmpty) {
          await productListLocalController.getProductList();
        }
        productList.value = productListLocalController.productList;
        selectedProduct.value = productList.firstWhere(
          (element) => item.itemcode == element.productId,
          orElse: () => ProductListModel(),
        );

        dataList.add(Data(
          description: item.remarks,
          product: selectedProduct.value,
          qtyList: [item.quantity ?? 0.0],
        ));
        update();
      }
      calculateTotal();
    }
    update();
  }

  getDatasOnTapCreatNew(BuildContext context) async {
    isloadingDatas.value = true;
    isNewRecord.value = true;
    cleardata();
    await getDocumentTypeList();
    await getPartyList();
    await getCustomerList();
    await getSalesPersonList();
    await getCategoryList();
    await getVehicleList();
    await getDriverList();
    getDocId();
    getLocationList();
    getUserLocationList();
    // getUnsavedItem();
    isloadingDatas.value = false;
  }

  searchProductList(String value) {
    nameList.value = productList
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

  deleteFromLocal(String voucherId) {
    loadingSheetsLocalController.deleteLoadingSheet(vouchetId: voucherId);
    getLoadingSheetListFromLocal();
    update();
  }

  TimeOfDay getTimeOfDayFromString(String timeString) {
    // Extracting the substring containing the time
    String timeSubstring = timeString.substring(10, timeString.length - 1);

    // Splitting the time string into hours and minutes
    List<String> timeParts = timeSubstring.split(':');

    // Parsing hours and minutes as integers
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Creating and returning TimeOfDay object
    return TimeOfDay(hour: hours, minute: minutes);
  }

  updateDescription(int index) {
    dataList[index].description = descriptionController.value.text;
    update();
  }

  openAccordian() {
    isOpenAccordian.value = !isOpenAccordian.value;
    update();
  }

  saveLoadingSheet() async {
    int isExist = await loadingSheetsLocalController
        .isLoadingSheetHeaderAlreadyExist(voucherId: voucherNumber.value);
    final header = LoadingSheetsHeaderModel(
      token: "",
      isSynced: 0,
      error: '',
      isError: 0,
      sysdocid: sysDocId.value.code,
      voucherid: voucherNumber.value,
      isnewrecord: isNewRecord.value == true ? 1 : 0,
      transactionDate: selectedDate.value.toIso8601String(),
      total: totalQuanity.value,
      fromLocationId: selectedFromLocation.value.code ?? '',
      documentType: selectedDocument.value.name == ''
          ? ''
          : selectedDocument.value.name == ''
              ? ''
              : selectedDocument.value.value.toString(),
      partyId: selectedDocument.value.type == 1
          ? selectedCustomer.value.code
          : selectedDocument.value.type == 2
              ? selectedParty.value.code
              : '',
      partyType: 'V',
      startTime: selectedStartTime.value.toString(),
      endTime: selectedEndTime.value.toString(),
      note: remarksController.value.text,
      reference3: ref3Controller.value.text,
      address: addressController.value.text,
      containerNo: containerNoController.value.text,
      driverName: selectedDriverName.value.code,
      reference1: ref1Controller.value.text,
      reference2: ref2Controller.value.text,
      vehicleNo: selectedVehicleNo.value.code,
      phoneNumber: phoneNumberController.value.text,
      toLocationId:
          selectedDocument.value.type == 3 ? selectedToLocation.value.code : '',
      salespersonid: selectedSalesPerson.value.code,
      isCompleted: isCompleted.value == false ? 0 : 1,
      categories:
          "${dataList.map((element) => element.product?.category).toList().toSet().toList().join(', ')}",
    );
    if (isExist == 0) {
      await loadingSheetsLocalController.insertLoadingSheetsHeaders(
          header: header);
    } else {
      await loadingSheetsLocalController.updateLoadingSheetHeader(
          voucherId: voucherNumber.value, header: header);
    }
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    log("${loadingSheetsLocalController.loadingSheetsHeaders.length}");
    var detailRowindex = 0;
    var rowIndex = 0;
    final String location = UserSimplePreferences.getLocationId() ?? '';
    for (var product in dataList) {
      int isItemExist =
          await loadingSheetsLocalController.isLoadingSheetDetailAlreadyExist(
              voucherId: voucherNumber.value,
              itemCode: product.product?.productId ?? '');
      var detail = ItemTransactionDetailsModel(
          itemcode: product.product?.productId ?? '',
          quantity: product.qtyList?.fold(
              0, (previousValue, element) => (previousValue ?? 0.0) + element),
          listQuantity: product.qtyList != null && product.qtyList!.isNotEmpty
              ? product.qtyList!.join('+').toString()
              : '',
          description: product.product?.description ?? '',
          sourceVoucherId: voucherNumber.value,
          sourceSysDocId: sysDocId.value.code,
          remarks: product.description,
          sourceRowIndex: detailRowindex,
          rowindex: rowIndex,
          unitid: product.product?.unitId ?? '',
          locationId: location,
          unitQuantity: product.product?.quantity ?? 0,
          costCategoryId: "",
          factorType: "",
          jobId: "",
          quantityReturned: 0,
          quantityShipped: 0,
          refDate1: "",
          refDate2: "",
          refNum1: 0,
          refNum2: 0,
          refSlNo: "",
          refText1: "",
          refText2: "",
          refText3: "",
          refText4: "",
          refText5: "",
          rowSource: "",
          subunitPrice: 0,
          unitFactor: 0,
          unitPrice: 0);
      if (isItemExist == 0) {
        await loadingSheetsLocalController.insertLoadingSheetItems(
            item: detail);
      } else {
        await loadingSheetsLocalController.updateLoadingSheetDetail(
            voucherId: voucherNumber.value,
            itemCode: product.product?.productId ?? '',
            detail: detail);
      }
    }
    bool isConnected = await ApiManager.isConnected();
    if (isConnected) {
      syncLoadingSheet();
    }

    update();
  }

  getSalesPersonList() async {
    salesPersonList.clear();
    if (salesPersonList.isEmpty) {
      await salesPersonListController.getSalesPersonList();
    }

    salesPersonList.value = salesPersonListController.salesPersonList;
    // Check if "Clear" option already exists in the list
    var clearOption = ProductCommonComboModel(code: "Clear");
    if (!salesPersonList.contains(clearOption)) {
      salesPersonList.insert(0, clearOption);
    }

    selectedSalesPerson.value = ProductCommonComboModel();
    update();
  }

  getVehicleList() async {
    vehicleNoList.clear();
    if (vehicleNoList.isEmpty) {
      await vehicleNoListController.getVehicleList();
    }
    vehicleNoList.value = vehicleNoListController.vehicleList;
    var clearOption = ProductCommonComboModel(code: "Clear");
    if (!vehicleNoList.contains(clearOption)) {
      vehicleNoList.insert(0, clearOption);
    }
    selectedVehicleNo.value = ProductCommonComboModel();
    update();
  }

  getDriverList() async {
    driverNameList.clear();
    if (driverNameList.isEmpty) {
      await driverNameListController.getDriverList();
    }
    driverNameList.value = driverNameListController.driverList;
    var clearOption = ProductCommonComboModel(code: "Clear");
    if (!driverNameList.contains(clearOption)) {
      driverNameList.insert(0, clearOption);
    }
    selectedDriverName.value = ProductCommonComboModel();
    update();
  }

  completeLoadingSheetHeader(LoadingSheetsHeaderModel item, int index) async {
    isDataPosting.value = true;
    selectedIndex.value = index;
    await getItemTransactionIdFromLocal(header: item);
    isCompleted.value = true;
    await syncLoadingSheet();
    loadingSheetsLocalController.updateloadingSheetsHeadersIscompleted(
        voucherId: voucherNumber.value, isCompleted: 1);
    isDataPosting.value = false;
    isCompleted.value = false;
    update();
    getLoadingSheetListFromLocal();
  }

  updateEditQuantities(Data item, index) {
    item.qtyList?[index] = editQuantities.value.toDouble();
    saveLoadingSheet();
    update();
  }

  headerExist() async {
    int isExist = await loadingSheetsLocalController
        .isLoadingSheetHeaderAlreadyExist(voucherId: voucherNumber.value);
    return isExist;
  }

  getLocationFromId(String id) async {
    UserLocationModel location =
        userLocationList.firstWhere((element) => element.code == id);
    return location;
  }

  previewApproval(BuildContext context,
      {required String sysDoc, required String voucher}) async {
    isPreviewLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    var data = jsonEncode({
      "FileName": 'Item Transaction',
      "SysDocType": SysdocType.ItemTransaction.value,
      "FileType": 1
    });
    log("${data}");
    var result;
    try {
      var feedback = await ApiManager.fetchDataRawBodyReport(
          api:
              'GetApprovalPreview?token=${token}&SysDocID=${sysDoc}&VoucherID=${voucher}',
          data: data);

      if (feedback != null) {
        log('GetApprovalPreview?token=${token}&SysDocID=${sysDoc}&VoucherID=${voucher}',
            name: 'url');
        log('${data}', name: 'data');
        //     // result = CommonResponseModel.fromJson(feedback);
        //     // response.value = result.res;
        // developer.log(feedback['Modelobject'].toString(), name: 'Preview');
        if (feedback['Modelobject'] != null &&
            feedback['Modelobject'].isNotEmpty) {
          Uint8List bytes = await base64.decode(feedback['Modelobject']);
          // List<int> bytes = base64.decode(feedback['Modelobject']);
          // await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'Approval.pdf');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            'Item Transaction',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mutedColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.mutedColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Expanded(child: Components.buildPdfView(bytes))],
                  ),
                ),
              );
            },
          );
        } else {
          SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
        }

        //     // isPreviewLoading.value = false;
      }
    } finally {
      isPreviewLoading.value = false;
      //   // if (response.value == 1) {
      //   //   remarkscontrol.value.text = ' ';
      //   // }
    }
  }
}
