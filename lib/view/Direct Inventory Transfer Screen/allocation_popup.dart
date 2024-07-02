import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/direct_inventory_transfer_controller.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/services/extensions.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LotAllocation extends StatelessWidget {
  LotAllocation({
    super.key,
    required this.product,
    required this.isUpdate,
    required this.index,
    required this.unitList,
  });
  final directInventoryTransferController =
      Get.put(DirectInventoryTransferController());
  final product;
  final bool isUpdate;
  final int index;
  final List<dynamic> unitList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        tableHeader(context),
        Flexible(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<DirectInventoryTransferController>(
            // init: MyController(),
            // initState: (_) {},
            builder: (_) {
              return _.isLotsListLoading.value
                  ? CommonWidgets.popShimmer()
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: _.availableLotsOpenList.length,
                      itemBuilder: (context, index) {
                        var item = _.availableLotsOpenList[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildRows(
                              context,
                              lotNo: item.lotNumber.toString(),
                              isError: false,
                              available: item.availableQty.toString(),
                              controller: item.controller,
                              onChangedOfQuantity: (value) {
                                
                              },
                            ));
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                    );
            },
          ),
        )),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: CommonWidgets.elevatedButton(context, onTap: () {
              Navigator.pop(context);
            }, type: ButtonTypes.Secondary, text: 'Cancel')),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: CommonWidgets.elevatedButton(context, onTap: () {
              directInventoryTransferController.addItem();
              Navigator.pop(context);
              Navigator.pop(context);
            }, type: ButtonTypes.Primary, text: 'Save')),
          ],
        ),
      ],
    );
  }

  Container tableHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildRows(
          context,
          lotNo: 'Lot Number',
          available: 'Available',
          quantity: 'Quantity',
          isHeader: true,
        ),
      ),
    );
  }

  Row _buildRows(
    BuildContext context, {
    required String lotNo,
    required String available,
    Function(dynamic)? onChangedOfQuantity,
    String? quantity,
    bool isHeader = false,
    bool isError = false,
    TextEditingController? controller,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              lotNo,
              style: TextStyle(
                fontSize: 12,
                color: isHeader
                    ? Theme.of(context).primaryColor
                    : AppColors.mutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (isHeader) VerticalDivider(color: Theme.of(context).primaryColor),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              available,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isHeader
                    ? Theme.of(context).primaryColor
                    : AppColors.mutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (isHeader) VerticalDivider(color: Theme.of(context).primaryColor),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: isHeader
                ? Text(
                    quantity ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isHeader
                          ? Theme.of(context).primaryColor
                          : AppColors.mutedColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: controller,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 3,
                          ),
                          isCollapsed: true,
                        ),
                        onTap: () {
                          controller!.selectAll();
                        },
                        onChanged: onChangedOfQuantity,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$')),
                        ],
                      ),
                      if (isError)
                        AutoSizeText(
                          "*Quantity error",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        )
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
