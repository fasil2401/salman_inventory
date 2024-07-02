import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_brand_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_category_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_class_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_origin_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/tax_group_combo_controller.dart';
import 'package:axolon_inventory_manager/model/ItemCreation%20Model/get_products_by_id.dart';
import 'package:axolon_inventory_manager/model/ItemCreation%20Model/get_unitCombo_model.dart';
import 'package:axolon_inventory_manager/model/common_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/product_common_combo_model.dart'
    as product;
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    homeController.getNextCardNumber();
    getTaxOptionList();
    getItemTypeList();
  }

  var itemCodeController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var aliasController = TextEditingController().obs;
  var itemtypeController = TextEditingController().obs;
  var taxOptionController = TextEditingController().obs;
  var itemclassController = TextEditingController().obs;
  var taxgroupidController = TextEditingController().obs;
  var originController = TextEditingController().obs;
  var categoryController = TextEditingController().obs;
  var brandController = TextEditingController().obs;
  var manufacturerController = TextEditingController().obs;
  var styleController = TextEditingController().obs;

  var mainUomController = TextEditingController().obs;
  var upcController = TextEditingController().obs;
  var sizeController = TextEditingController().obs;

  var itemdescriptionController = TextEditingController().obs;
  var originList = [].obs;
  var categoryList = [].obs;
  var classList = [].obs;
  var brandList = [].obs;
  var filterList = [].obs;
  var styleList = [].obs;
  var manufactureList = [].obs;
  var unitComboList = [].obs;
  var itemTypeList = [].obs;
  var taxOptionList = [].obs;
  var taxGroupIdList = [].obs;
  var filterItemTypeList = [].obs;
  var filtertaxOptionList = [].obs;
  var unitList = [].obs;
  var filterunitList = [].obs;
  var productList = <ProductListModel>[].obs;
  var filterProductList = <ProductListModel>[].obs;

  var isTrackLot = false.obs;
  var isLoading = false.obs;
  var isSaving = false.obs;
  var isNewRecord = true.obs;
  var isOpenListLoading = false.obs;
  final originListController = Get.put(ProductOriginListController());
  final taxgroupIdListController = Get.put(TaxGroupLocalController());
  final categoryListController = Get.put(CategoryListController());
  final brandListController = Get.put(BrandListController());
  final classListController = Get.put(ClassListController());
  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  final productListController = Get.put(ProductListController());
  var selectedmodel = ProductById().obs;

  var dateIndex = 0.obs;
  var isEqualDate = false.obs;
  var isFromDate = false.obs;
  var isToDate = false.obs;
  var fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var toDate = DateTime.now().add(Duration(days: 1)).obs;
  var result = FilePickerResult([]).obs;
  var productImage = ''.obs;

  takePicture() async {
    final XFile? cameraImages = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (cameraImages != null) {
      String base64Image = encodeFileToBase64(cameraImages.path);
      result.value.files.add(PlatformFile(
          path: cameraImages.path, name: cameraImages.name, size: 0));
      if (result.value.files.isNotEmpty) {
        productImage.value = '';
        update();
      }
      result.refresh();
      update();
      return base64Image;
    }
    update();
  }

  String encodeFileToBase64(String path) {
    List<int> imageBytes = File(path).readAsBytesSync();
    return base64Encode(imageBytes);
  }

  selectFile() async {
    result.value = (await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image))!;
    if (result.value.files.isNotEmpty) {
      productImage.value = '';
      update();
    }
    update();
  }

  removeFile(int index) {
    result.value.files.removeAt(index);
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

  getProductList() async {
    isOpenListLoading.value = true;
    try {
      await homeController.getProductList();
      productList.value = homeController.productList;

      update();
    } catch (e) {
      SnackbarServices.errorSnackbar(e.toString());
    } finally {
      isOpenListLoading.value = false;
    }
  }

  getOriginList() async {
    isLoading.value = true;
    if (originList.isEmpty) {
      await originListController.getProductOriginList();
    }
    originList.value = originListController.productOriginList;
    isLoading.value = false;

    update();
  }

  getCategoryList() async {
    isLoading.value = true;
    if (categoryList.isEmpty) {
      await categoryListController.getCategoryList();
    }
    categoryList.value = categoryListController.categoryList;
    isLoading.value = false;

    update();
  }

  getBrandList() async {
    isLoading.value = true;
    if (brandList.isEmpty) {
      await brandListController.getBrandList();
    }
    brandList.value = brandListController.brandList;
    isLoading.value = false;

    update();
  }

  getClassList() async {
    isLoading.value = true;
    if (classList.isEmpty) {
      await classListController.getClassList();
    }
    classList.value = classListController.classList;
    isLoading.value = false;

    update();
  }

  getUnitList() async {
    isLoading.value = true;
    if (unitList.isEmpty) {
      await productListController.getAllUnitList();
    }

    unitList.value = productListController.unitList;

    List<Unitmodel> uniqueUnits = [];
    Set<String> units = HashSet<String>();

    for (Unitmodel unit in unitList) {
      if (!units.contains(unit.code)) {
        uniqueUnits.add(unit);
        units.add(unit.code.toString());
      }
    }

    filterunitList.value = uniqueUnits;
    isLoading.value = false;

    update();
  }

  getStyleList(BuildContext context) async {
    isLoading.value = true;
    if (styleList.isEmpty) {
      await homeController.GetProductStyleList(context);
    }
    styleList.value = homeController.styleList;
    isLoading.value = false;

    update();
  }

  getProductManufactureList() async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api: 'GetProductManufacturerList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);

        manufactureList.value = result.modelobject;
        isLoading.value = false;
      }
    } finally {}
  }

  getUnitCombo() async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchData(api: 'GetUnitCombo?token=${token}');

      if (feedback != null) {
        result = GetUnitComboModel.fromJson(feedback);

        unitComboList.value = result.model;
        isLoading.value = false;
      }
    } finally {}
  }

  getItemTypeList() {
    isLoading.value = true;
    itemTypeList.value = ItemTypes.values.toList();
    filterItemTypeList.value = itemTypeList;
    selectedItemType = ItemTypes.Inventory.value;
    itemtypeController.value.text = "${ItemTypes.Inventory.name}";
    isLoading.value = false;
    update();
  }

  getTaxOptionList() {
    isLoading.value = true;
    taxOptionList.value = ItemTaxOptions.values.toList();
    filtertaxOptionList.value = taxOptionList;
    selectedtaxoption = ItemTaxOptions.BasedOnCustomer.value;
    taxOptionController.value.text = "${ItemTaxOptions.BasedOnCustomer.name}";
    isLoading.value = false;
    update();
  }

  getTaxGroupIdList() async {
    isLoading.value = true;
    if (taxGroupIdList.isEmpty) {
      await taxgroupIdListController.getTaxGroupList();
    }
    taxGroupIdList.value = taxgroupIdListController.taxGroupList;
    isLoading.value = false;

    update();
  }

  int? selectedItemType;
  int? selectedtaxoption;

  getProductOpenList() async {
    isOpenListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String location = UserSimplePreferences.getLocationId() ?? '';
    final data = jsonEncode({
      "token": token,
      "locationid": location,
    });
    dynamic result;
    try {
      var feedback = await ApiManager.fetchCommonDataRawBody(
          api: 'GetProductList', data: data);
      if (feedback != null) {
        result = ProductList.fromJson(feedback);
        productList.value = result.productlistModel;
        productList.insert(0, result.productlistModel.last);
        filterProductList.value = productList;

        isOpenListLoading.value = false;
        update();
      }
    } finally {
      isOpenListLoading.value = false;
    }
  }

  createItem() async {
    isSaving.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    if (homeController.nextcardnumbercontrol.text.isEmpty) {
      await homeController.getNextCardNumber();
    }
    final String token = loginController.token.value;

    String? base64Image;
    if (result.value.files.isNotEmpty) {
      final firstFile = result.value.files.firstOrNull;
      if (firstFile != null) {
        final File lengthFile = File(firstFile.path ?? '');
        var fileSize = await lengthFile.length();
        int quality = 20;
        if (fileSize > 10485760) {
          quality = 20;
        } else if (fileSize > 5242880) {
          quality = 30;
        } else {
          quality = 40;
        }
        final result = await FlutterImageCompress.compressWithFile(
          firstFile.path ?? '',
          quality: quality,
        );
        List<int> imageBytes = result as List<int>;
        base64Image = await base64Encode(imageBytes);

        // base64Image = await encodeFileToBase64(firstFile.path ?? "");
      }
    } else {
      if (productImage.value.isNotEmpty) {
        base64Image = productImage.value;
        //base64Image = await encodeFileToBase64(productImage.value);
        // try {
        //   List<int> imageBytes = File(productImage.value).readAsBytesSync();
        //   String base64Image = base64Encode(imageBytes);

        //   base64Image = base64Image;
        // } catch (e) {
        //   log('Error opening file: $e');
        // }
      }
    }

    final String photo = base64Image ?? "";

    final data = json.encode({
      "token": token,
      "Isnewrecord": isNewRecord.value,
      "ProductID": homeController.nextcardnumbercontrol.text,
      "Description": itemdescriptionController.value.text,
      "Alias": aliasController.value.text,
      "UPC": upcController.value.text,
      "MainUOM": mainUomController.value.text,
      "ItemType": selectedItemType?.toInt() ?? 0,
      "ItemClass": itemclassController.value.text,
      "Origin": originController.value.text,
      "Category": categoryController.value.text,
      "Brand": brandController.value.text,
      "Manufacturer": manufacturerController.value.text,
      "Style": styleController.value.text,
      "IsTrackLot": isTrackLot.value,
      "Description3": descriptionController.value.text,
      "Photo": photo,
      "TaxOption": selectedtaxoption?.toInt() ?? 5,
      "TaxGroupID": taxgroupidController.value.text,
    });

    log("$data ");
    try {
      var feedback = await ApiManager.fetchDataRawBodyInventory(
          api: "CreateProducts", data: data);
      log("${feedback} feedback");
      if (feedback != null) {
        if (feedback['res'] == 1) {
          ProductListModel product = ProductListModel(
            productId: homeController.nextcardnumbercontrol.text,
            description: itemdescriptionController.value.text,
            origin: originController.value.text,
            productimage: photo,
            brand: brandController.value.text,
            manufacturer: manufacturerController.value.text,
            upc: upcController.value.text,
            unitId: mainUomController.value.text,
            modelClass: itemclassController.value.text,
            category: categoryController.value.text.isNotEmpty
                ? await getCategoryName(code: categoryController.value.text)
                : '',
            style: styleController.value.text,
            taxOption: (selectedtaxoption?.toInt() ?? 5).toString(),
            taxGroupId: taxgroupidController.value.text,
            isTrackLot: isTrackLot.value == true ? 1 : 0,
            isInactive: 0,
            isHold: 0,
          );

          await productListController.insertOrUpdateProduct(product: product);
          SnackbarServices.successSnackbar('Item Created Successfully');
          homeController.productList.clear();

          clearData();
          result.value.files.clear();
          productImage.value = '';
          homeController.getNextCardNumber();
          update();
        }
        isSaving.value = false;
      }
      isSaving.value = false;
    } finally {
      isSaving.value = false;
    }
  }

  getProductDetails(String productid) async {
    productImage.value = '';
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;

    GetProductByIdModel results;

    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetProductByID?token=${token}&productID=${productid}');

      if (feedback != null) {
        log("${feedback}");
        results = GetProductByIdModel.fromJson(feedback);

        selectedmodel.value = results.model![0];

        homeController.nextcardnumbercontrol.value =
            TextEditingValue(text: selectedmodel.value.productId ?? "");

        // descriptionController.value.text =
        //     selectedmodel.value.description ?? "";
        descriptionController.value.text = selectedmodel.value.description3;

        aliasController.value.text = selectedmodel.value.description2 ?? "";
        if (selectedmodel.value.itemType == 0) {
          itemtypeController.value.text = '';
        } else {
          int itemTypeValueFromResponse = selectedmodel.value.itemType;
          itemtypeController.value.text =
              getItemTypeName(itemTypeValueFromResponse);
        }

        selectedItemType = selectedmodel.value.itemType;
        log("${selectedItemType}  selectedItemType");
        isTrackLot.value = selectedmodel.value.isTrackLot ?? false;
        itemclassController.value.text = selectedmodel.value.classId ?? "";
        if (selectedmodel.value.taxOption == 5) {
          taxOptionController.value.text = '';
        } else {
          int taxoptionValueFromResponse =
              int.parse(selectedmodel.value.taxOption ?? '0');
          selectedtaxoption = taxOptionList.firstWhere(
              (element) => element.value == taxoptionValueFromResponse);
          taxOptionController.value.text =
              gettaxoptionName(taxoptionValueFromResponse);
        }
        taxgroupidController.value.text = selectedmodel.value.taxGroupId ?? "";

        categoryController.value.text = selectedmodel.value.categoryId ?? "";

        originController.value.text = selectedmodel.value.origin ?? "";

        brandController.value.text = selectedmodel.value.brandId ?? "";
        manufacturerController.value.text =
            selectedmodel.value.manufacturerId ?? "";
        styleController.value.text = selectedmodel.value.styleId ?? "";
        mainUomController.value.text = selectedmodel.value.unitId ?? "";
        upcController.value.text = selectedmodel.value.upc ?? "";
        // itemdescriptionController.value.text =
        //     selectedmodel.value.description3 ?? "";
        itemdescriptionController.value.text =
            selectedmodel.value.description ?? "";

        productImage.value = selectedmodel.value.photo ?? '';
        log("${productImage.value}  productImage.value");
        log("${selectedmodel.value.photo}  productImage");
        isNewRecord.value = false;
        // String photo = selectedmodel.value.photo ?? '';
        // productImage.add(photo);
        // log("${selectedmodel.value.photo.runtimeType}");
        // isNewRecord.value = false;

        update();
      }
    } finally {}
  }

  String getItemTypeName(int itemTypeValue) {
    for (var type in ItemTypes.values) {
      if (type.value == itemTypeValue) {
        return type.name;
      }
    }

    return '';
  }

  String gettaxoptionName(int taxoptoption) {
    for (var type in ItemTaxOptions.values) {
      if (type.value == taxoptoption) {
        return type.name;
      }
    }

    return '';
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

  filterItemtypeList(String value) {
    filterItemTypeList.value = itemTypeList
        .where((element) =>
            element.name.toString().toLowerCase().contains(value.toLowerCase()))
        .toList();

    update();
  }

  filterTaxOptionList(String value) {
    filtertaxOptionList.value = taxOptionList
        .where((element) =>
            element.name.toString().toLowerCase().contains(value.toLowerCase()))
        .toList();

    update();
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

  clearData() {
    homeController.getNextCardNumber();
    homeController.nextcardnumbercontrol.value =
        TextEditingValue(text: selectedmodel.value.productId ?? "");
    itemclassController.value.clear();
    selectedtaxoption = ItemTaxOptions.BasedOnCustomer.value;
    taxOptionController.value.text = "${ItemTaxOptions.BasedOnCustomer.name}";
    taxgroupidController.value.clear();
    originController.value.clear();
    categoryController.value.clear();
    brandController.value.clear();
    mainUomController.value.clear();
    styleController.value.clear();
    manufacturerController.value.clear();
    itemtypeController.value.clear();
    upcController.value.clear();
    aliasController.value.clear();
    isTrackLot.value = false;
    result.value.files.clear();
    // itemCodeController.value.clear();
    descriptionController.value.clear();
    itemdescriptionController.value.clear();
    productImage.value = '';
    isNewRecord.value = true;
    update();
  }

  validation() {
    if (itemdescriptionController.value.text.isEmpty &&
            homeController.nextcardnumbercontrol.text.isEmpty
        // descriptionController.value.text.isEmpty &&
        // itemclassController.value.text.isEmpty &&
        // originController.value.text.isEmpty &&
        // categoryController.value.text.isEmpty &&
        // brandController.value.text.isEmpty &&
        // manufacturerController.value.text.isEmpty &&
        // styleController.value.text.isEmpty &&
        // mainUomController.value.text.isEmpty &&
        // upcController.value.text.isEmpty &&
        // itemdescriptionController.value.text.isEmpty
        ) {
      SnackbarServices.errorSnackbar("Please fill the details");
      return false;
    }

    if (itemdescriptionController.value.text.isEmpty) {
      SnackbarServices.errorSnackbar("Please enter item description");
      return false;
    }
    if (homeController.nextcardnumbercontrol.text.isEmpty) {
      SnackbarServices.errorSnackbar("Please enter item code");
      return false;
    }

    // if (aliasController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter alias");
    //   return false;
    // }

    // if (itemtypeController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter itemtype");
    //   return false;
    // }

    // if (itemclassController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter item class");
    //   return false;
    // }

    // if (originController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter origin");
    //   return false;
    // }

    // if (categoryController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter category");
    //   return false;
    // }

    // if (brandController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter brand");
    //   return false;
    // }

    // if (manufacturerController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter manufacture");
    //   return false;
    // }

    // if (styleController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter style");
    //   return false;
    // }

    // if (mainUomController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter Unit of measures");
    //   return false;
    // }

    // if (upcController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter Upc");
    //   return false;
    // }

    // if (itemdescriptionController.value.text.isEmpty) {
    //   SnackbarServices.errorSnackbar("Please enter item details");
    //   return false;
    // }

    return true;
  }

  Future<String> getCategoryName({required String code}) async {
    if (categoryList.isEmpty) {
      await getCategoryList();
    }
    String categoryName = categoryList
        .firstWhere(
          (element) => element.code == code,
          orElse: () => product.ProductCommonComboModel(),
        )
        .name;
    return categoryName;
  }
}
