import 'dart:developer';

import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/out_transfer_local_controller.dart';
import 'package:axolon_inventory_manager/model/create_transfer_out_model.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  @override
  void onInit() {
    generateReportList();
    super.onInit();
  }

  final outTransferLocalController =
      Get.put(CreateOutTransferLocalController());
  var statusItems = [
    'All',
    'Synced',
    'Pending',
    'Failed',
  ].obs;
  var date = DateTime.now().obs;
  var filterDate = ''.obs;
  var filterDateView = 'Pick Date'.obs;
  var filterReportList = [].obs;
  var reportList = [].obs;
  selectDate(context) async {
    DateTime? newDate = await CommonWidgets.getCalender(context, date.value);
    if (newDate != null) {
      filterDateView.value =
          DateFormatter.dateFormat.format(newDate).toString();
      filterDate.value = newDate.toIso8601String();
      filterReportListDate();
    }
    update();
  }

  filterReportListDate() {
    // filterReportList.clear();
    filterReportList.value = reportList.where((element) {
      DateTime transactionDate = DateTime.parse(element.transactionDate);
      DateTime filterDates = DateTime.parse(filterDate.value);
      return DateTime(
            transactionDate.year,
            transactionDate.month,
            transactionDate.day,
          ) ==
          DateTime(filterDates.year, filterDates.month, filterDates.day);
    }).toList();
    update();
  }

  filterReportListStatus(String status) async {
    
    // filterReportList.clear();
    // if (outTransferLocalController.outTransferHeaders.isEmpty) {
    //   await outTransferLocalController.getOutTransferHeaders();
    // }

    switch (status) {
      case 'All':
        {
          resetFilter();
          //  generateReportList();
          update();
        }
        break;
      case "Synced":
        {
          reportList.value = outTransferLocalController.outTransferHeaders
              .where((element) => element.isSynced == 1)
              .toList();

          filterReportList.value = reportList;
          update();
        }
        break;

      case "Pending":
        {
          reportList.value = outTransferLocalController.outTransferHeaders
              .where((element) =>
                  element.isSynced == 0 && element.error == 'Syncing Pending')
              .toList();
          filterReportList.value = reportList;
          update();
        }
        break;

      case "Failed":
        {
         
          for (var item in outTransferLocalController.outTransferHeaders) {
           
          }
          reportList.value = outTransferLocalController.outTransferHeaders
              .where((element) =>
                  element.isSynced == 0 && element.error != 'Syncing Pending')
              .toList();
          filterReportList.value = reportList;
          update();
        }
        break;
    }
  }

  generateReportList() async {
    reportList.clear();
    filterReportList.clear();
    await outTransferLocalController.getOutTransferHeaders();

    reportList.value = outTransferLocalController.outTransferHeaders;
    filterReportList.value = reportList;
    update();
  }

  resetFilter() async {
    filterDateView.value = 'Pick Date';
    filterDate.value = '';
    generateReportList();
    update();
  }

  deleteReport(String voucherId, int index) async {
    reportList.removeAt(index);
    filterReportList.value = reportList;
    await outTransferLocalController.deleteOutTransferHeader(
        vouchetId: voucherId);

    update();
  }
}
