import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/loacation_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/transfer_type_List_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/user_location_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/user_security_list_controller.dart';
import 'package:axolon_inventory_manager/model/common_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_employee_model.dart';
import 'package:axolon_inventory_manager/model/get_user_security_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/model/use_by_id_model.dart';
import 'package:axolon_inventory_manager/model/user_location_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/model/get_user_location_model.dart'
    as userLoc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  final productLocalController = Get.put(ProductListController());
  final userSecuritycontroller = Get.put(UserSecurityListController());
  final locationListController = Get.put(LocationListController());
  final transferTypeListController = Get.put(TransferTypeListController());
  final userLocationListController = Get.put(UserLocationListController());
  final loginController = Get.put(LoginController());
  var isLocationLoading = false.obs;
  var userLocationController = TextEditingController().obs;
  TextEditingController nextcardnumbercontrol = TextEditingController();
  var isLoading = false.obs;
  var commonFilterList = [].obs;
  var commonItemList = [].obs;
  var vendorList = [].obs;
  var inspectorList = [].obs;
  var originList = [].obs;
  var categoryList = [].obs;
  var brandList = [].obs;
  var styleList = [].obs;
  var model = [].obs;
  // var screenSecurity = [].obs;
  var employeeId = ''.obs;
  var response = 0.obs;
  var userImage = ''.obs;
  var attachmentMethod = 0.obs;
  var productList = <ProductListModel>[].obs;
  var locationList = <LocationModel>[].obs;
  var userLocallLocationList = <userLoc.UserLocationModel>[].obs;
  var transferTypeList = <TransferTypeModel>[].obs;
  var userLocationList = <UserLocationModel>[].obs;
  var userLocation = UserLocationModel().obs;
  var user = UserModel().obs;
  var menuSecurity = <MenuSecurityObj>[].obs;
  var screenSecurity = [].obs;

  selectComboOption(
      {required BuildContext context,
      required String heading,
      required var list,
      required ComboOptions combo}) async {
    var selectedComboItem;
    commonFilterList.value = list;
    commonItemList.value = list;

    switch (combo) {
      case ComboOptions.Inspector:
        {
          if (list != null) {
            isLoading.value = false;
            inspectorList = list;
          }
          if (inspectorList.isEmpty) {
            getInspectorList(context);
          }
        }
        break;
      case ComboOptions.Vendor:
        {
          if (list != null) {
            isLoading.value = false;
            vendorList = list;
          }
          if (vendorList.isEmpty) {
            GetVendorComboList();
          }
        }
        break;
      case ComboOptions.Origin:
        {
          if (list != null) {
            isLoading.value = false;
            originList = list;
          }
          if (originList.isEmpty) {
            GetCountryList(context);
          }
        }
        break;
      case ComboOptions.Category:
        {
          if (list != null) {
            isLoading.value = false;
            categoryList = list;
          }
          if (categoryList.isEmpty) {
            GetProductCategoryList(context);
          }
        }
        break;
      case ComboOptions.Brand:
        {
          if (list != null) {
            isLoading.value = false;
            brandList = list;
          }
          if (brandList.isEmpty) {
            GetProductBrandList(context);
          }
        }
        break;
      case ComboOptions.Style:
        {
          if (list != null) {
            isLoading.value = false;
            styleList = list;
          }
          if (styleList.isEmpty) {
            GetProductStyleList(context);
          }
        }
        break;
      default:
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Center(
            child: Text(
              heading,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: 'Search',
                    contentPadding: EdgeInsets.all(8)),
                onChanged: (value) {
                  if (value.isEmpty) {
                    commonFilterList.value = list;
                  }
                  searchOptionList(value, list);
                },
                // onEditingComplete: () async {
                //   await changeFocus(context);
                // },
              ),
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => isLoading.value
                        ? CommonWidgets.popShimmer()
                        : commonFilterList.isEmpty
                            ? Center(
                                child: Text('No Data Found'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: commonFilterList.length,
                                itemBuilder: (context, index) {
                                  var item = commonFilterList[index];
                                  return InkWell(
                                    onTap: () {
                                      selectedComboItem = item;
                                      // Navigator.pop(context);
                                      Navigator.pop(context);
                                      // commonFilterList.value = list;
                                      // return this.customer.value;
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "${item.code} - ",
                                              minFontSize: 10,
                                              maxFontSize: 12,
                                              style: TextStyle(
                                                height: 1.5,
                                                color: commonBlack,
                                              ),
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                "${item.name}",
                                                minFontSize: 10,
                                                maxFontSize: 12,
                                                style: TextStyle(
                                                  height: 1.5,
                                                  color: mutedColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      // this.customer.value = CustomerModel();
                      // Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Close',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return selectedComboItem;
  }

  getNextCardNumber() async {
    isLoading.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    const String tablename = "Product";
    const String id = "ProductID";
    try {
      var feedback = await ApiManager.fetchDataCommon(
        api: 'GetNextCardNumber?token=$token&tableName=$tablename&id=$id',
      );
      if (feedback != null) {
        if (feedback['result'] == 1) {
          response.value = feedback['result'];
          nextcardnumbercontrol.text = feedback['code'];
          isLoading.value = false;
        }
      }
    } finally {
      if (response.value == 1) {
        isLoading.value = false;
      }
    }
  }

  GetProductCategoryList(BuildContext context) async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchData(
          api: 'GetProductCategoryList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        categoryList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  getInspectorList(BuildContext context) async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchDataQc(api: 'GetInspectorList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        inspectorList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  GetVendorComboList() async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchDataVendor(
          api: 'GetVendorComboList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        vendorList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  GetCountryList(BuildContext context) async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchDataCRM(api: 'GetCountryList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        originList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  GetProductBrandList(BuildContext context) async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchData(api: 'GetProductBrandList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        brandList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  GetProductStyleList(BuildContext context) async {
    isLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchData(api: 'GetProductStyleList?token=${token}');

      if (feedback != null) {
        result = CommonComboListModel.fromJson(feedback);
        // response.value = result.result;
        styleList.value = result.modelobject;
        isLoading.value = false;
        //  log("${response.toString()}");
      }
    } finally {
      // if (response.value == 1) {
      //   //   log(response.string);
      // }
    }
  }

  getUserLocationList() async {
    isLocationLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String userId = UserSimplePreferences.getUsername() ?? '';
    UserLocationListModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetUserLocation?token=$token&userid=$userId');

      if (feedback != null) {
        result = UserLocationListModel.fromJson(feedback);
        userLocationList.value = result.model ?? [];
        update();
      }
    } finally {
      isLocationLoading.value = false;
    }
  }

  setUserLocation(UserLocationModel location) {
    userLocation.value = location;
    UserSimplePreferences.setLocationId(location.code ?? '');
    UserSimplePreferences.setLocation(location.name ?? '');
  }

  String getNextVoucher({required SysDocModel sysDoc}) {
    return '${sysDoc.numberPrefix}${sysDoc.nextNumber.toString().padLeft(6, '0')}';
  }

  getProductList() async {
    if (productList.isEmpty) {
      await productLocalController.getProductList();
      productList.value = productLocalController.productList;
    }

    update();
  }

  getLocationList() async {
    await locationListController.getLocationList();
    locationList.value = locationListController.locationList;
    update();
  }

  getUserLocationLocalList() async {
    if (userLocallLocationList.isEmpty) {
      await userLocationListController.getUserLocationList();
      userLocallLocationList.value =
          userLocationListController.userlocationList;
    }

    update();
  }

  getTransferTypeList() async {
    if (transferTypeList.isEmpty) {
      await transferTypeListController.getTransferTypeList();
      transferTypeList.value = transferTypeListController.transferTypeList;
    }

    update();
  }

  Future<String> getVoucherNumber(String sysDocId) async {
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    String voucher = '';
    String date = DateTime.now().toIso8601String();
    // dynamic result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetNextDocumentNo?token=${token}&sysDocID=${sysDocId}&dateTime=${date}');
      if (feedback != null) {
        voucher = feedback["model"];
        // result = VoucherNumberModel.fromJson(feedback);
        // print(result);
        // response.value = result.res;
        // voucherNumber.value = result.model;
        // isVoucherLoading.value = false;
      }
    } finally {
      // if (response.value == 1) {}
    }
    return voucher;
  }

  searchOptionList(String value, var list) {
    commonFilterList.value = list.value
        .where((element) =>
            (element.code).toLowerCase().contains(value.toLowerCase()) ||
            (element.name).toLowerCase().contains(value.toLowerCase()) as bool)
        .toList();
    // commonFilterList.value = list.value.from();
  }

  bool isUserRightAvailable(String value) {
    var data = menuSecurity
        .where((row) => (row.menuId == value && row.enable == true));
    if (data.length >= 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isScreenRightAvailable(
      {required String screenId, required ScreenRightOptions type}) {
    var data;
    String message = '';

    bool isScreenIdPresent = screenSecurity.contains(screenId);
    if (isScreenIdPresent) {
      return true;
    }
    switch (type) {
      case ScreenRightOptions.View:
        data = screenSecurity.firstWhere(
            (row) => (row.screenId == screenId && row.viewRight == true),
            orElse: () => null);
        message = 'User dont have permission to view this page !!';
        break;
      case ScreenRightOptions.Edit:
        data = screenSecurity.firstWhere(
            (row) => (row.screenId == screenId && row.editRight == true),
            orElse: () => ScreenSecurityObj());
        message = 'User dont have permission to Edit this page !!';
        break;
      case ScreenRightOptions.Add:
        data = screenSecurity.firstWhere(
            (row) => (row.screenId == screenId && row.newRight == true),
            orElse: () => null);
        message = 'User dont have permission to Add this!!';
        break;
      case ScreenRightOptions.Delete:
        data = screenSecurity.firstWhere(
            (row) => (row.screenId == screenId && row.deleteRight == true),
            orElse: () => null);
        message = 'User dont have permission to Delete this!!';
        break;
      default:
    }
    if (data != null && data.screenId != null || user.value.isAdmin == true) {
      // developer.log(data.viewRight.toString(), name: 'Screen right');
      return true;
    } else {
      if (type == ScreenRightOptions.View) {
        // SnackbarServices.errorSnackbar(message);
      }

      return false;
    }
  }

  getUserById() async {
    isLoading.value = true;
    // await loginController.getToken();
    final String token = loginController.token.value;
    final String userId = loginController.userId.value;
    dynamic result;

    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetUserByID?token=${token}&userid=${userId}');
      if (feedback != null) {
        result = UserByIdModel.fromJson(feedback);
        response.value = result.res;
        if (result.model != null && result.model.isNotEmpty) {
          user.value = result.model[0];
        }

        log("${user.value.isAdmin} is admin");
        isLoading.value = false;
      }
      isLoading.value = false;
    } finally {
      if (response.value == 1) {
        isLoading.value = false;
        // getUserEmployeeDetails();
      }
    }
  }

  getUserUserSecurityList() async {
    await getUserById();
    getUserEmployeeDetails();
  }

  getUserDetails() async {
    // await checkForDbSwitch();
    await getSyncedUserSecurity();
    await loginController.getToken();
    final String userName = await UserSimplePreferences.getUsername() ?? '';
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;

    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetUserDetails?token=${token}&userid=${userName}');
      if (feedback != null) {
        result = UserByIdModel.fromJson(feedback);
        response.value = result.res;
        model.value = result.model;
      }
      if (response.value == 1) {
        employeeId.value = model[0].employeeId ?? '';
      }
    } finally {
      getUserUserSecurityList();
    }
  }

  getSyncedUserSecurity() async {
    await userSecuritycontroller.getMenuScurityObjects();
    await userSecuritycontroller.getScreenScurityObjects();
    await userSecuritycontroller.getDefaultObjects();
    menuSecurity.value = userSecuritycontroller.menuSecurityObjectList;
    screenSecurity.value = userSecuritycontroller.screenSecurityObjectList;
    // userSecuritycontroller.menuSecurityObjectList.value =
    //     userSecuritycontroller.menuSecurityObjectList;
    // userSecuritycontroller.screenSecurityObjectList.value =
    //     userSecuritycontroller.screenSecurityObjectList;
    update();
  }

  getUserEmployeeDetails() async {
    // await loginController.getToken();
    final String employeeId = this.employeeId.value.toString();
    final String token = loginController.token.value;
    dynamic result;

    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetUserEmployee?token=${token}&employeeID=${employeeId}');
      if (feedback != null) {
        result = GetUserEmployeeModel.fromJson(feedback);
        response.value = result.res;
        model.value = result.model;
      }

      if (response.value == 1) {
        if (model.isNotEmpty) {
          userImage.value = model[0].photo ?? '';
        }
      }
    } finally {}
  }
}
