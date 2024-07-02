import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/customer_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/customer_sales_person_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/driver_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/loacation_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/loading_sheet_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/out_transfer_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/party_vendor_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_brand_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_class_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_category_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/product_origin_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/stock_snapshot_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/tax_group_combo_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/transfer_type_List_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/user_location_list_local_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/user_security_list_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/vehicle_list_local_controller.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_take_save_detail_model.dart';
import 'package:axolon_inventory_manager/model/get_tax_group_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_location_model.dart';
import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/model/get_customer_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_security_model.dart';
import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:get/get.dart';

class SyncController extends GetxController {
  final stockSnapshotLocalController = Get.put(StockSnapshotLocalController());
  final loadingSheetsLocalController = Get.put(LoadingSheetsLocalController());
  final outTransferLocalController =
      Get.put(CreateOutTransferLocalController());

  final loginController = Get.put(LoginController());
  final productListController = Get.put(ProductListController());
  final originListController = Get.put(ProductOriginListController());
  final brandListController = Get.put(BrandListController());
  final classListController = Get.put(ClassListController());
  final categoryListController = Get.put(CategoryListController());
  final sysDocListController = Get.put(SysDocListController());
  final transferTypeListController = Get.put(TransferTypeListController());
  final locationListController = Get.put(LocationListController());
  final vendorListController = Get.put(PartyVendorListController());
  final customerListController = Get.put(CustomerListLocalController());
  final salesPersonController = Get.put(SalesPersonListController());
  final taxGroupListController = Get.put(TaxGroupLocalController());
  final userSecurityListController = Get.put(UserSecurityListController());
  final driverListController = Get.put(DriverListController());
  final vehicleListController = Get.put(VehicleListController());
  final userLocationListController = Get.put(UserLocationListController());
  var isAllSelectIn = false.obs;
  var isAllSelectOut = false.obs;
  // sync in
  var userSecurityToggle = false.obs;
  var transferTypeToggle = false.obs;
  var systemDocIdToggle = false.obs;
  var locationsToggle = false.obs;
  var customersToggle = false.obs;
  var productMastersToggle = false.obs;

  var isUserSecuritySyncing = false.obs;
  var isTransferTypeSyncing = false.obs;
  var isSystemDocIdSyncing = false.obs;
  var isLocationsSyncing = false.obs;
  var isCustomersSyncing = false.obs;
  var isProductMastersSyncing = false.obs;

  var isUserSecuritySuccess = false.obs;
  var isTransferTypeSuccess = false.obs;
  var isSystemDocIdSuccess = false.obs;
  var isLocationsSuccess = false.obs;
  var isCustomersSuccess = false.obs;
  var isProductMastersSuccess = false.obs;

  var isLoadingUserSecurity = false.obs;
  var isLoadingTransferType = false.obs;
  var isLoadingSystemDocId = false.obs;
  var isLoadingLocations = false.obs;
  var isLoadingCustomers = false.obs;
  var isLoadingProductMasters = false.obs;

  var errorUserSecurity = ''.obs;
  var errorTransferType = ''.obs;
  var errorSystemDocId = ''.obs;
  var errorLocations = ''.obs;
  var errorCustomers = ''.obs;
  var errorProductMasters = ''.obs;

  var isErrorUserSecurity = false.obs;
  var isErrorTransferType = false.obs;
  var isErrorSystemDocId = false.obs;
  var isErrorLocations = false.obs;
  var isErrorCustomers = false.obs;
  var isErrorProductMasters = false.obs;

  var stockSnapshotToggle = false.obs;
  var isStockSnapshotSyncing = false.obs;
  var isStockSnapshotSuccess = false.obs;
  var isLoadingStockSnapshot = false.obs;
  var errorStockSnapshot = ''.obs;
  var isErrorStockSnapshot = false.obs;

  selectAllIn() {
    isAllSelectIn.value = !isAllSelectIn.value;
    userSecurityToggle.value = isAllSelectIn.value;
    transferTypeToggle.value = isAllSelectIn.value;
    systemDocIdToggle.value = isAllSelectIn.value;
    locationsToggle.value = isAllSelectIn.value;
    customersToggle.value = isAllSelectIn.value;
    productMastersToggle.value = isAllSelectIn.value;
  }

