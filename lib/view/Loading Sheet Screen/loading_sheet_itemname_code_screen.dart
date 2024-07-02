import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/item_detail_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingsheetItemDetailItemListScreen extends StatelessWidget {
  LoadingsheetItemDetailItemListScreen({super.key});
  final loadingsheetController = Get.put(LoadingSheetsController());
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
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
                loadingsheetController.searchProductList(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GetBuilder<LoadingSheetsController>(
                  builder: (_) {
                    return _.isLoadingProducts.value
                        ? CommonWidgets.popShimmer()
                        : ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var itemname = _.nameList[index];

                              return InkWell(
                                onTap: () {
                                  log("${index}");

                                  loadingsheetController
                                          .nameController.value.text =
                                      "${itemname.productId} - ${itemname.description}";
                                  loadingsheetController
                                      .updateSelectedProduct(itemname);

                                  Navigator.pop(context);
                                },
                                  child: _buildRows(
                                  context,
                                  code: '${itemname.productId}',
                                  name: '${itemname.description}',
                                  isHeader: false,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                height: height * 0.03,
                                ),
                            itemCount: _.nameList.length,
                          );
                  },
                )),
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
}
