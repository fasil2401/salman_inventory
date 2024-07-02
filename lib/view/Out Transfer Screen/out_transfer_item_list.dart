import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/out_transfer_scanning.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutTransferItemListScreen extends StatelessWidget {
  OutTransferItemListScreen({super.key});
  final outTransferController = Get.put(OutTransferController());
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
                outTransferController.searchProduct(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GetBuilder<OutTransferController>(
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
                                      AddUpdateItem(),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  CommonWidgets.elevatedButton(
                                                context,
                                                onTap: () {
                                                  outTransferController
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
          Get.to(() => const OutTransferScan());
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