  toggleUserSecurity(bool value) {
    userSecurityToggle.value = value;
  }

  toggleTransferType(bool value) {
    transferTypeToggle.value = value;
  }

  toggleSystemDocId(bool value) {
    systemDocIdToggle.value = value;
  }

  toggleLocations(bool value) {
    locationsToggle.value = value;
  }

  toggleCustomers(bool value) {
    customersToggle.value = value;
  }

  toggleProductMasters(bool value) {
    productMastersToggle.value = value;
  }

  syncProductMaster() async {
    isErrorProductMasters.value = false;
    if (productMastersToggle.value == false) return;
    isProductMastersSyncing.value = true;
    isLoadingProductMasters.value = true;

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
    ProductList result;
    CommonComboListModel brandResult;
    CommonComboListModel classResult;
    CommonComboListModel categoryResult;
    CommonComboListModel originResult;
    CommonComboListModel driverResult;
    CommonComboListModel vehicleResult;
    try {
      var feedback = await ApiManager.fetchCommonDataRawBody(
          api: 'GetProductList', data: data);
      if (feedback != null) {
        if (feedback["res"] == 1) {
          result = ProductList.fromJson(feedback);
          await productListController.deleteProductTable();
          await productListController.insertProductList(
              productList: result.productlistModel);
          await productListController.deleteUnitTable();
          await productListController.insertUnitList(
              unitList: result.unitmodel);
          await productListController.deleteProductLocationTable();
          await productListController.insertProductLocationList(
              productLocationList: result.productlocationmodel);
          var brandFeedback = await ApiManager.fetchData(
              api: 'GetProductBrandList?token=$token');
          if (brandFeedback != null) {
            if (brandFeedback["res"] == 1) {
              brandResult = CommonComboListModel.fromJson(brandFeedback);
              await brandListController.deleteBrandTable();
              await brandListController.insertBrandList(
                  brandList: brandResult.model);
              await brandListController.getBrandList();
              log("${brandListController.brandList.length} length");
              var classFeedback = await ApiManager.fetchData(
                  api: 'GetProductClassList?token=$token');
              if (classFeedback != null) {
                if (classFeedback["res"] == 1) {
                  classResult = CommonComboListModel.fromJson(classFeedback);
                  await classListController.deleteClassTable();
                  await classListController.insertClassList(
                      classList: classResult.model);

                  var categoryFeedback = await ApiManager.fetchData(
                      api: 'GetProductCategoryList?token=$token');
                  if (categoryFeedback != null) {
                    if (categoryFeedback["res"] == 1) {
                      categoryResult =
                          CommonComboListModel.fromJson(categoryFeedback);
                      await categoryListController.deleteCategoryTable();
                      await categoryListController.insertCategoryList(
                          categoryList: categoryResult.model);
                      var originFeedback = await ApiManager.fetchDataCRM(
                          api: 'GetCountryList?token=$token');
                      if (originFeedback != null) {
                        if (originFeedback["result"] == 1) {
                          originResult =
                              CommonComboListModel.fromJson(originFeedback);
                          await originListController.deleteProductOriginTable();
                          await originListController.insertProductOriginList(
                              productOriginList: originResult.model);
                          var driverFeedback = await ApiManager.fetchData(
                              api: 'GetDriverComboList?token=$token');
                          if (driverFeedback != null) {
                            if (driverFeedback["res"] == 1) {
                              driverResult =
                                  CommonComboListModel.fromJson(driverFeedback);
                              await driverListController.deleteDriverTable();
                              await driverListController.insertDriverList(
                                  driverList: driverResult.model);
                              var vehicleFeedback = await ApiManager.fetchData(
                                  api: 'GetvehicleComboList?token=$token');
                              if (vehicleFeedback != null) {
                                if (vehicleFeedback["res"] == 1) {
                                  vehicleResult = CommonComboListModel.fromJson(
                                      vehicleFeedback);
                                  await vehicleListController
                                      .deletevehicleTable();
                                  await vehicleListController.insertvehicleList(
                                      vehicleList: vehicleResult.model);

                                  isLoadingProductMasters.value = false;
                                  isProductMastersSuccess.value = true;
                                }
                              } else {
                                errorProductMasters.value =
                                    vehicleFeedback["msg"] ??
                                        vehicleFeedback["err"];
                                isErrorProductMasters.value = true;
                                isLoadingProductMasters.value = false;
                                isProductMastersSuccess.value = false;
                              }
                              isLoadingProductMasters.value = false;
                              isProductMastersSuccess.value = true;
                            }
                          } else {
                            errorProductMasters.value =
                                driverFeedback["msg"] ?? driverFeedback["err"];
                            isErrorProductMasters.value = true;
                            isLoadingProductMasters.value = false;
                            isProductMastersSuccess.value = false;
                          }
                        } else {
                          errorProductMasters.value =
                              originFeedback["msg"] ?? originFeedback["err"];
                          isErrorProductMasters.value = true;
                          isLoadingProductMasters.value = false;
                          isProductMastersSuccess.value = false;
                        }
                      }
                    } else {
                      errorProductMasters.value =
                          categoryFeedback["msg"] ?? categoryFeedback["err"];
                      isErrorProductMasters.value = true;
                      isLoadingProductMasters.value = false;
                      isProductMastersSuccess.value = false;
                    }
                  }
                } else {
                  errorProductMasters.value =
                      classFeedback["msg"] ?? classFeedback["err"];
                  isErrorProductMasters.value = true;
                  isLoadingProductMasters.value = false;
                  isProductMastersSuccess.value = false;
                }
              }
            } else {
              errorProductMasters.value =
                  brandFeedback["msg"] ?? brandFeedback["err"];
              isErrorProductMasters.value = true;
              isLoadingProductMasters.value = false;
              isProductMastersSuccess.value = false;
            }
          }
        } else {
          errorProductMasters.value = feedback["msg"] ?? feedback["err"];
          isErrorProductMasters.value = true;
          isLoadingProductMasters.value = false;
          isProductMastersSuccess.value = false;
        }
      } else {
        errorProductMasters.value = "ERROR! Please try again";
        isErrorProductMasters.value = true;
      }
    } catch (e) {
      isLoadingProductMasters.value = false;
      isProductMastersSuccess.value = false;
      errorProductMasters.value = e.toString();
      isErrorProductMasters.value = true;
    } finally {
      isLoadingProductMasters.value = false;
    }
  }

