import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/sysdoc_list_controller.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/attachment_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/create_arrival_report_details_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/get_arrival_report_by_id_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/get_arrival_report_list_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/get_tasklist_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/item_list_model.dart';
import 'package:axolon_inventory_manager/model/attachment_list_model.dart';
import 'package:axolon_inventory_manager/model/common_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart' as print;

class QualityControlController extends GetxController {
  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  final sysDocListController = Get.put(SysDocListController());
  // final arrivalLocalController = Get.put(ArrivalReportOpenListItemController());

  @override
  void onInit() {
    super.onInit();
    fetchDefaults();
  }

  var selectedSysDoc = SysDocModel().obs;
  var result = FilePickerResult([]).obs;
  var isLoading = false.obs;
  var isOpenListLoading = false.obs;
  var isTaskListLoading = false.obs;
  var isNewRecord = true.obs;
  var dateIndex = 0.obs;
  var isEqualDate = false.obs;
  var isFromDate = false.obs;
  var isToDate = false.obs;
  var fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var toDate = DateTime.now().add(Duration(days: 1)).obs;
  var arrivalOpenList = <ArrivalOpenListModel>[].obs;
  var taskList = <TaskListModel>[].obs;
  var taskFilterList = <TaskListModel>[].obs;
  var task = TaskListModel().obs;
  var vendor = CommonComboModel().obs;
  var inspector = CommonComboModel().obs;
  var origin = CommonComboModel().obs;
  var commodit = CommonComboModel().obs;
  var brand = CommonComboModel().obs;
  var variety = CommonComboModel().obs;
  var packingCondition = PackingCondition.Good.obs;
  var conclusion = Conclusion.NoClaim.obs;
  var lastItem = ItemListModel(itemId: "").obs;
  var vesselNameController = TextEditingController().obs;
  var containerTempController = TextEditingController().obs;
  var referenceController = TextEditingController().obs;
  var palletCountController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var headerRemarkController = TextEditingController().obs;
  var weightLessController = TextEditingController().obs;
  var headerWasteController = TextEditingController().obs;
  var headerProgressiveController = TextEditingController().obs;
  var headerCosmeticController = TextEditingController().obs;
  var headerBruiseController = TextEditingController().obs;
  var attchmentList = <AttachmentListModel>[].obs;
  var commoditController = TextEditingController().obs;
  var varietyController = TextEditingController().obs;
  var brandController = TextEditingController().obs;
  var wasteController = TextEditingController().obs;
  var gradeController = TextEditingController().obs;
  var sizeController = TextEditingController().obs;
  var countController = TextEditingController().obs;
  var lotNoController = TextEditingController().obs;
  var growerController = TextEditingController().obs;
  var stWeightController = TextEditingController().obs;
  var bruisController = TextEditingController().obs;
  var progressController = TextEditingController().obs;
  var cosmeticController = TextEditingController().obs;
  var weightController = TextEditingController().obs;
  var brixController = TextEditingController().obs;
  var pressureController = TextEditingController().obs;
  var remarksController = TextEditingController().obs;
  var sysDocList = <SysDocModel>[].obs;
  var voucherNumber = ''.obs;
  var containerNumberController = TextEditingController().obs;
  var isPrintLoading = false.obs;
  var printingIndex = 0.obs;

  prefilDataonUpdate(ItemListModel item) {
    commodit.value = item.commodit ?? CommonComboModel();
    brand.value = item.brand ?? CommonComboModel();
    variety.value = item.variety ?? CommonComboModel();
    commoditController.value.text =
        '${item.commodit?.code ?? ''} - ${item.commodit?.name ?? ''}';
    varietyController.value.text =
        '${item.variety?.code ?? ''} - ${item.variety?.name ?? ''}';
    brandController.value.text =
        '${item.brand?.code ?? ''} - ${item.brand?.name ?? ''}';
    wasteController.value.text =
        item.waste != null ? item.waste.toString() : '';
    gradeController.value.text = item.grade ?? '';
    sizeController.value.text = item.size ?? '';
    countController.value.text =
        item.count != null ? item.count.toString() : '';
    lotNoController.value.text = item.lotNo ?? '';
    growerController.value.text = item.grower ?? '';
    stWeightController.value.text =
        item.stWeight != null ? item.stWeight.toString() : '';
    bruisController.value.text =
        item.bruis != null ? item.bruis.toString() : '';
    progressController.value.text =
        item.progress != null ? item.progress.toString() : '';
    cosmeticController.value.text =
        item.cosmetic != null ? item.cosmetic.toString() : '';
    weightController.value.text =
        item.weight != null ? item.weight.toString() : '';
    brixController.value.text = item.brix != null ? item.brix.toString() : '';
    pressureController.value.text =
        item.pressure != null ? item.pressure.toString() : '';
    remarksController.value.text = item.remarks ?? '';
  }

