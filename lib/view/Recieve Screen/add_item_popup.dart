import 'package:axolon_inventory_manager/controller/App%20Controls/recieve_controller.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateItemRecieve extends StatelessWidget {
  AddUpdateItemRecieve({
    this.units,
    this.isUpdate = false,
    super.key,
  });

  List<Unitmodel>? units;
  bool isUpdate;
  final recieveController = Get.put(RecieveController());
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
                          recieveController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          recieveController.quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: recieveController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: recieveController.isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller:
                                        recieveController.quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      recieveController.setQuantity(value);
                                    },
                                    onTap: () {
                                      recieveController.quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        recieveController.editQuantity();
                                        recieveController
                                                .quantityControl.value.text =
                                            recieveController.quantity.value
                                                .toString();
                                      },
                                      child: Text(recieveController
                                          .quantity.value
                                          .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          recieveController.incrementQuantity();
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
                          recieveController.selectedUnit.value.factorType ??
                              'M',
                      factor: double.parse(
                          recieveController.selectedUnit.value.factor ?? '1.0'),
                      stock: recieveController.quantityAvailable.value,
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
                    text: "${recieveController.selectedUnit.value.code}"),
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
                                : recieveController.productUnitList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = isUpdate
                                  ? units![index]
                                  : recieveController.productUnitList[index];
                              return InkWell(
                                onTap: () {
                                  recieveController.selectedUnit.value = item;
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
            })),
        SizedBox(
          height: 25,
        ),
        Obx(() => CommonWidgets.textField(
              context,
              suffixicon: true,
              readonly: true,
              keyboardtype: TextInputType.datetime,
              controller: TextEditingController(
                  text:
                      '${recieveController.selectedLocation.value.code} - ${recieveController.selectedLocation.value.name}'),
              label: 'Location',
              ontap: () {
                CommonWidgets.commonDialog(
                    context,
                    'Locations',
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LocationModel item =
                              recieveController.locationList[index];
                          return CommonWidgets.commonListTile(
                              context: context,
                              code: item.code ?? '',
                              name: item.name ?? '',
                              onPressed: () {
                                recieveController.selectLocation(index);
                                Navigator.pop(context);
                              });
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8,
                            ),
                        itemCount: recieveController.locationList.length));
              },
            )),
        SizedBox(
          height: 25,
        ),
        CommonWidgets.textField(context,
            controller: recieveController.remarksController.value,
            suffixicon: false,
            readonly: false,
            keyboardtype: TextInputType.text,
            maxLength: null,
            maxLines: null,
            label: 'Remarks')
      ],
    );
  }
}
