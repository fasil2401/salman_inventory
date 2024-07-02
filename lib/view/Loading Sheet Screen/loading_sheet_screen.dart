import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/loading_sheet_local_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'create_loading_sheet_screen.dart';

class LoadingSheetScreen extends StatelessWidget {
  LoadingSheetScreen({this.isInProgress = false, super.key});

  bool isInProgress;
  final loadingSheetController = Get.put(LoadingSheetsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              if (isInProgress)
                InkWell(
                    onTap: () async {
                      loadingSheetController.getDatasOnTapCreatNew(context);
                      Get.to(() => CreateLoadingSheetScreen())?.then((value) =>
                          loadingSheetController
                              .getLoadingSheetListFromLocal());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(8)),
                      child: Obx(
                        () => loadingSheetController.isloadingDatas.value
                            ? CircularProgressIndicator()
                            : Text("Create New",
                                style: TextStyle(
                                    fontSize: 17, color: commonBlueColor)),
                      ),
                    )),
              SizedBox(
                height: 14,
              ),
              GetBuilder<LoadingSheetsController>(builder: (controller) {
                return controller.isLoading.value
                    ? CommonWidgets.popShimmer()
                    : controller.localLoadingItemList.isEmpty
                        ? Center(
                            child: Text("No Data"),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.localLoadingItemList.length,
                            // controller.loadingItemLIst.length,
                            itemBuilder: (context, index) {
                              // OpenList item =
                              //     controller.loadingItemLIst[index];

                              LoadingSheetsHeaderModel item =
                                  controller.localLoadingItemList[index];
                              if (isInProgress) {
                                if (item.isCompleted == 1) {
                                  return SizedBox();
                                }
                              } else {
                                if (item.isCompleted != 1) {
                                  return SizedBox();
                                }
                              }
                              return Slidable(
                                key: const Key('loading_sheet_list'),
                                enabled: item.isCompleted == 0,
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                        backgroundColor: Colors.green[100]!,
                                        foregroundColor: Colors.green,
                                        icon: Icons.mode_edit_outlined,
                                        onPressed: (_) async {
                                          // controller.getItemTransactionByID(context,
                                          //     item.docId ?? '', item.docNumber ?? '');
                                          await controller
                                              .getItemTransactionIdFromLocal(
                                                  header: item);
                                          Get.to(() =>
                                                  CreateLoadingSheetScreen())
                                              ?.then((value) => controller
                                                  .getLoadingSheetListFromLocal());
                                        }),
                                  ],
                                ),
                                // endActionPane: ActionPane(

                                //   motion: const DrawerMotion(),
                                //   children: [
                                //     SlidableAction(
                                //       backgroundColor: Colors.red[100]!,
                                //       foregroundColor: Colors.red,
                                //       icon: Icons.delete,
                                //       onPressed: (_) {
                                //         showDialog(
                                //             context: context,
                                //             builder: (BuildContext context) {
                                //               return AlertDialog(
                                //                 title: Text('Confirmation'),
                                //                 content: Text(
                                //                     "Do you want to delete?"),
                                //                 actions: [
                                //                   TextButton(
                                //                     onPressed: () {
                                //                       Navigator.pop(context);
                                //                     },
                                //                     child: Text('Cancel'),
                                //                   ),
                                //                   TextButton(
                                //                     onPressed: () {
                                //                       controller
                                //                           .deleteFromLocal(
                                //                               item.voucherid ??
                                //                                   '');
                                //                       Navigator.of(context)
                                //                           .pop();
                                //                     },
                                //                     child: Text('Yes'),
                                //                   ),
                                //                 ],
                                //               );
                                //             });
                                //       },
                                //     ),
                                //   ],
                                // ),
                                child: Card(
                                    margin: EdgeInsets.only(bottom: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadowColor: Colors.black,
                                    elevation: 10,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // item.docNumber ?? "",
                                                item.reference2 ?? '',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: commonBlueColor),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildTileTextTime(
                                                      text:
                                                          item.voucherid ?? '',
                                                      title: 'Voucher No.'),
                                                  _buildTileTextTime(
                                                      text:
                                                          "${item.transactionDate == null ? '' : DateFormatter.dateFormat.format(DateTime.parse(item.transactionDate!))}",
                                                      title: 'Date'),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildTileTextTime(
                                                      text: item.startTime !=
                                                              null
                                                          ? controller
                                                              .getTimeOfDayFromString(
                                                                  item.startTime!)
                                                              .format(context)
                                                          : '',
                                                      title: 'Start Time'),
                                                  _buildTileTextTime(
                                                      text: item.endTime != null
                                                          ? controller
                                                              .getTimeOfDayFromString(
                                                                  item.endTime!)
                                                              .format(context)
                                                          : '',
                                                      title: 'End Time'),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              _buildTileTextTime(
                                                  text: item.partyName ?? "",
                                                  title: 'Party Name'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: _buildTileTextTime(
                                                      text:
                                                          item.categories ?? '',
                                                      title: 'Item Category',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (isInProgress)
                                                Row(
                                                  children: [
                                                    _buildTileTextTime(
                                                        text: "",
                                                        title: 'Completed'),
                                                    Transform.scale(
                                                      scale: 0.6,
                                                      child: CupertinoSwitch(
                                                        activeColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        value:
                                                            item.completedToggle ??
                                                                false,
                                                        onChanged: (value) {
                                                          controller
                                                              .setCompleted(
                                                                  value: value,
                                                                  index: index);
                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    CommonWidgets.elevatedButton(
                                                        context, onTap:
                                                            () async {
                                                      final isConfirm =
                                                          await showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            new AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          title: new Text(
                                                              'Are you sure?',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          content: new Text(
                                                              'Do you want to post the current data?'),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          25,
                                                                      vertical:
                                                                          15),
                                                          actions: <Widget>[
                                                            InkWell(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .backgroundColor,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                )),
                                                            InkWell(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                      if (isConfirm) {
                                                        controller
                                                            .completeLoadingSheetHeader(
                                                                item, index);
                                                      } else {
                                                        controller.setCompleted(
                                                            value: controller
                                                                .completedToggle
                                                                .value,
                                                            index: index);
                                                      }
                                                    },
                                                        text: 'Post',
                                                        isLoading: controller
                                                                    .isDataPosting
                                                                    .value &&
                                                                controller
                                                                        .selectedIndex
                                                                        .value ==
                                                                    index
                                                            ? true
                                                            : false,
                                                        isDisabled:
                                                            item.completedToggle !=
                                                                    null
                                                                ? !item
                                                                    .completedToggle!
                                                                : true,
                                                        type:
                                                            ButtonTypes.Primary)
                                                  ],
                                                ),
                                              if (!isInProgress)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () => controller
                                                          .previewApproval(
                                                              context,
                                                              sysDoc:
                                                                  item.sysdocid ??
                                                                      '',
                                                              voucher:
                                                                  item.voucherid ??
                                                                      ''),
                                                      child: SvgPicture.asset(
                                                        AppIcons.print,
                                                        color:
                                                            AppColors.primary,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                    )
                                                  ],
                                                )
                                            ],
                                          ),
                                        ))),
                              );
                            },
                          );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTileTextTime({required String title, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : ",
            textAlign: TextAlign.start,
            maxLines: 1,
            style: TextStyle(fontSize: 13, color: mutedColor)),
        title == 'Party Name'
            ? Expanded(
                child: Text(text,
                    textAlign: TextAlign.start,
                    // maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        color: mutedColor,
                        fontWeight: FontWeight.w400)),
              )
            : Text(text,
                textAlign: TextAlign.start,
                // maxLines: 2,
                style: TextStyle(
                    fontSize: 13,
                    color: mutedColor,
                    fontWeight: FontWeight.w400)),
      ],
    );
  }
}