  updateItem(ItemListModel item) async {
    List<AttachmentModel> attachments = [];
    for (var item in result.value.files) {
      if (item.path == "attachment.${item.extension}") {
        Uint8List bytes = item.bytes!;
        String base64String = base64Encode(bytes);
        attachments.add(AttachmentModel(
            file: base64String,
            extension: item.extension,
            path: "",
            isNew: false));
      } else {
        File file = File(item.path!);
        List<int> bytes = await file.readAsBytes();
        String base64String = base64Encode(bytes);
        attachments.add(AttachmentModel(
            file: item.path,
            extension: item.extension,
            path: item.path,
            isNew: true));
      }
    }
    int index = itemList.indexOf(item);
    itemList[index] = ItemListModel(
        itemId: item.itemId,
        commodit: commodit.value,
        variety: variety.value,
        brand: brand.value,
        waste: wasteController.value.text.isNotEmpty
            ? double.parse(wasteController.value.text)
            : 0.0,
        grade: gradeController.value.text,
        size: sizeController.value.text,
        count: countController.value.text.isNotEmpty
            ? int.parse(countController.value.text)
            : 0,
        lotNo: lotNoController.value.text,
        grower: growerController.value.text,
        stWeight: stWeightController.value.text.isNotEmpty
            ? double.parse(stWeightController.value.text)
            : 0.0,
        bruis: bruisController.value.text.isNotEmpty
            ? double.parse(bruisController.value.text)
            : 0.0,
        progress: progressController.value.text.isNotEmpty
            ? double.parse(progressController.value.text)
            : 0.0,
        cosmetic: cosmeticController.value.text.isNotEmpty
            ? double.parse(cosmeticController.value.text)
            : 0.0,
        weight: weightController.value.text.isNotEmpty
            ? double.parse(weightController.value.text)
            : 0.0,
        brix: brixController.value.text.isNotEmpty
            ? double.parse(brixController.value.text)
            : 0.0,
        pressure: pressureController.value.text.isNotEmpty
            ? double.parse(pressureController.value.text)
            : 0.0,
        remarks: remarksController.value.text,
        files: attachments);
    update();
    calculateTotalValues();
    if (isNewRecord.value == false) {
      //   await arrivalLocalController.removeOpenListItem(itemId: item.itemId);
      //   await arrivalLocalController.addOpenListItem(
      //       item: ArrivalReportOpenListDetailLocalModel(
      //           itemId: item.itemId,
      //           sysDocId: sysDoc.value.code,
      //           voucherId: voucherNumber.value,
      //           lotNumber: lotNoController.value.text,
      //           comodityId: commodit.value.code ?? '',
      //           varietyId: variety.value.code ?? '',
      //           brandId: brand.value.code ?? '',
      //           itemSize: sizeController.value.text,
      //           grade: gradeController.value.text,
      //           sampleCount: countController.value.text.isNotEmpty
      //               ? int.parse(countController.value.text)
      //               : 0,
      //           issue1Count: wasteController.value.text.isNotEmpty
      //               ? int.parse(wasteController.value.text)
      //               : 0,
      //           issue1CountDouble: wasteController.value.text.isNotEmpty
      //               ? double.parse(wasteController.value.text)
      //               : 0.0,
      //           issue2Count: progressController.value.text.isNotEmpty
      //               ? int.parse(progressController.value.text)
      //               : 0,
      //           issue2CountDouble: progressController.value.text.isNotEmpty
      //               ? double.parse(progressController.value.text)
      //               : 0.0,
      //           issue3Count: cosmeticController.value.text.isNotEmpty
      //               ? int.parse(cosmeticController.value.text)
      //               : 0,
      //           issue3CountDouble: cosmeticController.value.text.isNotEmpty
      //               ? double.parse(cosmeticController.value.text)
      //               : 0.0,
      //           issue4Count: bruisController.value.text.isNotEmpty
      //               ? int.parse(bruisController.value.text)
      //               : 0,
      //           issue4CountDouble: bruisController.value.text.isNotEmpty
      //               ? double.parse(bruisController.value.text)
      //               : 0.0,
      //           temperature: '',
      //           standardWeight: stWeightController.value.text.isNotEmpty
      //               ? double.parse(stWeightController.value.text)
      //               : 0.0,
      //           weight: weightController.value.text.isNotEmpty
      //               ? double.parse(weightController.value.text)
      //               : 0.0,
      //           pressure: pressureController.value.text.isNotEmpty
      //               ? double.parse(pressureController.value.text)
      //               : 0.0,
      //           brix: brixController.value.text.isNotEmpty
      //               ? double.parse(brixController.value.text)
      //               : 0.0,
      //           remarks: remarksController.value.text,
      //           grower: growerController.value.text,
      //           commodityName: commodit.value.name ?? '',
      //           varietyName: variety.value.name ?? '',
      //           brandName: brand.value.name ?? ''));
    }
    clearData();
  }

