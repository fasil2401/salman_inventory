import 'package:axolon_inventory_manager/controller/App%20Controls/direct_inventory_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/extensions.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectInventoryAddUpdateItem extends StatelessWidget {
  DirectInventoryAddUpdateItem({
    this.units,
    this.isUpdate = false,
    super.key,
  });

  List<Unitmodel>? units;
  bool isUpdate;
  final directInventoryTransferController =
      Get.put(DirectInventoryTransferController());
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
                          directInventoryTransferController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          directInventoryTransferController
                                  .quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: directInventoryTransferController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: directInventoryTransferController
                                    .isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller:
                                        directInventoryTransferController
                                            .quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      directInventoryTransferController
                                          .setQuantity(value);
                                    },
                                    onTap: () {
                                      directInventoryTransferController
                                          .quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        directInventoryTransferController
                                            .editQuantity();
                                        directInventoryTransferController
                                                .quantityControl.value.text =
                                            directInventoryTransferController
                                                .quantity.value
                                                .toString();
                                      },
                                      child: Text(
                                          directInventoryTransferController
                                              .quantity.value
                                              .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          directInventoryTransferController.incrementQuantity();
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
                Obx(() => Text(InventoryCalculations.getStockPerFactor(
                      factorType: directInventoryTransferController
                              .selectedUnit.value.factorType ??
                          'M',
                      factor: double.parse(directInventoryTransferController
                              .selectedUnit.value.factor ??
                          '1.0'),
                      stock: directInventoryTransferController
                          .quantityAvailable.value,
                    ).toStringAsFixed(2))),
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
                    text:
                        "${directInventoryTransferController.selectedUnit.value.code}"),
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
                                : directInventoryTransferController
                                    .productUnitList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = isUpdate
                                  ? units![index]
                                  : directInventoryTransferController
                                      .productUnitList[index];
                              return InkWell(
                                onTap: () {
                                  directInventoryTransferController
                                      .selectedUnit.value = item;
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