  syncSystemDocument() async {
    isErrorSystemDocId.value = false;
    if (systemDocIdToggle.value == false) return;
    isSystemDocIdSyncing.value = true;
    isLoadingSystemDocId.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String userLocation = UserSimplePreferences.getLocationId() ?? '';
    SystemDocumentModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetSystemDocumentByUserList?token=${token}&locationid=${userLocation}');
      if (feedback != null) {
        if (feedback["res"] == 1) {
          result = SystemDocumentModel.fromJson(feedback);
          await sysDocListController.deleteSysDocTable();
          await sysDocListController.insertSysDocList(sysDocList: result.mdel);
          isLoadingSystemDocId.value = false;
          isSystemDocIdSuccess.value = true;
        } else {
          errorSystemDocId.value = feedback["msg"] ?? feedback["err"];
          isErrorSystemDocId.value = true;
          isLoadingSystemDocId.value = false;
          isSystemDocIdSuccess.value = false;
        }
      } else {
        errorSystemDocId.value = "ERROR! Please try again";
        isErrorSystemDocId.value = true;
      }
    } catch (e) {
      isLoadingSystemDocId.value = false;
      isSystemDocIdSuccess.value = false;
      errorSystemDocId.value = e.toString();
      isErrorSystemDocId.value = true;
    } finally {
      isLoadingSystemDocId.value = false;
    }
  }

  syncTransferTypes() async {
    isErrorTransferType.value = false;
    if (transferTypeToggle.value == false) return;
    isTransferTypeSyncing.value = true;
    isLoadingTransferType.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    TrasferType result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'InventoryTransferTypeList?token=${token}');
      if (feedback != null) {
        if (feedback["res"] == 1) {
          result = TrasferType.fromJson(feedback);
          await transferTypeListController.deleteTransferTypeTable();
          await transferTypeListController.insertTransferTypeList(
              transferTypeList: result.model);
          isLoadingTransferType.value = false;
          isTransferTypeSuccess.value = true;
        } else {
          errorTransferType.value = feedback["msg"] ?? feedback["err"];
          isErrorTransferType.value = true;
          isLoadingTransferType.value = false;
          isTransferTypeSuccess.value = false;
        }
      } else {
        errorTransferType.value = "ERROR! Please try again";
        isErrorTransferType.value = true;
      }
    } catch (e) {
      isLoadingTransferType.value = false;
      isTransferTypeSuccess.value = false;
      errorTransferType.value = e.toString();
      isErrorTransferType.value = true;
    } finally {
      isLoadingTransferType.value = false;
    }
  }

  syncLocations() async {
    isErrorLocations.value = false;
    if (locationsToggle.value == false) return;
    isLocationsSyncing.value = true;
    isLoadingLocations.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String userId = UserSimplePreferences.getUsername() ?? '';
    LocationListModel result;
    GetUserLocationModel userlocationResult;

    try {
      var feedback =
          await ApiManager.fetchDataCommon(api: 'GetLocation?token=$token');
      if (feedback != null) {
        if (feedback["res"] == 1) {
          result = LocationListModel.fromJson(feedback);
          await locationListController.deleteLocationTable();
          await locationListController.insertLocationList(
              locationList: result.model);
          var userlocationfeedback = await ApiManager.fetchDataCommon(
              api: 'GetUserLocation?token=${token}&userID=${userId}');
          log('User Location Feedback: $userlocationfeedback');
          if (userlocationfeedback != null) {
            if (userlocationfeedback["res"] == 1) {
              userlocationResult =
                  GetUserLocationModel.fromJson(userlocationfeedback);
              await userLocationListController.deleteUserLocationTable();
              await userLocationListController.insertUserLocationList(
                  userlocationList: userlocationResult.model!);
              isLoadingLocations.value = false;
              isLocationsSuccess.value = true;
            } else {
              errorCustomers.value =
                  userlocationfeedback["msg"] ?? userlocationfeedback["err"];
              isErrorLocations.value = true;
              isLoadingLocations.value = false;
              isLocationsSuccess.value = false;
            }
          }
        } else {
          errorLocations.value = feedback["msg"] ?? feedback["err"];
          isErrorLocations.value = true;
          isLoadingLocations.value = false;
          isLocationsSuccess.value = false;
        }
      } else {
        errorLocations.value = "ERROR! Please try again";
        isErrorLocations.value = true;
      }
    } catch (e) {
      isLoadingLocations.value = false;
      isLocationsSuccess.value = false;
      errorLocations.value = e.toString();
      isErrorLocations.value = true;
    } finally {
      isLoadingLocations.value = false;
    }
  }

  syncCustomers() async {
    isErrorCustomers.value = false;
    if (customersToggle.value == false) return;
    isCustomersSyncing.value = true;
    isLoadingCustomers.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    GetVendorComboListModel vendorResult;
    GetCustomerListModel customerResult;
    CommonComboListModel salesPersonResult;
    GetTaxGroupComboListModel taxGroupComboResult;

    try {
      var feedback = await ApiManager.fetchDataVendor(
          api: 'GetVendorComboList?token=$token');
      if (feedback != null) {
        if (feedback["res"] == 1) {
          vendorResult = GetVendorComboListModel.fromJson(feedback);
          await vendorListController.deletePartyVendorTable();
          await vendorListController.insertPartyVendorList(
              partyVendorList: vendorResult.modelobject ?? []);
          var customerFeedback = await ApiManager.fetchDataCommon(
              api: 'GetCustomerList?token=$token');
          if (customerFeedback != null) {
            if (customerFeedback["result"] == 1) {
              customerResult = GetCustomerListModel.fromJson(customerFeedback);
              await customerListController.deleteCustomerTable();
              await customerListController.insertCustomerList(
                  customerList: customerResult.modelobject ?? []);
              var salesPersonFeedback = await ApiManager.fetchDataCommon(
                  api: 'GetSalespersonList?token=$token');
              if (salesPersonFeedback != null) {
                if (salesPersonFeedback["result"] == 1) {
                  salesPersonResult =
                      CommonComboListModel.fromJson(salesPersonFeedback);
                  await salesPersonController.deleteSalesPersonTable();
                  await salesPersonController.insertSalesPersonList(
                      salesPersonList: salesPersonResult.model);
                  var taxGroupListFeedback = await ApiManager.fetchData(
                      api: 'GetTaxGroupComboList?token=$token');
                  if (taxGroupListFeedback != null) {
                    if (taxGroupListFeedback["res"] == 1) {
                      taxGroupComboResult = GetTaxGroupComboListModel.fromJson(
                          taxGroupListFeedback);
                      await taxGroupListController.deleteTaxGroupTable();
                      await taxGroupListController.insertTaxGroupList(
                          taxGroupList: taxGroupComboResult.model ?? []);
                      isLoadingCustomers.value = false;
                      isCustomersSuccess.value = true;
                    } else {
                      errorCustomers.value = taxGroupListFeedback["msg"] ??
                          taxGroupListFeedback["err"];
                      isErrorCustomers.value = true;
                      isLoadingCustomers.value = false;
                      isCustomersSuccess.value = false;
                    }
                  }
                } else {
                  errorCustomers.value =
                      salesPersonFeedback["msg"] ?? salesPersonFeedback["err"];
                  isErrorCustomers.value = true;
                  isLoadingCustomers.value = false;
                  isCustomersSuccess.value = false;
                }
              }
            } else {
              errorCustomers.value =
                  customerFeedback["msg"] ?? customerFeedback["err"];
              isErrorCustomers.value = true;
              isLoadingCustomers.value = false;
              isCustomersSuccess.value = false;
            }
          }
        } else {
          errorCustomers.value = feedback["msg"] ?? feedback["err"];
          isErrorCustomers.value = true;
          isLoadingCustomers.value = false;
          isCustomersSuccess.value = false;
        }
      } else {
        errorCustomers.value = "ERROR! Please try again";
        isErrorCustomers.value = true;
      }
    } catch (e) {
      isLoadingCustomers.value = false;
      isCustomersSuccess.value = false;
      errorCustomers.value = e.toString();
      isErrorCustomers.value = true;
    } finally {
      isLoadingCustomers.value = false;
    }
  }

  syncUserSecurity() async {
    isErrorUserSecurity.value = false;
    if (userSecurityToggle.value == false) return;
    isUserSecuritySyncing.value = true;
    isLoadingUserSecurity.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    final String userName = UserSimplePreferences.getUsername() ?? '';
    GetUserSecurityModel result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api: 'GetUserSecurity?token=${token}&userID=${userName}');
      if (feedback != null) {
        if (feedback["result"] == 1) {
          result = GetUserSecurityModel.fromJson(feedback);
          await userSecurityListController.deleteDefaultObjTable();
          await userSecurityListController.addDefaultObjectList(
              objects: result.defaultsObj);
          await userSecurityListController.deleteMenuSecurityTable();
          await userSecurityListController.addMenuSecurityObjectList(
              objects: result.menuSecurityObj);
          await userSecurityListController.deleteScreenSecurityTable();
          await userSecurityListController.addScreenSecurityObjectList(
              objects: result.screenSecurityObj);
          isLoadingUserSecurity.value = false;
          isUserSecuritySuccess.value = true;
        } else {
          errorUserSecurity.value = feedback["msg"] ?? feedback["err"];
          isErrorUserSecurity.value = true;
          isLoadingUserSecurity.value = false;
          isUserSecuritySuccess.value = false;
        }
      } else {
        errorUserSecurity.value = "ERROR! Please try again";
        isErrorUserSecurity.value = true;
      }
    } catch (e) {
      isLoadingUserSecurity.value = false;
      isUserSecuritySuccess.value = false;
      errorUserSecurity.value = e.toString();
      isErrorUserSecurity.value = true;
    } finally {
      isLoadingUserSecurity.value = false;
    }
  }

  startInSync() async {
    await syncUserSecurity();
    await syncTransferTypes();
    await syncSystemDocument();
    await syncLocations();
    await syncCustomers();
    await syncProductMaster();
  }

  bool checkIsSynced() {
    bool isSynced = UserSimplePreferences.getIsSyncCompleted() ?? false;
    bool status = false;
    if (isSynced == false) {
      if (isProductMastersSuccess.value &&
          isSystemDocIdSuccess.value &&
          isTransferTypeSuccess.value &&
          isLocationsSuccess.value &&
          isUserSecuritySuccess.value) {
        status = true;
        UserSimplePreferences.setIsSyncCompleted(true);
      } else {
        SnackbarServices.errorSnackbar('Please Complete Syncing to Continue!');
        status = false;
        UserSimplePreferences.setIsSyncCompleted(false);
      }
    } else {
      status = true;
      UserSimplePreferences.setIsSyncCompleted(true);
    }
    return status;
  }

  // sync out start
  bool checkOutSynced() {
    bool isSynced = UserSimplePreferences.getIsSyncCompleted() ?? false;
    bool status = false;
    if (isSynced == false) {
      if (isLoadingSheetSuccess.value) {
        status = true;
        UserSimplePreferences.setIsSyncCompleted(true);
      } else {
        SnackbarServices.errorSnackbar('Please Complete Syncing to Continue!');
        status = false;
        UserSimplePreferences.setIsSyncCompleted(false);
      }
    } else {
      status = true;
      UserSimplePreferences.setIsSyncCompleted(true);
    }
    return status;
  }

  var inventoryTransferToggle = false.obs;

  var isInventoryTransferSyncing = false.obs;

  var isInventoryTransferSuccess = false.obs;

  var isLoadingInventoryTransfer = false.obs;

  var errorInventoryTransfer = ''.obs;

  var isErrorInventoryTransfer = false.obs;

  selectAllOut() {
    isAllSelectOut.value = !isAllSelectOut.value;
    inventoryTransferToggle.value = isAllSelectOut.value;
    loadingSheetToggle.value = isAllSelectOut.value;
  }

  toggleInventoryTransfer(bool value) {
    inventoryTransferToggle.value = value;
  }

  var loadingSheetToggle = false.obs;

  var isLoadingSheetSyncing = false.obs;

  var isLoadingLoadingSheet = false.obs;

  var errorLoadingSheet = ''.obs;

  var isErrorLoadingSheet = false.obs;
  var isLoadingSheetSuccess = false.obs;

  toggleLoadingSheet(bool value) {
    loadingSheetToggle.value = value;
  }

  syncLoadingSheetFromLocal() async {
    log('Syncing stock snapshot');
    isErrorLoadingSheet.value = false;
    if (loadingSheetToggle.value == false) return;
    await loadingSheetsLocalController.getLoadingSheetsHeaders();
    if (loadingSheetsLocalController.loadingSheetsHeaders.isEmpty) {
      isLoadingSheetSyncing.value = true;
      isLoadingSheetSuccess.value = true;
      return;
    }
    isLoadingSheetSyncing.value = true;
    isLoadingLoadingSheet.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }

    log('Syncing continues ${loadingSheetsLocalController.loadingSheetsHeaders.length}');

    final String token = loginController.token.value;
    for (var header in loadingSheetsLocalController.loadingSheetsHeaders) {
      if (header.isSynced == 1) {
        isLoadingLoadingSheet.value = false;
        isLoadingSheetSuccess.value = true;

        continue;
      } else {
        isLoadingSheetSyncing.value = true;
        isLoadingLoadingSheet.value = true;
      }
      await loadingSheetsLocalController.getloadingSheetsDetails(
          voucher: header.voucherid ?? '');

      final data = jsonEncode({
        "token": "${token}",
        "Sysdocid": header.sysdocid ?? '',
        "SysDocType": int.parse(header.documentType ?? "0"),
        "Voucherid": header.voucherid ?? '',
        "PartyType": header.partyType ?? '',
        "PartyID": header.partyId ?? '',
        "LocationID": header.fromLocationId ?? '',
        "Salespersonid": header.salespersonid ?? '',
        "Currencyid": header.currencyid ?? '',
        "TransactionDate": header.transactionDate,
        "Reference1": '',
        "Reference2": '',
        "Reference3": '',
        "Note": header.note ?? '',
        "Isvoid": false,
        "Discount": header.discount ?? 0,
        "Total": header.total ?? 0,
        "Roundoff": header.roundoff ?? 0,
        "Isnewrecord": header.isnewrecord == 0 ? false : true,
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
            isLoadingSheetSuccess.value = true;
            isLoadingLoadingSheet.value = false;
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
            isLoadingLoadingSheet.value = false;
            isLoadingSheetSuccess.value = false;
            errorLoadingSheet.value = feedback['msg'] ?? feedback['err'];
            isErrorLoadingSheet.value = true;
            // SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
            await loadingSheetsLocalController.updateloadingSheetsHeaders(
                voucherId: header.voucherid ?? '',
                isSynced: 0,
                isError: 1,
                error: feedback['msg'] ?? feedback['err']);
          }
        }
      } catch (e) {
        isLoadingLoadingSheet.value = false;
        isLoadingSheetSuccess.value = false;
        errorLoadingSheet.value = e.toString();
        isErrorLoadingSheet.value = true;
      } finally {
        isLoadingLoadingSheet.value = false;
      }
    }
  }

  syncStockSnapshot() async {
    log('Syncing stock snapshot');
    isErrorStockSnapshot.value = false;
    await stockSnapshotLocalController.getStockSnapshotHeaders();
    isStockSnapshotSyncing.value = true;
    isLoadingStockSnapshot.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }

    log('Syncing continues ${stockSnapshotLocalController.stockSnapshotHeaders.length}');

    final String token = loginController.token.value;
    for (var header in stockSnapshotLocalController.stockSnapshotHeaders) {
      if (header.isSynced == 1) {
        // isStockSnapshotSyncing.value = false;
        isLoadingStockSnapshot.value = false;
        isStockSnapshotSuccess.value = true;

        continue;
      } else {
        isStockSnapshotSyncing.value = true;
        isLoadingStockSnapshot.value = true;

        await stockSnapshotLocalController.getStockSnapshotDetails(
            voucher: header.voucherid ?? '');
        List<StockTakeSaveDetailModel> detail = [];
        for (StockTakeSaveDetailModel item
            in stockSnapshotLocalController.stockSnapshotDetail) {
          detail.add(StockTakeSaveDetailModel(
              description: item.description,
              itemcode: item.itemcode,
              listrowindex: null,
              listsysdocid: null,
              listvoucherid: null,
              onhand: item.onhand,
              physicalqty: item.physicalqty,
              refdate1: null,
              refdate2: null,
              refnum1: null,
              refnum2: null,
              refslno: null,
              reftext1: null,
              reftext2: null,
              remarks: '',
              rowindex: item.rowindex,
              unitid: item.unitid));
        }
        final data = jsonEncode({
          "token": token,
          "sysdocid": header.sysdocid,
          "voucherid": header.voucherid,
          "companyid": header.companyid,
          "divisionid": header.divisionid,
          "locationid": header.locationid,
          "adjustmenttype": header.adjustmenttype,
          "refrence": header.refrence,
          "description": header.description,
          "isnewrecord": header.isnewrecord == 1 ? true : false,
          "Status": header.status,
          "transactiondate": header.transactiondate,
          "details": detail
        });
        log("${data}");
        try {
          var feedback = await ApiManager.fetchDataRawBodyInventory(
            api: 'CreateStockSnapShot',
            data: data,
          );
          log("$feedback");
          if (feedback != null) {
            if (feedback['res'] == 1) {
              await stockSnapshotLocalController.updateStockSnapshotHeaders(
                voucherId: header.voucherid ?? '',
                isSynced: 1,
                isError: 0,
                error: '',
              );
              await stockSnapshotLocalController.updateStockSnapshotDetails(
                voucherId: header.voucherid ?? '',
              );
              await stockSnapshotLocalController
                  .updateStockSnapshotHeadersVoucher(
                      voucherId: header.voucherid!, docNo: feedback['docNo']);
            } else {
              isLoadingStockSnapshot.value = false;
              isStockSnapshotSuccess.value = false;
              errorStockSnapshot.value = feedback['msg'] ?? feedback['err'];
              isErrorStockSnapshot.value = true;
              // SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
              await stockSnapshotLocalController.updateStockSnapshotHeaders(
                voucherId: header.voucherid ?? '',
                isSynced: 0,
                isError: 1,
                error: feedback['msg'] ?? feedback['err'],
              );
            }
          }
        } catch (e) {
          isLoadingStockSnapshot.value = false;
          isStockSnapshotSuccess.value = false;
          errorStockSnapshot.value = e.toString();
          isErrorStockSnapshot.value = true;
        } finally {
          isLoadingStockSnapshot.value = false;
        }
      }
    }
  }

  syncOutTransferFromLocal() async {
    log('Syncing stock snapshot');
    if (inventoryTransferToggle.value == false) return;
    await outTransferLocalController.getOutTransferHeaders();
    if (outTransferLocalController.outTransferHeaders.isEmpty) {
      isInventoryTransferSyncing.value = true;
      isInventoryTransferSuccess.value = true;
      return;
    }
    isInventoryTransferSyncing.value = true;
    isLoadingInventoryTransfer.value = true;

    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }

    log('Syncing continues ${outTransferLocalController.outTransferHeaders.length}');

    final String token = loginController.token.value;
    for (var header in outTransferLocalController.outTransferHeaders) {
      if (header.isSynced == 1) {
        isLoadingInventoryTransfer.value = false;
        isInventoryTransferSuccess.value = true;

        continue;
      } else {
        isInventoryTransferSyncing.value = true;
        isLoadingInventoryTransfer.value = true;

        await outTransferLocalController.getOutTransferDetails(
            voucher: header.voucherId ?? '');
        final data = jsonEncode({
          "token": token,
          "IsnewRecord": true,
          "InventoryTransfer": {
            "SysDocId": header.sysDocId,
            "VoucherId": header.voucherId,
            "TransferTypeId": header.transferTypeId,
            "AcceptReference": null,
            "TransactionDate": header.transactionDate.toString(),
            "DivisionId": null,
            "LocationFromId": header.locationFromId,
            "LocationToId": header.locationToId,
            "VehicleNumber": null,
            "DriverId": null,
            "Reference": null,
            "Description": null,
            "Reason": null,
            "isRejectedTransfer": true
          },
          "InventoryTransferDetails":
              outTransferLocalController.outTransferDetails
        });
        log("${data}");
        try {
          var feedback = await ApiManager.fetchCommonDataRawBody(
            api: 'CreateTransferOut',
            data: data,
          );
          log("$feedback");
          if (feedback != null) {
            if (feedback['res'] == 1) {
              await outTransferLocalController.updateoutTransferHeaders(
                voucherId: header.voucherId ?? '',
                isSynced: 1,
                isError: 0,
                error: '',
              );
              await outTransferLocalController.updateOutTransferDetails(
                voucherId: header.voucherId ?? '',
              );
              await outTransferLocalController.updateOutTransferHeaderVoucher(
                  voucherId: header.voucherId!, docNo: feedback['docNo']);
            } else {
              isLoadingInventoryTransfer.value = false;
              isInventoryTransferSuccess.value = false;
              errorInventoryTransfer.value = feedback['msg'] ?? feedback['err'];
              isErrorInventoryTransfer.value = true;
              // SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
              await outTransferLocalController.updateoutTransferHeaders(
                voucherId: header.voucherId ?? '',
                isSynced: 0,
                isError: 1,
                error: feedback['msg'] ?? feedback['err'],
              );
            }
          }
        } catch (e) {
          isLoadingInventoryTransfer.value = false;
          isInventoryTransferSuccess.value = false;
          errorInventoryTransfer.value = e.toString();
          isErrorInventoryTransfer.value = true;
        } finally {
          isLoadingInventoryTransfer.value = false;
        }
      }
    }
  }

  startOutSync() async {
    await syncOutTransferFromLocal();
    await syncLoadingSheetFromLocal();

    if (isLoadingSheetSyncing.value == true ||
        isInventoryTransferSyncing.value == true) {
      if (isErrorLoadingSheet.value == false &&
          isErrorInventoryTransfer.value == false) {
        SnackbarServices.successSnackbar('Syncing Finished Successfully!');
      } else {
        SnackbarServices.errorSnackbar('Syncing Finished With Errors!');
      }
    }
  }
}
