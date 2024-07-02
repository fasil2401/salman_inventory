import 'dart:math';

import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateItem extends StatelessWidget {
  AddUpdateItem({
    this.units,
    this.isUpdate = false,
    super.key,
  });

  List<Unitmodel>? units;
  bool isUpdate;
  final outTransferController = Get.put(OutTransferController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(color: AppColors.mutedColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          outTransferController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          outTransferController
                                  .quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: outTransferController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: outTransferController.isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller: outTransferController
                                        .quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      outTransferController.setQuantity(value);
                                    },
                                    onTap: () {
                                      outTransferController
                                          .quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        outTransferController.editQuantity();
                                        outTransferController
                                                .quantityControl.value.text =
                                            outTransferController.quantity.value
                                                .toString();
                                      },
                                      child: Text(outTransferController
                                          .quantity.value
                                          .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          outTransferController.incrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Stock',
                  style: TextStyle(color: AppColors.mutedColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => Text("${InventoryCalculations.getStockPerFactor(
                      factorType:
                          outTransferController.selectedUnit.value.factorType ??
                              'M',
                      factor: double.parse(
                          outTransferController.selectedUnit.value.factor ??
                              '1.0'),
                      stock: outTransferController.quantityAvailable.value,
                    )}")),
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Obx(() => CommonWidgets.textField(context,
                suffixicon: false,
                readonly: true,
                keyboardtype: TextInputType.text,
                controller: TextEditingController(
                    text: "${outTransferController.selectedUnit.value.code}"),
                label: "Units", ontap: () {
              CommonWidgets.commonDialog(
                  context,
                  "Units",
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: isUpdate
                                ? units!.length
                                : outTransferController.productUnitList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              
                              var item = isUpdate
                                  ? units![index]
                                  : outTransferController
                                      .productUnitList[index];
                              return InkWell(
                                onTap: () {
                                  outTransferController.selectedUnit.value =
                                      item;
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${item.code}"),
                                ),
                              );
                            }),
                      ),
                    ],
                  ));
            }))
      ],
    );
  }
}
