import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/quality_controller.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/attachment_model.dart';
import 'package:axolon_inventory_manager/model/Quality%20Control%20Model/item_list_model.dart';
import 'package:axolon_inventory_manager/model/common_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/services/extensions.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class QualityControlScreen extends StatelessWidget {
  QualityControlScreen({super.key});
  final qualityController = Get.put(QualityControlController());
  final homeController = Get.put(HomeController());
  var selectedSysdocValue;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Arrival Report'),
        actions: [
          IconButton(
            onPressed: () {
              // qualityController.getArrivalReportOpenList();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: const EdgeInsets.all(10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: _buildOpenListHeader(context),
                    content: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: _buildOpenListPopContent(context),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: Obx(
              () => qualityController.isOpenListLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : SvgPicture.asset(
                      AppIcons.openList,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(
                        context,
                        suffixicon: true,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        ontap: () {
                          CommonWidgets.commonDialog(
                              context,
                              'System Doccuments',
                              ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    SysDocModel item =
                                        qualityController.sysDocList[index];
                                    return CommonWidgets.commonListTile(
                                        context: context,
                                        code: item.code ?? '',
                                        name: item.name ?? '',
                                        onPressed: () {
                                          qualityController.selectSyDoc(index);
                                          Navigator.pop(context);
                                        });
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 8,
                                      ),
                                  itemCount:
                                      qualityController.sysDocList.length));
                        },
                        controller: TextEditingController(
                            text:
                                '${qualityController.selectedSysDoc.value.code} - ${qualityController.selectedSysDoc.value.name}'),
                        label: 'SysDocId',
                        onchanged: (value) {},
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Voucher : ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary),
                ),
                Obx(() => Text(
                      qualityController.voucherNumber.value,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary),
                    ))
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: TextEditingController(
                          text:
                              '${qualityController.task.value.taskCode ?? ''}'),
                      suffixicon: false,
                      label: 'Task',
                      readonly: true,
                      keyboardtype: TextInputType.name)),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        if (qualityController.taskList.isEmpty) {
                          qualityController.getTaskList();
                        }
                        CommonWidgets.commonDialog(
                          context,
                          "",
                          SizedBox(
                            height: height,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CommonWidgets.textField(context,
                                      controller: TextEditingController(),
                                      suffixicon: false,
                                      label: 'Search Task',
                                      readonly: false,
                                      keyboardtype: TextInputType.text,
                                      onchanged: (value) {
                                    // if (value.isEmpty) {
                                    //   qualityController.taskFilterList.value =
                                    //       qualityController.taskList;
                                    // }
                                    qualityController.searchTaskList(value);
                                  }),
                                  _buildTaskListPopContet(context)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.more_vert_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: TextEditingController(
                          text:
                              '${qualityController.task.value.grnDocId ?? ''}'),
                      suffixicon: false,
                      label: 'GRN',
                      readonly: true,
                      keyboardtype: TextInputType.text)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: TextEditingController(
                          text:
                              '${qualityController.task.value.grnNumber ?? ''}'),
                      suffixicon: false,
                      label: '',
                      readonly: true,
                      keyboardtype: TextInputType.text)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: Obx(() => CommonWidgets.textField(
                        context,
                        suffixicon: true,
                        controller: TextEditingController(
                            text: qualityController.vendor.value.code),
                        icon: Icons.arrow_drop_down_circle_outlined,
                        label: 'Vendor ID',
                        readonly: true,
                        ontap: () async {
                          qualityController.vendor.value =
                              await homeController.selectComboOption(
                                  context: context,
                                  heading: 'Vendor',
                                  list: homeController.vendorList,
                                  combo: ComboOptions.Vendor);
                        },
                        keyboardtype: TextInputType.name,
                      )),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(
                        context,
                        controller: TextEditingController(
                            text:
                                '${qualityController.vendor.value.name ?? ''}'),
                        suffixicon: false,
                        label: '',
                        readonly: true,
                        keyboardtype: TextInputType.name,
                      )),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.vesselNameController.value,
                      suffixicon: false,
                      label: 'Vessel Name',
                      readonly: false,
                      keyboardtype: TextInputType.text)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      suffixicon: false,
                      controller:
                          qualityController.containerNumberController.value,
                      label: 'Container No',
                      readonly: false,
                      keyboardtype: TextInputType.name)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                          controller: TextEditingController(
                            text: DateFormatter.dateFormat
                                .format(qualityController.recieveDate.value)
                                .toString(),
                          ),
                          suffixicon: true,
                          icon: Icons.calendar_month,
                          label: 'Receive Date',
                          readonly: true, ontap: () {
                        qualityController.selectRecieveDate(context);
                      }, keyboardtype: TextInputType.name)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                          controller: TextEditingController(
                            text: DateFormatter.dateFormat
                                .format(qualityController.inspectionDate.value)
                                .toString(),
                          ),
                          suffixicon: true,
                          icon: Icons.calendar_month,
                          label: 'Inspection Date',
                          readonly: true, ontap: () {
                        qualityController.selectInspectionDate(context);
                      }, keyboardtype: TextInputType.name)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Obx(() => CommonWidgets.textField(
                          context,
                          suffixicon: false,
                          label: 'Container Temp',
                          isTextNotAllowed: true,
                          readonly: false,
                          controller:
                              qualityController.containerTempController.value,
                          keyboardtype: TextInputType.text,
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                          controller: TextEditingController(
                              text:
                                  '${qualityController.origin.value.code ?? ''} - ${qualityController.origin.value.name ?? ''}'),
                          suffixicon: true,
                          icon: Icons.arrow_drop_down_circle_outlined,
                          label: 'Origin',
                          readonly: true, ontap: () async {
                        qualityController.origin.value =
                            await homeController.selectComboOption(
                                context: context,
                                heading: 'Origin',
                                list: homeController.originList,
                                combo: ComboOptions.Origin);
                      }, keyboardtype: TextInputType.name)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.palletCountController.value,
                      suffixicon: false,
                      label: 'Pallets Count',
                      readonly: false,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: false))),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.quantityController.value,
                      suffixicon: false,
                      label: 'Quantity',
                      readonly: false,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: true))),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => CommonWidgets.textField(
                        context,
                        controller: TextEditingController(
                            text:
                                '${qualityController.inspector.value.code ?? ''} - ${qualityController.inspector.value.name ?? ''}'),
                        suffixicon: true,
                        icon: Icons.arrow_drop_down_circle_outlined,
                        label: 'Inspector',
                        readonly: true,
                        ontap: () async {
                          qualityController.inspector.value =
                              await homeController.selectComboOption(
                                  context: context,
                                  heading: 'Inspector',
                                  list: homeController.inspectorList,
                                  combo: ComboOptions.Inspector);
                        },
                        keyboardtype: TextInputType.name,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.referenceController.value,
                      suffixicon: false,
                      maxLength: 20,
                      icon: Icons.arrow_drop_down_circle_outlined,
                      label: 'Reference',
                      readonly: false,
                      keyboardtype: TextInputType.text)),
                ),
              ],
            ),
            _buildSpacer(),
            Obx(() => CommonWidgets.textField(context,
                controller: qualityController.headerRemarkController.value,
                suffixicon: false,
                maxLines: 5,
                label: 'Remarks',
                readonly: false,
                keyboardtype: TextInputType.text)),
            Align(
              alignment: Alignment.bottomRight,
              child: CommonWidgets.elevatedButton(context, onTap: () {
                FocusScope.of(context).unfocus();
                addOrUpdateItem(context, isUpdating: false);
              }, type: ButtonTypes.Primary, text: 'Add'),
            ),
            _buildLineSpacer(),
            GetBuilder<QualityControlController>(builder: (controller) {
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.itemList.length,
                itemBuilder: (context, index) {
                  var item = controller.itemList[index];
                  return InkWell(
                    onTap: () {
                      controller.result.value.files.clear();
                      if (item.files != null && item.files!.isNotEmpty) {
                        for (int index = 0;
                            index < item.files!.length;
                            index++) {
                          String base64Data = item.files![index].file ?? '';
                          String filePath = item.files![index].path ?? "";
                          log("${base64Data.isNotEmpty}");
                          if (base64Data.isNotEmpty) {
                            try {
                              if (filePath == "") {
                                Uint8List bytes =
                                    const Base64Codec().decode(base64Data);
                                log("${item.files![index].extension}");
                                controller.result.value.files.add(PlatformFile(
                                  name: filePath == ""
                                      ? "attachment.${item.files![index].extension}"
                                      : filePath,
                                  size: bytes.length,
                                  bytes: bytes,
                                  path: filePath == ""
                                      ? "attachment.${item.files![index].extension}"
                                      : filePath,
                                ));
                              } else {
                                File file = File(filePath);
                                List<int> bytes = file.readAsBytesSync();
                                Uint8List uint8List = Uint8List.fromList(bytes);
                                log("${item.files![index].extension}");
                                controller.result.value.files.add(PlatformFile(
                                  name: filePath,
                                  size: item.files![index].file!.length,
                                  bytes: uint8List,
                                  path: filePath,
                                ));
                              }
                            } catch (e) {
                              print(
                                  'Error decoding Base64 data for file $filePath: $e');
                            }
                          } else {
                            print('Base64 data is empty for file $filePath');
                          }
                        }
                      }
                      log("${item.files!.length}");
                      addOrUpdateItem(context, isUpdating: true, item: item);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    '${item.commodit?.name ?? ''} - ${item.brand?.name ?? ''}',
                                    minFontSize: 16,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _buildItemImagePopup(
                                        context, item.files ?? []);
                                  },
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        child: Icon(
                                          Icons.photo_library_outlined,
                                          size: 18,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: CircleAvatar(
                                          child: AutoSizeText(
                                            item.files!.length.toString(),
                                            minFontSize: 8,
                                            maxFontSize: 12,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          radius: 8,
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                          'Delete',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        content: const Text(
                                          'Do you want to delete the Commodity ?',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                            ),
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    color: mutedColor)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteCommodity(index);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Sure',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLineSpacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Size :',
                                          content: '${item.size ?? ''}'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Count : ',
                                          content: '${item.count ?? ''}'),
                                    )
                                  ],
                                ),
                                _buildLineSpacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Waste :',
                                          content: '${item.waste ?? ''}'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Grade : ',
                                          content: '${item.grade ?? ''}'),
                                    )
                                  ],
                                ),
                                _buildLineSpacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Lot No :',
                                          content: '${item.lotNo ?? ''}'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: _buildCardDetails(size,
                                          title: 'Variety : ',
                                          content:
                                              '${item.variety?.name ?? ''}'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => _buildLineSpacer(),
              );
            }),
            _buildLineSpacer(),
            GetBuilder<QualityControlController>(
              builder: (controller) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildTotalDetails(
                                  title: 'Count',
                                  value: controller.itemList
                                      .map((product) => product.count)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element ?? 0.0))),
                              _buildTotalDetails(
                                  title: 'Bruis',
                                  value: controller.itemList
                                      .map((product) => product.bruis)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element ?? 0.0))),
                              _buildTotalDetails(
                                  title: 'Cosmetic',
                                  value: controller.itemList
                                      .map((product) => product.cosmetic)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element ?? 0.0))),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              _buildTotalDetails(
                                  title: 'Waste',
                                  value: controller.itemList
                                      .map((product) => product.waste)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element ?? 0.0))),
                              _buildTotalDetails(
                                  title: 'Progress',
                                  value: controller.itemList
                                      .map((product) => product.progress)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element ?? 0.0))),
                              _buildTotalDetails(
                                  title: 'Weight',
                                  value: controller.itemList
                                      .map((product) => product.weight)
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + (element ?? 0.0)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonWidgets.textField(context,
                      controller: qualityController.headerWasteController.value,
                      suffixicon: false,
                      label: 'Waste',
                      readonly: true,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: false)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonWidgets.textField(context,
                      controller: qualityController.weightLessController.value,
                      suffixicon: false,
                      label: 'Weight Lost %',
                      readonly: true,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: true)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonWidgets.textField(context,
                      controller:
                          qualityController.headerProgressiveController.value,
                      suffixicon: false,
                      label: 'Progressive',
                      readonly: true,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: false)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonWidgets.textField(context,
                      controller:
                          qualityController.headerCosmeticController.value,
                      suffixicon: false,
                      label: 'Cosmetic',
                      readonly: true,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: false)),
                ),
              ],
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonWidgets.textField(context,
                      controller:
                          qualityController.headerBruiseController.value,
                      suffixicon: false,
                      label: 'Bruis',
                      readonly: true,
                      keyboardtype:
                          TextInputType.numberWithOptions(decimal: false)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CommonWidgets.dropDown(
                  context,
                  selectedValue: PackingCondition.values.toList()[0],
                  title: 'Packing Condition',
                  values: PackingCondition.values.toList(),
                  onChanged: (value) {
                    qualityController.packingCondition.value = value;
                  },
                )
                    // CommonWidgets.textField(context,
                    //     suffixicon: true,
                    //     icon: Icons.arrow_drop_down_circle_outlined,
                    //     label: 'Packing Condition',
                    //     readonly: true,
                    //     keyboardtype: TextInputType.name),
                    ),
              ],
            ),
            _buildSpacer(),
            CommonWidgets.dropDown(
              context,
              selectedValue: Conclusion.values.toList()[0],
              title: 'Conclusion',
              values: Conclusion.values.toList(),
              onChanged: (value) {
                qualityController.conclusion.value = value;
              },
            ),
            _buildSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonWidgets.elevatedButton(context, onTap: () {
                    qualityController.clearAllData();
                  }, type: ButtonTypes.Secondary, text: 'Clear'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => CommonWidgets.elevatedButton(context,
                          isLoading: qualityController.isLoading.value,
                          onTap: () {
                        // qualityController.addAttachment('voucherId');
                        FocusScope.of(context).unfocus();

                        if (qualityController.vendor.value.code != null) {
                          if (qualityController.itemList.isNotEmpty &&
                              qualityController.vendor.value.code!.isNotEmpty) {
                            if (qualityController.containerTempController.value
                                .text.isNotEmpty) {
                              bool isTempValid = qualityController
                                  .isValidNumber(qualityController
                                      .containerTempController.value.text);
                              if (isTempValid == false) {
                                SnackbarServices.errorSnackbar(
                                    'Please Enter A Valid Container Temperature');
                                return;
                              } else {
                                qualityController.createArrivalReport();
                              }
                            } else {
                              qualityController.createArrivalReport();
                            }
                          } else {
                            SnackbarServices.errorSnackbar(
                                'Please add Commodities');
                            return;
                          }
                        } else {
                          SnackbarServices.errorSnackbar(
                              'Please Select Vendor');
                          return;
                        }

                        // if (qualityController.vendor.value.code == null) {
                        //   SnackbarServices.errorSnackbar('Please Select Vendor');
                        //   return;
                        // }
                        // if (qualityController.itemList.isEmpty &&
                        //     qualityController.vendor.value.code!.isEmpty) {
                        //   SnackbarServices.errorSnackbar('Please add Commodities');
                        //   return;
                        // }
                        // if (qualityController
                        //     .containerTempController.value.text.isNotEmpty) {
                        //   bool isTempValid = qualityController.isValidNumber(
                        //       qualityController.containerTempController.value.text);
                        //   if (isTempValid == false) {
                        //     SnackbarServices.errorSnackbar(
                        //         'Please Enter A Valid Container Temperature');
                        //     return;
                        //   }
                        // }

                        qualityController.createArrivalReport();
                      }, type: ButtonTypes.Primary, text: 'Save')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox _buildOpenListPopContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => qualityController.isOpenListLoading.value
                    ? CommonWidgets.popShimmer()
                    : qualityController.arrivalOpenList.isEmpty
                        ? Center(
                            child: Text('No Data Found'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: qualityController.arrivalOpenList.length,
                            itemBuilder: (context, index) {
                              var item =
                                  qualityController.arrivalOpenList[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: InkWell(
                                  splashColor: mutedColor.withOpacity(0.2),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await qualityController
                                        .getArrivalReportById(
                                            sysDoc: item.docId ?? '',
                                            voucher: item.docNumber ?? '');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            qualityController.previewReciept(
                                                sysDoc: item.docId ?? '',
                                                voucher: item.docNumber ?? '',
                                                index: index);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                '${item.docId} - ${item.docNumber}',
                                                minFontSize: 12,
                                                maxFontSize: 18,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: Center(
                                                  child: Obx(() => qualityController
                                                              .isPrintLoading
                                                              .value &&
                                                          qualityController
                                                                  .printingIndex
                                                                  .value ==
                                                              index
                                                      ? SizedBox(
                                                          width: 15,
                                                          height: 15,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2,
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons.print_outlined,
                                                          size: 15,
                                                          color: Colors.white,
                                                        )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildTileRow(
                                            title: "Vendor",
                                            content:
                                                "${item.vendorCode ?? ""} - ${item.vendorName ?? ""}"),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Container #",
                                            content: item.containerNo ?? ""),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Received Date",
                                            content: item.receivedDate != null
                                                ? DateFormatter.dateFormat
                                                    .format(item.receivedDate!)
                                                : ''),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Reference",
                                            content: item.reference ?? ""),
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
    );
  }

  Column _buildOpenListHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => CommonWidgets.commonDateFilter(
                context,
                qualityController.dateIndex.value,
                qualityController.isToDate.value,
                qualityController.isFromDate.value,
                qualityController.fromDate.value,
                qualityController.toDate.value, (value) {
              selectedSysdocValue = value;
              qualityController.selectDateRange(selectedSysdocValue.value,
                  DateRangeSelector.dateRange.indexOf(selectedSysdocValue));
            },
                () => qualityController.selectDate(
                    context, qualityController.isFromDate.value))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              qualityController.getArrivalReportOpenList();
              // Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextField _buildDateTextFeild(BuildContext context,
      {required String label,
      required Function() onTap,
      required bool enabled,
      required bool isDate,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      readOnly: true,
      enabled: enabled,
      onTap: onTap,
      style: TextStyle(
        fontSize: 14,
        color: enabled ? Theme.of(context).primaryColor : mutedColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w400,
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        suffix: Icon(
          isDate ? Icons.calendar_month : Icons.location_pin,
          size: 15,
          color: enabled ? Theme.of(context).primaryColor : mutedColor,
        ),
      ),
    );
  }

  Container _buildTaskListPopContet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Obx(() => qualityController.isTaskListLoading.value
          ? CommonWidgets.popShimmer()
          : qualityController.taskFilterList.isEmpty
              ? SizedBox(
                height: 150,
                child: Center(child: Text('No Data Found')))
              : ListView.separated(
                  itemCount: qualityController.taskFilterList.length,
                  itemBuilder: (context, index) {
                    var task = qualityController.taskFilterList[index];
                    return InkWell(
                      onTap: () {
                        qualityController.task.value =
                            qualityController.taskFilterList[index];
                        qualityController.vendor.value = CommonComboModel(
                            code: qualityController.task.value.vendorId,
                            name: qualityController.task.value.vendor);
                        qualityController.containerNumberController.value.text =
                            qualityController.task.value.container ?? "";
                        Navigator.pop(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                '${task.taskCode}',
                                minFontSize: 12,
                                maxFontSize: 18,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildTileRow(
                                  title: 'Container#',
                                  content: '${task.container}'),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildTileRow(
                                  title: 'Vendor', content: '${task.vendor}'),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildTileRow(
                                  title: 'GRN Number',
                                  content: '${task.grnNumber}'),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildTileRow(
                                  title: 'Description',
                                  content: '${task.description}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ))),
    );
  }

  Row _buildTileRow({required String title, required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '$title : ',
          minFontSize: 8,
          maxFontSize: 12,
          style: const TextStyle(
            color: mutedColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            content,
            minFontSize: 10,
            maxFontSize: 12,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> addOrUpdateItem(BuildContext context,
      {required bool isUpdating, ItemListModel? item}) {
    if (isUpdating) {
      qualityController.prefilDataonUpdate(item!);
    } else {
      qualityController.prefilDataonUpdate(qualityController.lastItem.value);
      qualityController.result.value.files.clear();
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isUpdating ? "Update Item" : "Add Items",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            content: Container(
                width: double.maxFinite, child: _buildPopupBody(context)),
            actions: [
              CommonWidgets.elevatedButton(context, onTap: () {
                qualityController.clearCommodity();
              }, type: ButtonTypes.Secondary, text: 'Clear'),
              CommonWidgets.elevatedButton(context, onTap: () {
                isUpdating
                    ? qualityController.updateItem(item!)
                    : qualityController.addItem();
                Navigator.pop(context);
                if (isUpdating) {
                  SnackbarServices.successSnackbar(
                      'Commodity Updated Successfully');
                }
              }, type: ButtonTypes.Primary, text: isUpdating ? 'Update' : 'Add')
            ],
          );
        });
  }

  Widget _buildPopupBody(BuildContext context) {
    return Column(
      // shrinkWrap: true,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => CommonWidgets.textField(context,
                controller: qualityController.commoditController.value,
                // controller: TextEditingController(
                //     text:
                //         '${qualityController.commodit.value.code ?? ''} - ${qualityController.commodit.value.name ?? ''}'),
                suffixicon: true,
                label: 'Commodit',
                icon: Icons.arrow_drop_down_circle_outlined,
                readonly: true, ontap: () async {
              qualityController.commodit.value =
                  await homeController.selectComboOption(
                      context: context,
                      heading: 'Commodity',
                      list: homeController.categoryList,
                      combo: ComboOptions.Category);

              qualityController.commoditController.value.text =
                  '${qualityController.commodit.value.code ?? ''} - ${qualityController.commodit.value.name ?? ''}';
            }, keyboardtype: TextInputType.name)),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.varietyController.value,
                      // controller: TextEditingController(
                      //     text:
                      //         '${qualityController.variety.value.code ?? ''} - ${qualityController.variety.value.name ?? ''}'),
                      suffixicon: true,
                      icon: Icons.arrow_drop_down_circle_outlined,
                      label: 'Variety',
                      readonly: true, ontap: () async {
                    qualityController.variety.value =
                        await homeController.selectComboOption(
                            context: context,
                            heading: 'Variety',
                            list: homeController.styleList,
                            combo: ComboOptions.Style);
                    qualityController.varietyController.value.text =
                        '${qualityController.variety.value.code ?? ''} - ${qualityController.variety.value.name ?? ''}';
                  }, keyboardtype: TextInputType.name)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Obx(() => CommonWidgets.textField(context,
                      controller: qualityController.brandController.value,
                      // controller: TextEditingController(
                      //     text:
                      //         '${qualityController.brand.value.code ?? ''} - ${qualityController.brand.value.name ?? ''}'),
                      suffixicon: true,
                      icon: Icons.arrow_drop_down_circle_outlined,
                      label: 'Brand',
                      readonly: true, ontap: () async {
                    qualityController.brand.value =
                        await homeController.selectComboOption(
                            context: context,
                            heading: 'Brand',
                            list: homeController.brandList,
                            combo: ComboOptions.Brand);
                    qualityController.brandController.value.text =
                        '${qualityController.brand.value.code ?? ''} - ${qualityController.brand.value.name ?? ''}';
                  }, keyboardtype: TextInputType.name)),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.sizeController.value,
                  suffixicon: false,
                  label: 'Size',
                  readonly: false, ontap: () {
                qualityController.sizeController.value.selectAll();
              }, keyboardtype: TextInputType.text),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.gradeController.value,
                  suffixicon: false,
                  label: 'Grade',
                  readonly: false, ontap: () {
                qualityController.gradeController.value.selectAll();
              }, keyboardtype: TextInputType.text),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.lotNoController.value,
                  suffixicon: false,
                  label: 'Lot No',
                  readonly: false, ontap: () {
                qualityController.lotNoController.value.selectAll();
              }, keyboardtype: TextInputType.text),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.growerController.value,
                  suffixicon: false,
                  label: 'Grower',
                  readonly: false, ontap: () {
                qualityController.growerController.value.selectAll();
              }, keyboardtype: TextInputType.text),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.countController.value,
                  suffixicon: false,
                  label: 'Count',
                  readonly: false, ontap: () {
                qualityController.countController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: false)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.stWeightController.value,
                  suffixicon: false,
                  label: 'St.Weight',
                  readonly: false, ontap: () {
                qualityController.stWeightController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.wasteController.value,
                  suffixicon: false,
                  label: 'Waste',
                  readonly: false, ontap: () {
                qualityController.wasteController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.bruisController.value,
                  suffixicon: false,
                  label: 'Bruis',
                  readonly: false, ontap: () {
                qualityController.bruisController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.progressController.value,
                  suffixicon: false,
                  label: 'Progress',
                  readonly: false, ontap: () {
                qualityController.progressController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.cosmeticController.value,
                  suffixicon: false,
                  label: 'Cosmetic',
                  readonly: false, ontap: () {
                qualityController.cosmeticController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.weightController.value,
                  suffixicon: false,
                  label: 'Weight',
                  readonly: false, ontap: () {
                qualityController.weightController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.brixController.value,
                  suffixicon: false,
                  label: 'Brix',
                  readonly: false, ontap: () {
                qualityController.brixController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
          ],
        ),
        _buildSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.pressureController.value,
                  suffixicon: false,
                  label: 'Pressure',
                  readonly: false, ontap: () {
                qualityController.pressureController.value.selectAll();
              }, keyboardtype: TextInputType.numberWithOptions(decimal: true)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.textField(context,
                  controller: qualityController.remarksController.value,
                  suffixicon: false,
                  label: 'Remarks',
                  readonly: false, ontap: () {
                qualityController.remarksController.value.selectAll();
              }, keyboardtype: TextInputType.text),
            ),
          ],
        ),
        _buildSpacer(),
        GetBuilder<QualityControlController>(builder: (controller) {
          return GestureDetector(
            onTap: () async {
              if (homeController.attachmentMethod.value ==
                  FileAttachmentOptions.Camera.value) {
                qualityController.takePicture();
              } else if (homeController.attachmentMethod.value ==
                  FileAttachmentOptions.Files.value) {
                qualityController.selectFile();
              } else {
                showModalBottomSheet(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            18,
                          ),
                          topRight: Radius.circular(
                            18,
                          ))),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.camera_alt_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Camera"),
                            onTap: () {
                              homeController.attachmentMethod.value =
                                  FileAttachmentOptions.Camera.value;
                              qualityController.takePicture();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.photo_library_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text("Files"),
                            onTap: () async {
                              homeController.attachmentMethod.value =
                                  FileAttachmentOptions.Files.value;
                              qualityController.selectFile();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  color: mutedColor,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        color: mutedColor.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(10)),
                    child: qualityController.result.value.files.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: mutedColor,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Attach File',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 12,
                                              mainAxisSpacing: 8),
                                      itemCount:
                                          controller.result.value.files.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        log("${controller.result.value.files[index].bytes == null}");
                                        return InkWell(
                                          onTap: () {
                                            // controller.removeFile(index);
                                            _buildPreview(
                                                context, controller, index);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: controller
                                                        .result
                                                        .value
                                                        .files[index]
                                                        .extension ==
                                                    "pdf"
                                                ? Image.asset(
                                                    "asset/icons/pdf.png",
                                                    fit: BoxFit.fill,
                                                    height: 50,
                                                    width: 50,
                                                  )
                                                : controller
                                                            .result
                                                            .value
                                                            .files[index]
                                                            .bytes ==
                                                        null
                                                    ? Image(
                                                        image: FileImage(File(
                                                            controller
                                                                .result
                                                                .value
                                                                .files[index]
                                                                .path!)))
                                                    : Image(
                                                        fit: BoxFit.fill,
                                                        image: MemoryImage(
                                                            controller
                                                                .result
                                                                .value
                                                                .files[index]
                                                                .bytes!),
                                                      ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Visibility(
                                visible: qualityController
                                    .result.value.files.isNotEmpty,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.2),
                                    child: IconButton(
                                        onPressed: () {
                                          if (homeController
                                                  .attachmentMethod.value ==
                                              FileAttachmentOptions
                                                  .Camera.value) {
                                            qualityController.takePicture();
                                          } else if (homeController
                                                  .attachmentMethod.value ==
                                              FileAttachmentOptions
                                                  .Files.value) {
                                            qualityController.selectFile();
                                          } else {
                                            showModalBottomSheet(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            18,
                                                          ),
                                                          topRight:
                                                              Radius.circular(
                                                            18,
                                                          ))),
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        title: Text("Camera"),
                                                        onTap: () {
                                                          homeController
                                                                  .attachmentMethod
                                                                  .value =
                                                              FileAttachmentOptions
                                                                  .Camera.value;
                                                          qualityController
                                                              .takePicture();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons
                                                              .photo_library_outlined,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        title: Text("Files"),
                                                        onTap: () async {
                                                          homeController
                                                                  .attachmentMethod
                                                                  .value =
                                                              FileAttachmentOptions
                                                                  .Files.value;
                                                          qualityController
                                                              .selectFile();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.photo_camera_back_outlined,
                                          color: mutedColor,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                )),
          );
        }),
      ],
    );
  }

  Future<dynamic> _buildPreview(BuildContext context,
      QualityControlController controller, int index) async {
    Uint8List bytes = Uint8List(0);
    if (controller.result.value.files[index].bytes != null) {
      bytes = await controller.result.value.files[index].bytes!;
    } else {
      File file = File(controller.result.value.files[index]
          .path!); // Create a Dart File from the PlatformFile
      bytes = await file.readAsBytes();
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            content: Container(
              // height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: LimitedBox(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  child: controller.result.value.files[index].extension == "pdf"
                      ? SizedBox(
                          width: 0.75 * MediaQuery.of(context).size.width,
                          child: CommonWidgets.buildPdfView(bytes))
                      : controller.result.value.files[index].bytes == null
                          ? Image(
                              fit: BoxFit.contain,
                              image: FileImage(File(
                                  controller.result.value.files[index].path!)))
                          : Image(
                              fit: BoxFit.fill,
                              image: MemoryImage(
                                  controller.result.value.files[index].bytes!),
                            )),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: CommonWidgets.elevatedButton(context, onTap: () {
                  qualityController.removeFile(index);
                  Navigator.pop(context);
                }, type: ButtonTypes.Secondary, text: 'Delete'),
              )
            ],
          );
        });
  }

  Future<dynamic> _buildItemImagePopup(
      BuildContext context, List<AttachmentModel> files) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            content: Container(
              width: double.maxFinite,
              height: 300,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 8),
                  itemCount: files.length,
                  itemBuilder: (BuildContext ctx, index) {
                    log("${files[index].path == ""}");
                    // Uint8List bytes;
                    // if (files[index].path == "") {
                    //   Uint8List bytes =
                    //       const Base64Codec().decode(files[index].file ?? '');
                    // }
                    return InkWell(
                      onTap: () {
                        log("${files[index].file}");
                        // controller.removeFile(index);
                        // _buildPreview(context, controller, index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: files[index].extension == "pdf"
                            ? Image.asset(
                                "asset/icons/pdf.png",
                                fit: BoxFit.fill,
                                height: 50,
                                width: 50,
                              )
                            : files[index].path == "" ||
                                    files[index].path == null
                                ? Image(
                                    fit: BoxFit.fill,
                                    image: MemoryImage(Base64Codec()
                                        .decode(files[index].file ?? '')),
                                  )
                                : Image(
                                    fit: BoxFit.fill,
                                    image: FileImage(File(files[index].path!))),
                      ),
                    );
                  }),
            ),
          );
        });
  }

  Widget _buildTotalDetails({required String title, required double value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Flexible(
            child: AutoSizeText(
              value.toStringAsFixed(2),
              textAlign: TextAlign.end,
              minFontSize: 6,
              maxFontSize: 14,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardDetails(Size size,
      {required String title, required String content}) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: mutedColor),
        ),
        Expanded(
          // width: size.width * 0.4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ' $content',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: commonBlack),
            ),
          ),
        )
      ],
    );
  }

  SizedBox _buildSpacer() {
    return SizedBox(
      height: 18,
    );
  }

  SizedBox _buildLineSpacer() {
    return SizedBox(
      height: 5,
    );
  }
}
