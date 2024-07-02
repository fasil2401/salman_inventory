import 'dart:developer' as dev;

import 'package:axolon_inventory_manager/controller/App%20Controls/direct_inventory_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/allocation_popup.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/direct_transfer_scanning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectInventoryTransferItemListScreen extends StatelessWidget {
  DirectInventoryTransferItemListScreen({super.key});
  final directInventoryTransferController =
      Get.put(DirectInventoryTransferController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonWidgets.textField(
              context,
              suffixicon: true,
              readonly: false,
              keyboardtype: TextInputType.text,
              label: 'Search',
              icon: Icons.search,
              onchanged: (value) {
                directInventoryTransferController.searchProduct(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GetBuilder<DirectInventoryTransferController>(
                initState: (_) {},
                builder: (_) {
                  return _.isLoadingProducts.value
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ProductListModel item = _.filterProductList[index];
                            return InkWell(
                                onTap: () async {
                                  await _.selectSearchItem(item);
                                  CommonWidgets.commonDialog(
                                      context,
                                      "${item.description ?? ''}",
                                      DirectInventoryAddUpdateItem(),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  CommonWidgets.elevatedButton(
                                                context,
                                                onTap: () async {
                                                  directInventoryTransferController
                                                      .getAvailableLotsProductList();

                                                  item.isTrackLot == 1
                                                      ? await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                              content:
                                                                  LotAllocation(
                                                                index: index,
                                                                isUpdate: true,
                                                                product: [],
                                                                unitList: [],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : directInventoryTransferController
                                                          .addItem();
                                                  Navigator.pop(context);
                                                },
                                                type: ButtonTypes.Primary,
                                                text: "Add",
                                              ),
                                            ),
                                          ],
                                        )
                                      ]);
                                },
                                child: Column(
                                  children: [
                                    _buildRows(
                                      context,
                                      code: '${item.productId}',
                                      name: '${item.description}',
                                      isHeader: false,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            item.quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: item.quantity < 0
                                                  ? Colors.red
                                                  : item.quantity == 0
                                                      ? Colors.black87
                                                      : Colors.green,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: height * 0.03,
                          ),
                          itemCount: _.filterProductList.length,
                        );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const DirectInventoryTransferScan());
        },
        child: Icon(Icons.qr_code_rounded),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildRows(context, code: 'Code', name: 'Name', isHeader: true),
      ),
    );
  }

  Row _buildRows(BuildContext context,
      {required String code, required String name, required bool isHeader}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            code,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
