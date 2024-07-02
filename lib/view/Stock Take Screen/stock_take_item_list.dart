import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/stock_take_controller.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_byid_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTakeItemListScreen extends StatelessWidget {
  StockTakeItemListScreen({super.key});
  final stockTakeController = Get.put(StockTakeController());
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
              autofocus: true,
              readonly: false,
              keyboardtype: TextInputType.text,
              label: 'Search',
              icon: Icons.search,
              onchanged: (value) {
                stockTakeController.filterProduct(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GetBuilder<StockTakeController>(
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
                                onTap: () {
                                  stockTakeController.addingItem(item);
                                  CommonWidgets.commonDialog(
                                      context,
                                      "${item.description}",
                                      addItemPopup(context),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  CommonWidgets.elevatedButton(
                                                context,
                                                onTap: () {
                                                  stockTakeController
                                                      .addStockItem(
                                                          StockDetailModel(
                                                    description:
                                                        item.description,
                                                    productId: item.productId,
                                                    quantity: item.quantity,
                                                    physicalQuantity:
                                                        stockTakeController
                                                            .quantity.value,
                                                    unitId: item.unitId,
                                                    remarks: null,
                                                  ));
                                                  stockTakeController
                                                      .resetQuantity();
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
                                child: _buildRows(
                                  context,
                                  code: '${item.productId}',
                                  name: '${item.description}',
                                  isHeader: false,
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

  addItemPopup(BuildContext context) {
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
                          stockTakeController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          stockTakeController.quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: stockTakeController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: stockTakeController.isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller: stockTakeController
                                        .quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      stockTakeController.setQuantity(value);
                                    },
                                    onTap: () {
                                      stockTakeController.quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        stockTakeController.editQuantity();
                                        stockTakeController
                                                .quantityControl.value.text =
                                            stockTakeController.quantity.value
                                                .toString();
                                      },
                                      child: Text(stockTakeController
                                          .quantity.value
                                          .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          stockTakeController.incrementQuantity();
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
                Text(stockTakeController.stockCtrl.value.text.toString()),
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        CommonWidgets.textField(context,
            suffixicon: false,
            readonly: true,
            keyboardtype: TextInputType.text,
            controller: stockTakeController.unitIdCtrl.value,
            label: "Units", ontap: () {
          CommonWidgets.commonDialog(context, "Units", unitPopup());
        })
      ],
    );
  }

  unitPopup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GetBuilder<StockTakeController>(
            init: StockTakeController(),
            initState: (_) {},
            builder: (_) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _.productUnitList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = _.productUnitList[index];
                    return InkWell(
                      onTap: () {
                        _.unitIdCtrl.value.text = "${item.code ?? ''}";
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${item.code}"),
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
