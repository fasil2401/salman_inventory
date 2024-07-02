import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/item_detail_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/screen_id.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Item%20Details%20Screen/item_picker_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'item_details_item_list_screen.dart';

typedef ValueCallback<T> = void Function(T value);

class ItemDetailsScreen extends StatelessWidget {
  final itemdetailController = Get.put(ItemDetailController());
  final homeController = Get.put(HomeController());
  ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Item Details'),
        actions: <Widget>[
          // Obx(
          //   () =>
          Container(
              child:
                  // !itemdetailController.isRefreshing.value
                  //     ?
                  IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () async {
              ;
              showModalBottomSheet(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          18,
                        ),
                        topRight: Radius.circular(
                          18,
                        ))),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 220,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Actions",
                                  style: TextStyle(
                                      color: AppColors.mutedColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.mutedColor,
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.white,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => _actionsbuildRows(context,
                                      title: 'Hold Sales',
                                      value: itemdetailController
                                          .holdSalesToggle.value,
                                      alertTextCondition: itemdetailController
                                          .holdSalesToggle.value,
                                      alertTextConditionOne:
                                          'Do you want to unhold sales?',
                                      alertTextConditionTwo:
                                          'Do you want to hold sales?',
                                      visiblityCondition: itemdetailController
                                          .holdSalesToggle.value,
                                      indicatorCondition: itemdetailController
                                          .isLoadingHoldSales.value,
                                      isErrorCondition: itemdetailController
                                          .isErrorHoldSales.value,
                                      isSucessCondition: itemdetailController
                                          .isHoldSalesSuccess.value,
                                      error: itemdetailController.errorHoldSales.value,
                                      onTapOfYes: (value) {
                                    itemdetailController.toggleHoldSales(
                                        value, context);
                                  }, errorMessage: homeController.isScreenRightAvailable(screenId: TransactionScreenId.itemDetails, type: ScreenRightOptions.Edit) == false ? "User have no edit rights to this screen" : 'Cant hold items with stock', isEdit: homeController.isScreenRightAvailable(screenId: TransactionScreenId.itemDetails, type: ScreenRightOptions.Edit) && itemdetailController.productLocationList.fold(0.0, (previousValue, element) => previousValue + element.quantity) <= 0)),
                              Obx(() => _actionsbuildRows(context,
                                      title: 'Inactive',
                                      value: itemdetailController
                                          .inactiveToggle.value,
                                      alertTextCondition: itemdetailController
                                          .inactiveToggle.value,
                                      alertTextConditionOne:
                                          'Do you want to go active?',
                                      alertTextConditionTwo:
                                          'Do you want to go inactive?',
                                      visiblityCondition: itemdetailController
                                          .inactiveToggle.value,
                                      indicatorCondition: itemdetailController
                                          .isLoadingInactive.value,
                                      isErrorCondition: itemdetailController
                                          .isErrorInactive.value,
                                      isSucessCondition: itemdetailController
                                          .isInactiveSuccess.value,
                                      error: itemdetailController.errorInactive.value,
                                      onTapOfYes: (value) {
                                    itemdetailController.toggleInactive(
                                        value, context);
                                  },
                                      isEdit: homeController.isScreenRightAvailable(
                                          screenId: TransactionScreenId.itemDetails,
                                          type: ScreenRightOptions.Edit))),
                              Obx(() => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Refresh',
                                            style: TextStyle(
                                                color: AppColors.mutedColor,
                                                fontSize: 12)),
                                        !itemdetailController.isRefreshing.value
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.sync,
                                                  color: AppColors.primary,
                                                ),
                                                onPressed: () async {
                                                  bool hasInternet =
                                                      await InternetConnectionChecker()
                                                          .hasConnection;
                                                  hasInternet
                                                      ? itemdetailController
                                                              .itemCodeController
                                                              .value
                                                              .text
                                                              .isEmpty
                                                          ? SnackbarServices
                                                              .errorSnackbar(
                                                                  'No Item Selected')
                                                          : itemdetailController
                                                              .getProductDetails(
                                                                  context)
                                                      : SnackbarServices
                                                          .internetSnackbar();
                                                })
                                            : IconButton(
                                                onPressed: () {},
                                                icon: const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            AppColors.primary),
                                                  ),
                                                ),
                                              ),
                                      ])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
              // : IconButton(
              //     onPressed: () {},
              //     icon: const SizedBox(
              //       width: 20,
              //       height: 20,
              //       child: CircularProgressIndicator(
              //         strokeWidth: 2.5,
              //         valueColor: AlwaysStoppedAnimation(Colors.white),
              //       ),
              //     ),
              //   ),
              //  ),
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ItemPickerScreen());
                  // CommonWidgets.commonDialog(context, '', ItemPickerScreen());
                },
                child: SizedBox(
                  height: height / 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          itemdetailController
                                  .itemCodeController.value.text.isNotEmpty
                              ? itemdetailController
                                  .itemCodeController.value.text
                              : itemdetailController.scanItem.value,
                          style:
                              TextStyle(color: AppColors.primary, fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.qr_code_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.white24,
              ),
              SizedBox(
                height: 10,
              ),
              CommonWidgets.textField(context,
                  suffixicon: false,
                  readonly: true,
                  keyboardtype: TextInputType.text,
                  controller: itemdetailController.classController.value,
                  label: "Class", ontap: () async {
                await itemdetailController.clearValues();
                await itemdetailController.clearTotalQuantity();
                await CommonWidgets.commonDialog(context, "Item Class",
                    GetBuilder<ItemDetailController>(
                  builder: (_) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String classitem = _.classList[index];
                        return InkWell(
                          onTap: () {
                            if (_.classList[index] == "Set to default") {
                              itemdetailController.isSelectedClass.value =
                                  false;
                              itemdetailController.classController.value
                                  .clear();
                              ;
                              Navigator.pop(context);
                            } else {
                              itemdetailController.isSelectedClass.value = true;
                              itemdetailController.classController.value.text =
                                  _.classList[index];
                              Navigator.pop(context);
                            }
                          },
                          child: ListTile(
                            // dense: true,
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(classitem,
                                style: TextStyle(fontFamily: 'Rubik')),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: height * 0.03,
                      ),
                      itemCount: _.classList.length,
                    );
                  },
                ));
              }),
              SizedBox(
                height: 10,
              ),
              CommonWidgets.textField(context,
                  suffixicon: false,
                  readonly: true,
                  keyboardtype: TextInputType.text,
                  label: "Category",
                  controller: itemdetailController.categoryController.value,
                  ontap: () async {
                await itemdetailController.clearValues();
                await itemdetailController.clearValues();
                await CommonWidgets.commonDialog(context, "Item Category",
                    GetBuilder<ItemDetailController>(
                  builder: (_) {
                    return ListView.separated(
                      shrinkWrap: true,
                      // physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        String category = _.categoryList[index];
                        return InkWell(
                          onTap: () {
                            if (_.classList[index] == "Set to default") {
                              itemdetailController.isSelectedCategory.value =
                                  false;
                              itemdetailController.categoryController.value
                                  .clear();

                              Navigator.pop(context);
                            } else {
                              itemdetailController.isSelectedCategory.value =
                                  true;
                              itemdetailController.categoryController.value
                                  .text = _.categoryList[index];
                              Navigator.pop(context);
                            }
                          },
                          child: ListTile(
                            minVerticalPadding: 0,
                            // dense: true,

                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(category.toString(),
                                style: TextStyle(fontFamily: 'Rubik')),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: _.categoryList.length,
                    );
                  },
                ));
              }),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(
                      context,
                      suffixicon: false,
                      readonly: false,
                      keyboardtype: TextInputType.text,
                      controller: itemdetailController.itemCodeController.value,
                      label: "Item Code",
                    ),
                  ),
                  //SizedBox(width: 5,),
                  InkWell(
                    onTap: () {
                      Get.to(() => ItemDetailItemListScreen());
                      itemdetailController.getProductList();
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CommonWidgets.textField(
                context,
                suffixicon: false,
                readonly: true,
                keyboardtype: TextInputType.text,
                label: "Item Name",
                controller: itemdetailController.itemNameController.value,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Obx(
                    () => Flexible(
                      child: CommonWidgets.textField(context,
                          suffixicon: true,
                          readonly: true,
                          keyboardtype: TextInputType.text,
                          label: "Select Unit",
                          controller: TextEditingController(
                            text:
                                (itemdetailController.selectedUnit.value.name ??
                                        "")
                                    .toUpperCase(),
                          ),
                          // itemdetailController
                          //     .selectUnitController.value,
                          ontap: () {
                        CommonWidgets.commonDialog(
                            context, "Select Unit", _selectUnitPop(context));
                      }),

                      // ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => Flexible(
                      child: CommonWidgets.textField(context,
                          suffixicon: true,
                          icon: Icons.info_outline,
                          readonly: true,
                          keyboardtype: TextInputType.text,
                          label: "Stock", ontap: () {
                        CommonWidgets.commonDialog(
                          context,
                          "Stock Unit :${itemdetailController.selectedUnit.value.name}",
                          _stockPopUp(context),
                        );
                      },
                          controller: TextEditingController(
                            text: InventoryCalculations.getStockPerFactor(
                                factorType: itemdetailController
                                        .selectedUnit.value.factorType ??
                                    'M',
                                factor: double.parse(itemdetailController
                                        .selectedUnit.value.factor ??
                                    '1.0'),
                                stock: itemdetailController.productLocationList
                                    .fold(
                                        0.0,
                                        (previousValue, element) =>
                                            previousValue +
                                            element.quantity)).toString(),
                          )
                          //itemdetailController.stockController.value
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: true,
                                  keyboardtype: TextInputType.number,
                                  label: "Price 1",
                                  controller: itemdetailController
                                      .price1Controller.value),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: true,
                                  keyboardtype: TextInputType.number,
                                  label: "Price 2",
                                  controller: itemdetailController
                                      .price2Controller.value),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: true,
                                  keyboardtype: TextInputType.number,
                                  label: "Minimum Price",
                                  controller: itemdetailController
                                      .minimumpriceController.value),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: true,
                                  keyboardtype: TextInputType.number,
                                  label: "Special price",
                                  controller: itemdetailController
                                      .specialpriceController.value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommonWidgets.textField(context,
                            suffixicon: false,
                            readonly: true,
                            keyboardtype: TextInputType.text,
                            label: "Size",
                            controller:
                                itemdetailController.sizeController.value),
                      ],
                    ),
                  ),
                  Obx(() {
                    Uint8List bytes = Base64Codec()
                        .decode(itemdetailController.productImage.value);
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          CommonWidgets.commonDialog(
                            context,
                            itemdetailController.itemname.value,
                            Container(
                              height: width * 0.6,
                              width: width * 0.1,
                              decoration: BoxDecoration(
                                color:
                                    itemdetailController.productImage.value ==
                                            ''
                                        ? textFieldColor
                                        : Colors.white,
                                image:
                                    itemdetailController.productImage.value ==
                                            ''
                                        ? DecorationImage(
                                            image: AssetImage(
                                              Images.placeholder,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: MemoryImage(bytes, scale: 1),
                                            fit: BoxFit.contain,
                                          ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: mutedColor,
                                  width: 0.1,
                                ),
                              ),
                            ),
                            // actions: [
                            //   CommonWidgets.elevatedButton(context,
                            //       onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //       type: ButtonTypes.Primary,
                            //       isLoading: false,
                            //       text: 'Close'),
                            // ]
                          );
                        },
                        child: Container(
                          height: width * 0.3,
                          width: width * 0.43,
                          decoration: BoxDecoration(
                            color: itemdetailController.productImage.value == ''
                                ? textFieldColor
                                : Colors.white,
                            image: itemdetailController.productImage.value == ''
                                ? DecorationImage(
                                    image: AssetImage(
                                      Images.placeholder,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: MemoryImage(bytes, scale: 1),
                                    fit: BoxFit.contain,
                                  ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: mutedColor,
                              width: 0.1,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Origin",
                        controller:
                            itemdetailController.originController.value),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Brand",
                        controller: itemdetailController.brandController.value),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Manufacturer",
                        controller:
                            itemdetailController.manufacturerController.value),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Style",
                        controller: itemdetailController.styleController.value),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Reorder Level",
                        controller:
                            itemdetailController.reorderLevelController.value),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.text,
                        label: "Bin",
                        controller: itemdetailController.binController.value),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: height / 16,
                width: width,
                child: CommonWidgets.elevatedButton(
                  context,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  type: ButtonTypes.Primary,
                  text: "Close",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _selectUnitPop(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: GetBuilder<ItemDetailController>(builder: (_) {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                Unitmodel item = _.productUnitList[index];
                return ListTile(
                  minVerticalPadding: 0,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(
                    item.name.toString().toUpperCase(),
                  ),
                  onTap: () {
                    itemdetailController.selectUnit(item);

                    Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemCount: _.productUnitList.length,
            );
          }),
        ),
      ],
    );
  }

  Column _stockPopUp(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: _buildRows(context,
                code: 'Code', name: 'Location', stock: 'Stock', isHeader: true),
          ),
        ),
        SizedBox(height: 10),
        Visibility(
          visible: itemdetailController.productLocationList.isNotEmpty,
          child: Flexible(
            child: SizedBox(
              child: GetBuilder<ItemDetailController>(builder: (_) {
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    Productlocationmodel item = _.productLocationList[index];
                    return _buildRows(context,
                        code: '${item.locationId}',
                        name: '${item.locationName}',
                        stock: '${InventoryCalculations.getStockPerFactor(
                          factorType: itemdetailController
                                  .selectedUnit.value.factorType ??
                              'M',
                          factor: double.parse(
                              itemdetailController.selectedUnit.value.factor ??
                                  '1.0'),
                          stock: item.quantity,
                        )
                            // item.quantity
                            }',
                        isHeader: false);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    );
                  },
                  itemCount: _.productLocationList.length,
                );
              }),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                "Total Stock:",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GetBuilder<ItemDetailController>(
                builder: (_) {
                  return Obx(
                    () => Text(
                      InventoryCalculations.getStockPerFactor(
                          factorType: itemdetailController
                                  .selectedUnit.value.factorType ??
                              'M',
                          factor: double.parse(
                              itemdetailController.selectedUnit.value.factor ??
                                  '1.0'),
                          stock: itemdetailController.productLocationList.fold(
                              0.0,
                              (previousValue, element) =>
                                  previousValue + element.quantity)).toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildRows(
    BuildContext context, {
    required String code,
    required String name,
    required String stock,
    required bool isHeader,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
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
        Expanded(
          flex: 2,
          child: Text(
            stock,
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

  Row _actionsbuildRows(BuildContext context,
      {required String title,
      required bool value,
      required bool alertTextCondition,
      required String alertTextConditionOne,
      required String alertTextConditionTwo,
      required bool visiblityCondition,
      required bool indicatorCondition,
      required bool isErrorCondition,
      required bool isSucessCondition,
      required ValueCallback<bool> onTapOfYes,
      required String error,
      bool isEdit = true,
      String errorMessage = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(color: AppColors.mutedColor, fontSize: 12)),
        Row(
          children: [
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: value,
                onChanged: (value) async {
                  if (isEdit) {
                    final isConfirm = await showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: new Text('Are you sure?',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        content: alertTextCondition
                            ? new Text(alertTextConditionOne)
                            : new Text(alertTextConditionTwo),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        actions: <Widget>[
                          InkWell(
                              onTap: () => Navigator.of(context).pop(false),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontWeight: FontWeight.bold)),
                              )),
                          InkWell(
                              onTap: () async {
                                Navigator.of(context).pop(true);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Yes',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    );
                    if (isConfirm) {
                      bool hasInternet =
                          await InternetConnectionChecker().hasConnection;
                      hasInternet
                          ? itemdetailController
                                  .itemCodeController.value.text.isEmpty
                              ? SnackbarServices.errorSnackbar(
                                  'No Item Selected')
                              : onTapOfYes(value)
                          // title == 'Hold Sales'
                          //     ? itemdetailController
                          //     .toggleHoldSales(value, context)
                          //     : itemdetailController.toggleInactive(
                          //     value, context)
                          : SnackbarServices.internetSnackbar();
                    }
                  } else {
                    SnackbarServices.errorSnackbar(errorMessage);
                  }
                },
              ),
            ),
            Visibility(
              visible: visiblityCondition,
              child: indicatorCondition
                  ? Row(
                      children: [
                        SizedBox(
                          height: 19,
                          width: 19,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        )
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        if (isErrorCondition)
                          SnackbarServices.errorSnackbar(
                              itemdetailController.errorHoldSales.value);
                      },
                      child: SvgPicture.asset(
                        isSucessCondition == true && isErrorCondition == false
                            ? AppIcons.check
                            : AppIcons.cancel,
                        color: isSucessCondition == true &&
                                isErrorCondition == false
                            ? AppColors.darkGreen
                            : AppColors.darkRed,
                        width: 20,
                        height: 20,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