  deleteCommodity(int index) {
    itemList.removeAt(index);
    calculateTotalValues();
    update();
  }

  addItem() async {
    List<AttachmentModel> attachments = [];
    for (var item in result.value.files) {
      File file = File(item.path!);

      List<int> bytes = await file.readAsBytes();
      String base64String = base64Encode(bytes);
      attachments.add(AttachmentModel(
          file: base64String,
          extension: item.extension,
          path: item.path,
          isNew: true));
    }
    itemList.add(ItemListModel(
        itemId: voucherNumber.value +
            (commodit.value.code ?? '') +
            (variety.value.code ?? '') +
            (brand.value.code ?? ''),
        commodit: commodit.value,
        variety: variety.value,
        brand: brand.value,
        waste: wasteController.value.text.isNotEmpty
            ? double.parse(wasteController.value.text)
            : 0.0,
        grade: gradeController.value.text,
        size: sizeController.value.text,
        count: countController.value.text.isNotEmpty
            ? int.parse(countController.value.text)
            : 0,
        lotNo: lotNoController.value.text,
        grower: growerController.value.text,
        stWeight: stWeightController.value.text.isNotEmpty
            ? double.parse(stWeightController.value.text)
            : 0.0,
        bruis: bruisController.value.text.isNotEmpty
            ? double.parse(bruisController.value.text)
            : 0.0,
        progress: progressController.value.text.isNotEmpty
            ? double.parse(progressController.value.text)
            : 0.0,
        cosmetic: cosmeticController.value.text.isNotEmpty
            ? double.parse(cosmeticController.value.text)
            : 0.0,
        weight: weightController.value.text.isNotEmpty
            ? double.parse(weightController.value.text)
            : 0.0,
        brix: brixController.value.text.isNotEmpty
            ? double.parse(brixController.value.text)
            : 0.0,
        pressure: pressureController.value.text.isNotEmpty
            ? double.parse(pressureController.value.text)
            : 0.0,
        remarks: remarksController.value.text,
        files: attachments));
    update();
    calculateTotalValues();
    if (isNewRecord.value == false) {
      // arrivalLocalController.addOpenListItem(
      //     item: ArrivalReportOpenListDetailLocalModel(
      //         itemId: voucherNumber.value +
      //             (commodit.value.code ?? '') +
      //             (variety.value.code ?? '') +
      //             (brand.value.code ?? ''),
      //         sysDocId: sysDoc.value.code,
      //         voucherId: voucherNumber.value,
      //         lotNumber: lotNoController.value.text,
      //         comodityId: commodit.value.code ?? '',
      //         varietyId: variety.value.code ?? '',
      //         brandId: brand.value.code ?? '',
      //         itemSize: sizeController.value.text,
      //         grade: gradeController.value.text,
      //         sampleCount: countController.value.text.isNotEmpty
      //             ? int.parse(countController.value.text)
      //             : 0,
      //         issue1Count: wasteController.value.text.isNotEmpty
      //             ? 0
      //             : 0,
      //         issue1CountDouble: wasteController.value.text.isNotEmpty
      //             ? double.parse(wasteController.value.text)
      //             : 0.0,
      //         issue2Count: progressController.value.text.isNotEmpty
      //             ? 0
      //             : 0,
      //         issue2CountDouble: progressController.value.text.isNotEmpty
      //             ? double.parse(progressController.value.text)
      //             : 0.0,
      //         issue3Count: cosmeticController.value.text.isNotEmpty
      //             ? 0
      //             : 0,
      //         issue3CountDouble: cosmeticController.value.text.isNotEmpty
      //             ? double.parse(cosmeticController.value.text)
      //             : 0.0,
      //         issue4Count: bruisController.value.text.isNotEmpty
      //             ? 0
      //             : 0,
      //         issue4CountDouble: bruisController.value.text.isNotEmpty
      //             ? double.parse(bruisController.value.text)
      //             : 0.0,
      //         temperature: '',
      //         standardWeight: stWeightController.value.text.isNotEmpty
      //             ? double.parse(stWeightController.value.text)
      //             : 0.0,
      //         weight: weightController.value.text.isNotEmpty
      //             ? double.parse(weightController.value.text)
      //             : 0.0,
      //         pressure: pressureController.value.text.isNotEmpty
      //             ? double.parse(pressureController.value.text)
      //             : 0.0,
      //         brix: brixController.value.text.isNotEmpty
      //             ? double.parse(brixController.value.text)
      //             : 0.0,
      //         remarks: remarksController.value.text,
      //         grower: growerController.value.text,
      //         commodityName: commodit.value.name ?? '',
      //         varietyName: variety.value.name ?? '',
      //         brandName: brand.value.name ?? ''));
    }
    lastItem.value = itemList.last;
    clearData();
  }

