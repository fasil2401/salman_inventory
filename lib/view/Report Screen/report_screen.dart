import 'package:axolon_inventory_manager/controller/App%20Controls/report_controller.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final reportController = Get.put(ReportController());
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.mutedColor,
                      ),
                      iconSize: 20,
                    ),
                    buttonStyleData: ButtonStyleData(
                        width: 90,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(
                          //       color: AppColors.mutedColor, width: 0.3),
                        )),
                    items: reportController.statusItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedValue = value.toString();
                      reportController.filterReportListStatus(value.toString());
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    reportController.selectDate(context);
                  },
                  icon: Icon(Icons.calendar_month_outlined,
                      color: Theme.of(context).primaryColor, size: 20),
                  label: Obx(() => _buildDeatailText(
                        "${reportController.filterDateView.value}",
                      )),
                ),
              ],
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            Expanded(
              child: Obx(() => ListView.separated(
                    itemCount: reportController.filterReportList.length,
                    itemBuilder: (context, index) {
                      var report = reportController.filterReportList[index];
                      return InkWell(
                        onTap: () {
                          if (report.isSynced == 0) {
                            SnackbarServices.errorSnackbar(report.error);
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          elevation: 3,
                          color: report.isSynced == 1
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${report.sysDocId} - ${report.voucherId}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        color: report.isSynced == 1
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    _buildDeatailText(
                                        'Location From :${report.locationFromId}'),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    _buildDeatailText(
                                        'Location To :${report.locationToId}'),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    _buildDeatailText(
                                        'Total Quantity : ${report.quantity ?? ""}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildDeatailText(
                                      DateFormatter.dateFormat.format(
                                        DateTime.parse(
                                          report.transactionDate,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    report.isSynced == 1
                                        ? Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              AppIcons.check,
                                              width: 20,
                                              height: 20,
                                              color: AppColors.success,
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: IconButton(
                                              onPressed: () {
                                                reportController.deleteReport(
                                                    report.voucherId, index);
                                              },
                                              padding: EdgeInsets.zero,
                                              splashColor: Colors.red,
                                              splashRadius: 20,
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 2,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildDeatailText(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }
}
