import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/item_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class QuantitySheet extends StatelessWidget {
  QuantitySheet({
    required this.previousQuantity,
    required this.onTapPercent,
    required this.onTapAmount,
    required this.onChangePercent,
    required this.onChangeAmount,
    required this.quantityController,
    required this.item,
    Key? key,
  }) : super(key: key);
  final LoadingSheetsController controller = Get.put(LoadingSheetsController());
  final LoadingSheetsController myDataController = Get.find();

  Function() onTapPercent;
  Function() onTapAmount;
  Function(String value) onChangePercent;
  Function(String value) onChangeAmount;
  TextEditingController quantityController;
  Data item;
  String previousQuantity;
  final fieldText = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  // void clearText() {
  //   controller.quantityControllernew.value.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 48,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    //previousQuantity == ""
                    //?
                    AutoSizeText(
                      "   Quantity(${controller.quantity.value})",
                      style: TextStyle(fontSize: 20),
                      minFontSize: 10,
                      maxFontSize: 13,
                    )
                    // : AutoSizeText(
                    //     "   Quantity(${previousQuantity})",
                    //     style: TextStyle(fontSize: 20),
                    //     minFontSize: 10,
                    //     maxFontSize: 13,
                    //   )
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: MediaQuery.of(context).size.width / 12,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.black12),
                      vertical: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: InkWell(
                      onTap: () {
                        controller.decrementQuantity();
                      },
                      child: Icon(
                        Icons.remove,
                        color: mutedColor,
                      ))),
              Obx(
                () {
                  controller.quantityController.value.selection =
                      TextSelection.fromPosition(TextPosition(
                          offset:
                              controller.quantityController.value.text.length));
                  return Flexible(
                    child: controller.isEditingQuantity.value
                        ? TextField(
                            autofocus: false,
                            controller: controller.quantityController.value,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$')),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              hintText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              controller.setQuantity(value);
                            },
                            onTap: () {
                              controller.quantityController.value.selectAll();
                            },
                          )
                        : Obx(() => InkWell(
                              onTap: () {
                                controller.editQuantity();
                                controller.quantityController.value.text =
                                    controller.quantity.value.toString();
                              },
                              child: Container(
                                  height: 48,
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                      controller.quantity.value.toString())),
                            )),
                  );
                },
              ),
              Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: MediaQuery.of(context).size.width / 12,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.zero),
                  child: InkWell(
                      onTap: () {
                        controller.incrementQuantity();
                      },
                      child: Icon(Icons.add))),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("S.No.",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 60,
                        ),
                        Text("Quantity",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 40,
                        ),
                        Text("Description",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Divider(
                    //  height: 100,
                    color: Colors.black12,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Expanded(
                      child:
                          // GetX<LoadingSheetsController>(builder: (controller) {
                          //   return
                          ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    //  height: 100,
                                    color: Colors.black12,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                              // scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: item.qtyList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    controller.isEditingEditQuantities.value =
                                        false;
                                    controller.editQuantities.value =
                                        item.qtyList?[index].round() ?? 0;
                                    CommonWidgets.commonDialog(
                                        context,
                                        "Quantity",
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: 48,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  //previousQuantity == ""
                                                  //?
                                                  AutoSizeText(
                                                    "   Quantity(${controller.editQuantities.value})",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    minFontSize: 10,
                                                    maxFontSize: 13,
                                                  )
                                                  // : AutoSizeText(
                                                  //     "   Quantity(${previousQuantity})",
                                                  //     style: TextStyle(fontSize: 20),
                                                  //     minFontSize: 10,
                                                  //     maxFontSize: 13,
                                                  //   )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                height: 48,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                                decoration: BoxDecoration(
                                                  border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: Colors.black12),
                                                    vertical: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .decrementEditQuantities();
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: mutedColor,
                                                    ))),
                                            Obx(
                                              () {
                                                controller.quantityController
                                                        .value.selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset: controller
                                                                .quantityController
                                                                .value
                                                                .text
                                                                .length));
                                                return Flexible(
                                                  child: controller
                                                          .isEditingEditQuantities
                                                          .value
                                                      ? TextField(
                                                          autofocus: false,
                                                          controller: controller
                                                              .quantityController
                                                              .value,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'^\d*\.?\d*$')),
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            hintText: '',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .zero),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black12),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black12,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black12,
                                                              ),
                                                            ),
                                                          ),
                                                          onChanged: (value) {
                                                            controller
                                                                .setEditQuantities(
                                                                    value);
                                                          },
                                                          onTap: () {
                                                            controller
                                                                .quantityController
                                                                .value
                                                                .selectAll();
                                                          },
                                                        )
                                                      : Obx(() => InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .editEditQuantities();
                                                              controller
                                                                      .quantityController
                                                                      .value
                                                                      .text =
                                                                  controller
                                                                      .editQuantities
                                                                      .value
                                                                      .toString();
                                                            },
                                                            child: Container(
                                                                height: 48,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black12,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(controller
                                                                    .editQuantities
                                                                    .value
                                                                    .toString())),
                                                          )),
                                                );
                                              },
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                height: 48,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                    borderRadius:
                                                        BorderRadius.zero),
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .incrementEditQuantities();
                                                    },
                                                    child: Icon(Icons.add))),
                                          ],
                                        ),
                                        actions: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: CommonWidgets.elevatedButton(
                                              context,
                                              onTap: () {
                                                controller.updateEditQuantities(
                                                    item, index);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              type: ButtonTypes.Primary,
                                              text: 'Update',
                                            ),
                                          )
                                        ]);
                                  },
                                  child: _buildTileTextAlert(
                                      title1: "${index + 1}",
                                      title2: "${item.qtyList?[index]}",
                                      title3: item.product?.description ?? ''),
                                );
                              })
                      // }
                      //),
                      ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width,
            child: CommonWidgets.elevatedButton(
              context,
              onTap: () {
                onTapPercent();
                //cleardata();
                //controller.cleardata();
                controller.clearInputValue();
                Navigator.pop(context);
              },
              type: ButtonTypes.Primary,
              text: 'Add',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTileTextAlert({
    required String title1,
    required String title2,
    required String title3,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   width: 10,
          // ),
          Expanded(
            flex: 1,
            child: Text("$title1",
                textAlign: TextAlign.start,
                maxLines: 1,
                style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
          // SizedBox(
          //   width: 90,
          // ),
          Expanded(
            flex: 2,
            child: Text(title2,
                textAlign: TextAlign.center,
                // maxLines: 2,
                style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
          Expanded(
            flex: 2,
            child: Text(title3,
                textAlign: TextAlign.start,
                // maxLines: 2,
                style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void cleardata() {
    controller.quantityController.value.clear();
  }
}