  clearData() {
    commodit.value = CommonComboModel();
    variety.value = CommonComboModel();
    brand.value = CommonComboModel();
    commoditController.value.text = '';
    varietyController.value.text = '';
    brandController.value.text = '';
    wasteController.value.text = '';
    gradeController.value.text = '';
    sizeController.value.text = '';
    countController.value.text = '';
    lotNoController.value.text = '';
    growerController.value.text = '';
    stWeightController.value.text = '';
    bruisController.value.text = '';
    progressController.value.text = '';
    cosmeticController.value.text = '';
    weightController.value.text = '';
    brixController.value.text = '';
    pressureController.value.text = '';
    remarksController.value.text = '';
    update();
  }

  clearAllData() {
    isNewRecord.value = true;
    updateVoucher();
    weightLessController.value.clear();
    headerWasteController.value.clear();
    headerProgressiveController.value.clear();
    headerCosmeticController.value.clear();
    headerBruiseController.value.clear();
    vesselNameController.value.clear();
    containerTempController.value.clear();
    inspector.value = CommonComboModel();
    quantityController.value.clear();
    referenceController.value.clear();
    headerRemarkController.value.clear();
    palletCountController.value.clear();
    origin.value = CommonComboModel();
    vendor.value = CommonComboModel();
    task.value = TaskListModel();
    containerNumberController.value.clear();
    clearData();
    itemList.clear();
    update();
  }

  calculateTotalValues() {
    double totalWaste = itemList
        .map((product) => product.waste)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalProgress = itemList
        .map((product) => product.progress)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalCosmetic = itemList
        .map((product) => product.cosmetic)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalBruis = itemList
        .map((product) => product.bruis)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalCount = itemList
        .map((product) => product.count)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalStWeight = itemList
        .map((product) => product.stWeight)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalWeight = itemList
        .map((product) => product.weight)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));

    if (totalCount > 0) {
      headerWasteController.value.text =
          ((totalWaste / totalCount) * 100).toStringAsFixed(2);
    } else {
      headerWasteController.value.text = '0.00';
    }

    if (totalCount > 0) {
      headerProgressiveController.value.text =
          ((totalProgress / totalCount) * 100).toStringAsFixed(2);
    } else {
      headerProgressiveController.value.text = '0.00';
    }

    if (totalCount > 0) {
      headerCosmeticController.value.text =
          ((totalCosmetic / totalCount) * 100).toStringAsFixed(2);
    } else {
      headerCosmeticController.value.text = '0.00';
    }

    if (totalCount > 0) {
      headerBruiseController.value.text =
          ((totalBruis / totalCount) * 100).toStringAsFixed(2);
    } else {
      headerBruiseController.value.text = '0.00';
    }

    if (totalStWeight > 0) {
      double weightLoss =
          (((totalStWeight - totalWeight) / totalStWeight) * 100);
      if (weightLoss > 0) {
        weightLessController.value.text = "${weightLoss.toStringAsFixed(2)} %";
      } else {
        weightLessController.value.text = '0.00 %';
      }
    } else {
      weightLessController.value.text = '0.00 %';
    }

    update();
  }

  getTaskList() async {
    if (isTaskListLoading.value == true) {
      return;
    }
    isTaskListLoading.value = true;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback =
          await ApiManager.fetchDataQc(api: 'GetTaskList?token=${token}');
      if (feedback != null) {
        result = GetTaskListModel.fromJson(feedback);
        taskList.value = result.modelobject;
        taskFilterList.value = result.modelobject;
        isTaskListLoading.value = false;
      }
      isTaskListLoading.value = false;
    } finally {}
  }

  getArrivalReportOpenList() async {
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
      var feedback = await ApiManager.fetchDataQc(
          api:
              'GetArrivalReportList?token=${token}&fromDate=${fromDate}&toDate=${toDate}');
      if (feedback != null) {
        log(feedback.toString());
        arrivalOpenList.clear();
        result = GetArrivalReportListModel.fromJson(feedback);
        arrivalOpenList.value = result.modelobject;
        arrivalOpenList.value = arrivalOpenList.reversed.toList();
        isOpenListLoading.value = false;
        update();
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

  getArrivalReportById({
    required String sysDoc,
    required String voucher,
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
    GetArrivalReportByIdModel result;
    try {
      var feedback = await ApiManager.fetchDataQc(
          api:
              'GetArrivalReportByID?token=${token}&sysDocID=${sysDoc}&voucherID=${voucher}');
      if (feedback != null) {
        log(feedback.toString());
        result = GetArrivalReportByIdModel.fromJson(feedback);
        if (result.header != null && result.header!.isNotEmpty) {
          await getAttachmentList(
            sysDoc: result.header![0].sysDocId ?? "",
            voucher: result.header![0].voucherId ?? "",
          );

          isNewRecord.value = false;
          selectedSysDoc.value =
              await getSysdocById(result.header![0].sysDocId!);
          voucherNumber.value = result.header![0].voucherId ?? '';
          task.value = TaskListModel(
              taskCode: result.header![0].taskId,
              container: result.header![0].containerNumber);
          containerNumberController.value.text = task.value.container ?? "";
          vesselNameController.value.text = result.header![0].vesselName ?? '';
          vendor.value = CommonComboModel(
              code: result.header![0].vendorId,
              name: result.header![0].vendorName);
          origin.value = CommonComboModel(code: result.header![0].originId);
          inspector.value =
              CommonComboModel(code: result.header![0].inspectorId);
          referenceController.value.text = result.header![0].reference ?? '';
          containerTempController.value.text =
              result.header![0].containerTemp.toString();
          palletCountController.value.text =
              result.header![0].totalPallets.toString();
          quantityController.value.text =
              result.header![0].totalQuantity.toString();
          headerRemarkController.value.text =
              result.header![0].description.toString();
          recieveDate.value = result.header![0].dateReceived!;
          inspectionDate.value = result.header![0].dateInspected!;
          packingCondition.value = result.header![0].packingCondition == 1
              ? PackingCondition.Good
              : PackingCondition.Weak;
          conclusion.value = result.header![0].conclusion == 1
              ? Conclusion.NoClaim
              : Conclusion.Claimable;
          headerWasteController.value.text =
              result.header![0].totalIssue1.toString();
          headerProgressiveController.value.text =
              result.header![0].totalIssue2.toString();
          headerCosmeticController.value.text =
              result.header![0].totalIssue3.toString();
          headerBruiseController.value.text =
              result.header![0].totalIssue4.toString();
          if (result.header![0].totalWeightLess != null &&
              result.header![0].totalWeightLess > 0) {
            weightLessController.value.text =
                "${result.header![0].totalWeightLess} %";
          } else {
            weightLessController.value.text = '0.00 %';
          }

          itemList.clear();
          this.result.value.files.clear();
          for (var item in result.detail!) {
            List<AttachmentModel> attchments = [];
            if (attchmentList.isNotEmpty) {
              for (var items in attchmentList) {
                if (items.fileData == null) {
                } else {
                  if ("${item.rowIndex}" ==
                      items.entityDocName!.split('_')[1]) {
                    attchments.add(AttachmentModel(
                        extension: items.entityDocName!.split('.')[1],
                        file: items.fileData,
                        isNew: false));
                  }
                }
              }
            }
            itemList.add(
              ItemListModel(
                  itemId: voucherNumber.value +
                      (item.comodityId ?? '') +
                      (item.varietyId ?? '') +
                      (item.brandId ?? ''),
                  commodit: CommonComboModel(
                      code: item.comodityId, name: item.commodityName),
                  variety: CommonComboModel(
                      code: item.varietyId, name: item.varietyName),
                  brand: CommonComboModel(
                      code: item.brandId, name: item.brandName),
                  waste: item.issue1Count,
                  grade: item.grade,
                  size: item.itemSize,
                  count: item.sampleCount,
                  lotNo: item.lotNumber,
                  grower: item.grower,
                  stWeight: item.standardWeight?.toDouble() ?? 0.0,
                  bruis: item.issue4Count,
                  progress: item.issue2Count,
                  cosmetic: item.issue3Count,
                  weight: item.weight,
                  brix: item.brix,
                  pressure: item.pressure,
                  remarks: item.remarks,
                  files: attchments),
            );
            update();
          }
        }
        isOpenListLoading.value = false;
      }
    } finally {
      isOpenListLoading.value = false;
    }
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

  searchTaskList(String value) {
    taskFilterList.value = taskList
        .where((element) =>
            (element.taskCode!).toLowerCase().contains(value.toLowerCase()) ||
            (element.vendor!).toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  var itemList = <ItemListModel>[].obs;

  selectFile() async {
    if (result.value.files.isEmpty) {
      result.value = (await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: true))!;
    } else {
      FilePickerResult data = (await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: true))!;
      for (var file in data.files) {
        if (!result.value.files.contains(file)) {
          result.value.files.add(file);
          update();
        }
      }
    }
    update();
  }

  getAttachmentList({
    required String sysDoc,
    required String voucher,
  }) async {
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    dynamic result;
    try {
      var feedback = await ApiManager.fetchDataCommon(
          api:
              'GetAttachment?token=${token}&entityType=${EntityType.Transactions.value}&EntitySysDocID=${sysDoc}&EntityID=${voucher}');
      if (feedback != null) {
        result = GetAttachmentListModel.fromJson(feedback);
        attchmentList.value = result.modelobject;
      }
    } finally {}
    update();
  }

  clearCommodity() {
    clearData();
    result.value.files.clear();
    update();
  }

  takePicture() async {
    final XFile? cameraImages = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (cameraImages != null) {
      result.value.files.add(PlatformFile(
          path: cameraImages.path, name: cameraImages.name, size: 0));
      result.refresh();
    }
    update();
  }

  removeFile(int index) {
    result.value.files.removeAt(index);
    update();
  }

  var recieveDate = DateTime.now().obs;
  var inspectionDate = DateTime.now().obs;
  selectRecieveDate(context) async {
    DateTime? newDate =
        await CommonWidgets.getCalender(context, recieveDate.value);
    if (newDate != null) {
      recieveDate.value = newDate;
    }
    update();
  }

  selectInspectionDate(context) async {
    DateTime? newDate =
        await CommonWidgets.getCalender(context, inspectionDate.value);
    if (newDate != null) {
      inspectionDate.value = newDate;
    }
    update();
  }

  fetchDefaults() async {
    await sysDocListController.getSysDocListByType(
        sysDocType: SysdocType.ArrivalReport.value);
    sysDocList.value = sysDocListController.sysDocList;
    selectedSysDoc.value = sysDocList[0];
    voucherNumber.value =
        await homeController.getVoucherNumber(selectedSysDoc.value.code!);
  }

  updateVoucher() async {
    voucherNumber.value =
        await homeController.getVoucherNumber(selectedSysDoc.value.code!);
  }

  // updateVoucher() async {
  //   voucherNumber.value =
  //       await homeController.getVoucherNumber(sysDoc.value.code!);
  // }

  selectSyDoc(int index) {
    selectedSysDoc.value = sysDocList[index];
    voucherNumber.value =
        homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
    update();
  }

  addAttachment(String voucherId) async {
    log("${itemList.length}  AddAttachmentItemList");
    final String token = loginController.token.value;
    int rowIndex = 0;
    for (var item in itemList) {
      int imageIndex = 1;
      for (var file in item.files ?? []) {
        log("${item.files!.length}  AddAttachmentItemFilesList");
        if (file.isNew == true) {
          String base64Image = "";
          if (file.path == "" || file.path == null) {
            base64Image = file.file;
          } else {
            final File lengthFile = File(file.path);
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
              file.path,
              quality: quality,
            );
            List<int> imageBytes = result as List<int>;
            base64Image = base64Encode(imageBytes);
          }

          String data = jsonEncode({
            "token": "$token",
            "EntityID": voucherId,
            "EntityType": EntityType.Transactions.value,
            "EntitySysDocID": selectedSysDoc.value.code ?? '',
            "EntityDocName":
                "Image00${imageIndex}_${rowIndex}_${imageIndex}.${file.extension}",
            "EntityDocDesc": "",
            "EntityDocKeyword":
                "${UserSimplePreferences.getUsername()}${DateTime.now()}",
            "EntityDocPath": "",
            "RowIndex": rowIndex,
            "FileData": "${base64Image}"
          });
          log("${data}  AddAttachment");
          try {
            var feedback = await ApiManager.fetchCommonDataRawBody(
                api: 'AddAttachment', data: data);

            if (feedback != null) {
              // log("${feedback}", name: "add attachment log");
              if (feedback["res"] == 0) {
              } else {}
            }
          } finally {}
          imageIndex++;
        }
      }
      rowIndex++;
    }
  }

  createArrivalReport() async {
    if (isLoading.value == true) {
      return;
    }

    isLoading.value = true;
    int rowIndex = 0;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    List<CreateArrivalReportDetailsModel> list = [];
    for (var item in itemList) {
      list.add(CreateArrivalReportDetailsModel(
        rowIndex: rowIndex,
        lotNumber: item.lotNo ?? '',
        comodityId: item.commodit!.code ?? '',
        varietyId: item.variety!.code ?? '',
        brandId: item.brand!.code ?? '',
        grower: item.grower ?? '',
        itemSize: item.size ?? '',
        grade: item.grade ?? '',
        sampleCount: item.count ?? 0.0,
        issue1Count: item.waste ?? 0.0,
        issue2Count: item.progress ?? 0.0,
        issue3Count: item.cosmetic ?? 0.0,
        issue4Count: item.bruis ?? 0.0,
        standardWeight: item.stWeight ?? 0.0,
        weight: item.weight ?? 0.0,
        pressure: item.pressure ?? 0.0,
        brix: item.brix ?? 0.0,
        remarks: item.remarks,
      ));
      rowIndex++;
    }

    double containerTemp = containerTempController.value.text.isNotEmpty
        ? double.parse(containerTempController.value.text)
        : 0.0;
    int totalPallets = palletCountController.value.text.isNotEmpty
        ? int.parse(palletCountController.value.text)
        : 0;
    double totalQuantity = quantityController.value.text.isNotEmpty
        ? double.parse(quantityController.value.text)
        : 0.0;

    double totalWaste = itemList
        .map((product) => product.waste)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalProgress = itemList
        .map((product) => product.progress)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalCosmetic = itemList
        .map((product) => product.cosmetic)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));
    double totalBruis = itemList
        .map((product) => product.bruis)
        .fold(0, (previousValue, element) => previousValue + (element ?? 0.0));

    final data = json.encode({
      "token": token,
      "IsNewRecord": isNewRecord.value,
      "SysDocID": selectedSysDoc.value.code ?? '',
      "VoucherID": voucherNumber.value,
      "VendorID": vendor.value.code ?? '',
      "OriginID": origin.value.code ?? '',
      "ContainerNumber": containerNumberController.value.text,
      "VesselName": vesselNameController.value.text,
      "Comodities": "",
      "SourceSysDocID": "",
      "SourceVoucherID": "",
      "InspectorID": inspector.value.code ?? '',
      "Reference": referenceController.value.text,
      "Reference2": "",
      "ContainerTemp": containerTemp,
      "TotalPallets": totalPallets,
      "TotalQuantity": totalQuantity,
      "TemplateID": "FRESH",
      "LocationID": "",
      "Note": "",
      "IsConsignment": true,
      "TaskID": task.value.taskCode ?? '',
      "DateReceived": recieveDate.value.toIso8601String(),
      "DateInspected": inspectionDate.value.toIso8601String(),
      "Description": "",
      "PackingCondition": packingCondition.value.value,
      "IsPalletized": 0,
      "ResultNote": "",
      "Status": 0,
      "SourceDocType": 0,
      "Conclusion": conclusion.value.value,
      "Issue1Name": 'Waste',
      "Issue2Name": 'Progressive',
      "Issue3Name": 'Cosmetic',
      "Issue4Name": 'Bruise',
      "TotalIssue1": double.parse(headerWasteController.value.text),
      "TotalIssue2": double.parse(headerProgressiveController.value.text),
      "TotalIssue3": double.parse(headerCosmeticController.value.text),
      "TotalIssue4": double.parse(headerBruiseController.value.text),
      "TotalWeightLess": weightLessController.value.text.isNotEmpty
          ? double.parse(weightLessController.value.text.split(' ').first)
          : 0.0,
      "Remark": headerRemarkController.value.text,
      "Details": list
    });

    try {
      // log(data.toString());
      var feedback = await ApiManager.fetchDataRawBodyQc(
          api: 'CreateArrivalReport', data: data);
      if (feedback != null) {
        if (feedback['res'] == 1) {
          isNewRecord.value = false;
          await addAttachment(feedback['docNo']);
          SnackbarServices.successSnackbar(
              'Arrival Report Ceated and Saved in ${feedback['docNo']}');
          log(selectedSysDoc.value.numberPrefix.toString());
          String docNumber = selectedSysDoc.value.numberPrefix != null &&
                  selectedSysDoc.value.numberPrefix != ''
              ? feedback['docNo']
                  .toString()
                  .split(selectedSysDoc.value.numberPrefix ?? '')
                  .toList()[1]
              : feedback['docNo'];

          voucherNumber.value =
              homeController.getNextVoucher(sysDoc: selectedSysDoc.value);
          clearAllData();
          lastItem.value = ItemListModel(itemId: "");
        } else {
          SnackbarServices.errorSnackbar(feedback['msg'] ?? feedback['err']);
        }
        isLoading.value = false;
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  previewReciept({
    required String sysDoc,
    required String voucher,
    required int index,
  }) async {
    isPrintLoading.value = true;
    printingIndex.value = index;
    await loginController.getToken();
    if (loginController.token.value.isEmpty) {
      await loginController.getToken();
    }
    final String token = loginController.token.value;
    var data = jsonEncode({
      "FileName": SysdocType.ArrivalReport.name,
      "SysDocType": SysdocType.ArrivalReport.value,
      "FileType": 1
    });
    var result;
    try {
      var feedback = await ApiManager.fetchDataRawBodyReport(
          api:
              'GetApprovalPreview?token=${token}&SysDocID=${sysDoc}&VoucherID=${voucher}',
          data: data);

      log(
          data.toString() +
              'GetApprovalPreview?token=${token}&SysDocID=${sysDoc}&VoucherID=${voucher}',
          name: 'Preview pdf');

      if (feedback != null) {
        if (feedback['Modelobject'] != null &&
            feedback['Modelobject'].isNotEmpty) {
          Uint8List bytes = base64.decode(feedback['Modelobject']);
          List<int> pdfBytes = base64Decode(feedback['Modelobject']);
          await print.Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async {
            return pdfBytes as Uint8List;
          });
        } else {
          SnackbarServices.errorSnackbar(
              'Can\'t print Recipt due to ${feedback['msg'] ?? feedback['err']}');
        }
      } else {
        SnackbarServices.errorSnackbar('Can\'t print Recipt at the moment');
      }
    } catch (e) {
      log('Reciept Generation Failed $e');
    } finally {
      isPrintLoading.value = false;
    }
  }

  bool isValidNumber(String input) {
    double? number = double.tryParse(input);
    return number != null;
  }
}
