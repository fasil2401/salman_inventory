import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/item_creation_contoller.dart';

import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';

import 'package:axolon_inventory_manager/utils/constants/colors.dart';

import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class ItemCreationScreen extends StatelessWidget {
  final itemcreationController = Get.put(ItemCreationController());
  final homeController = Get.put(HomeController());
  var selectedItemcode;

  ItemCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Item Creation'),
        actions: [
          IconButton(
            onPressed: () async {
              await itemcreationController.getProductOpenList();
              CommonWidgets.commonDialog(
                  context, "", _buildOpenListPopContent(context));
            },
            icon: Obx(
              () => itemcreationController.isOpenListLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : SvgPicture.asset(
                      AppIcons.openList,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              CommonWidgets.textField(context,
                  suffixicon: false,
                  readonly: true,
                  label: "ItemCode",
                  controller: homeController.nextcardnumbercontrol,
                  keyboardtype: TextInputType.number),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  label: "Item Description",
                                  maxLines: 3,
                                  controller: itemcreationController
                                      .itemdescriptionController.value,
                                  keyboardtype: TextInputType.text),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  label: "Description",
                                  controller: itemcreationController
                                      .descriptionController.value,
                                  keyboardtype: TextInputType.text),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: GetBuilder<ItemCreationController>(
                        builder: (controller) {
                      return GestureDetector(
                        onTap: () async {
                          if (homeController.attachmentMethod.value ==
                              FileAttachmentOptions.Camera.value) {
                            itemcreationController.takePicture();
                          } else if (homeController.attachmentMethod.value ==
                              FileAttachmentOptions.Files.value) {
                            itemcreationController.selectFile();
                          } else {
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
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        title: Text("Camera"),
                                        onTap: () {
                                          homeController
                                                  .attachmentMethod.value =
                                              FileAttachmentOptions
                                                  .Camera.value;
                                          itemcreationController.takePicture();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.photo_library_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        title: Text("Files"),
                                        onTap: () async {
                                          homeController
                                                  .attachmentMethod.value =
                                              FileAttachmentOptions.Files.value;
                                          itemcreationController.selectFile();
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          height: width * 0.3,
                          width: width * 0.43,
                          decoration: BoxDecoration(
                            color: mutedColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: itemcreationController
                                          .result.value.files.isEmpty &&
                                      itemcreationController
                                          .productImage.value.isEmpty
                                  ? textFieldColor
                                  : Colors.white,
                              width: 0.1,
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              // color: mutedColor.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: mutedColor,
                                width: 0.1,
                              ),
                            ),
                            child:
                                itemcreationController
                                            .result.value.files.isEmpty &&
                                        itemcreationController
                                            .productImage.value.isEmpty
                                    ? Image.asset(
                                        Images.placeholder,
                                      )
                                    : Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child:
                                                  // GridView.builder(
                                                  //     gridDelegate:
                                                  //         SliverGridDelegateWithFixedCrossAxisCount(
                                                  //             crossAxisCount: 4,
                                                  //             crossAxisSpacing: 12,
                                                  //             mainAxisSpacing: 8),
                                                  //     itemCount: controller
                                                  //         .result.value.files.length,
                                                  //     itemBuilder:
                                                  //         (BuildContext ctx, index) {
                                                  //       log("${controller.result.value.files[index].bytes == null}");
                                                  //       // if(){
                                                  //       // Uint8List bytes =
                                                  //       //     Base64Codec().decode(
                                                  //       //         controller
                                                  //       //             .productImage
                                                  //       //             .value[index]);
                                                  //       // }
                                                  // return
                                                  InkWell(
                                                onTap: () {
                                                  // controller.removeFile(index);
                                                  _buildPreview(
                                                      context, controller, 0);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         1),
                                                    image: controller
                                                            .productImage
                                                            .isNotEmpty
                                                        ? DecorationImage(
                                                            image: MemoryImage(
                                                                Base64Codec().decode(
                                                                    controller
                                                                        .productImage
                                                                        .value),
                                                                scale: 1),
                                                            fit: BoxFit.contain,
                                                          )
                                                        : DecorationImage(
                                                            image: FileImage(
                                                                File(controller
                                                                    .result
                                                                    .value
                                                                    .files[0]
                                                                    .path!)),
                                                            fit: BoxFit.contain,
                                                          ),
                                                  ),
                                                  // child: Image(
                                                  //     image: FileImage(File(
                                                  //         controller
                                                  //             .result
                                                  //             .value
                                                  //             .files[0]
                                                  //             .path!)))
                                                ),
                                              ),
                                              // }),
                                            ),
                                          ),
                                          Visibility(
                                            visible: itemcreationController
                                                    .result
                                                    .value
                                                    .files
                                                    .isNotEmpty ||
                                                itemcreationController
                                                    .productImage.isNotEmpty,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.2),
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (homeController
                                                              .attachmentMethod
                                                              .value ==
                                                          FileAttachmentOptions
                                                              .Camera.value) {
                                                        itemcreationController
                                                            .takePicture();
                                                      } else if (homeController
                                                              .attachmentMethod
                                                              .value ==
                                                          FileAttachmentOptions
                                                              .Files.value) {
                                                        itemcreationController
                                                            .selectFile();
                                                      } else {
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
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  ListTile(
                                                                    leading:
                                                                        Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                    title: Text(
                                                                        "Camera"),
                                                                    onTap: () {
                                                                      homeController
                                                                              .attachmentMethod
                                                                              .value =
                                                                          FileAttachmentOptions
                                                                              .Camera
                                                                              .value;
                                                                      itemcreationController
                                                                          .takePicture();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  ListTile(
                                                                    leading:
                                                                        Icon(
                                                                      Icons
                                                                          .photo_library_outlined,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                    title: Text(
                                                                        "Files"),
                                                                    onTap:
                                                                        () async {
                                                                      homeController
                                                                              .attachmentMethod
                                                                              .value =
                                                                          FileAttachmentOptions
                                                                              .Files
                                                                              .value;
                                                                      itemcreationController
                                                                          .selectFile();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .photo_camera_back_outlined,
                                                      color: mutedColor,
                                                    )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              CommonWidgets.textField(context,
                  suffixicon: false,
                  readonly: false,
                  label: "Alias",
                  controller: itemcreationController.aliasController.value,
                  keyboardtype: TextInputType.text),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Item Type", ontap: () async {
                      await CommonWidgets.commonDialog(
                          context,
                          "Item Type",
                          ItemTypeContent(
                            context: context,
                          ));
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.itemtypeController.value,
                        keyboardtype: TextInputType.number),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Track Lot",
                    style: TextStyle(color: AppColors.primary),
                  ),
                  Obx(() => Checkbox(
                        activeColor: AppColors.primary,
                        value: itemcreationController.isTrackLot.value,
                        onChanged: (value) {
                          itemcreationController.isTrackLot.value =
                              !itemcreationController.isTrackLot.value;
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Tax Option", ontap: () async {
                      await CommonWidgets.commonDialog(
                          context,
                          "Tax Option",
                          taxOptionContent(
                            context: context,
                          ));
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.taxOptionController.value,
                        keyboardtype: TextInputType.number),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: itemcreationController.selectedtaxoption == 1,
                    child: Expanded(
                      child: CommonWidgets.textField(context,
                          suffixicon: true,
                          isEnabled:
                              itemcreationController.selectedtaxoption == 1,
                          readonly: true,
                          label: "Tax Group Id", ontap: () async {
                        await itemcreationController.getTaxGroupIdList();
                        commonPopUpList(
                            context: context,
                            label: "Tax Group Id",
                            code: false,
                            list: itemcreationController.taxGroupIdList,
                            textController: itemcreationController
                                .taxgroupidController.value);
                      },
                          icon: Icons.arrow_drop_down_circle_outlined,
                          controller:
                              itemcreationController.taxgroupidController.value,
                          keyboardtype: TextInputType.number),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Item Class", ontap: () async {
                      await itemcreationController.getClassList();
                      commonPopUpList(
                          context: context,
                          label: "Class",
                          code: false,
                          list: itemcreationController.classList,
                          textController:
                              itemcreationController.itemclassController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.itemclassController.value,
                        keyboardtype: TextInputType.number),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Origin", ontap: () async {
                      await itemcreationController.getOriginList();

                      commonPopUpList(
                          context: context,
                          label: "Origin",
                          code: false,
                          list: itemcreationController.originList,
                          textController:
                              itemcreationController.originController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.originController.value,
                        keyboardtype: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Category", ontap: () async {
                      await itemcreationController.getCategoryList();
                      commonPopUpList(
                          context: context,
                          code: false,
                          label: "Category",
                          list: itemcreationController.categoryList,
                          textController:
                              itemcreationController.categoryController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.categoryController.value,
                        keyboardtype: TextInputType.number),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Brand", ontap: () async {
                      await itemcreationController.getBrandList();
                      commonPopUpList(
                          context: context,
                          code: false,
                          label: "Brand",
                          list: itemcreationController.brandList,
                          textController:
                              itemcreationController.brandController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.brandController.value,
                        keyboardtype: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Manufacture", ontap: () async {
                      await itemcreationController.getProductManufactureList();
                      commonPopUpList(
                          context: context,
                          label: "Manufacture",
                          code: true,
                          list: itemcreationController.manufactureList,
                          textController: itemcreationController
                              .manufacturerController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.manufacturerController.value,
                        keyboardtype: TextInputType.number),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Style", ontap: () async {
                      await itemcreationController.getStyleList(context);
                      commonPopUpList(
                          context: context,
                          code: false,
                          label: "Style",
                          list: itemcreationController.styleList,
                          textController:
                              itemcreationController.styleController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.styleController.value,
                        keyboardtype: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: true,
                        readonly: true,
                        label: "Main UOM", ontap: () async {
                      //await itemcreationController.getUnitList();
                      await itemcreationController.getUnitCombo();
                      commonPopUpList(
                          code: true,
                          context: context,
                          label: "Main UOM",
                          list: itemcreationController.unitComboList
                          //itemcreationController.filterunitList
                          ,
                          textController:
                              itemcreationController.mainUomController.value);
                    },
                        icon: Icons.arrow_drop_down_circle_outlined,
                        controller:
                            itemcreationController.mainUomController.value,
                        keyboardtype: TextInputType.text),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CommonWidgets.textField(context,
                        suffixicon: false,
                        readonly: false,
                        label: "UPC",
                        controller: itemcreationController.upcController.value,
                        keyboardtype: TextInputType.text),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CommonWidgets.elevatedButton(context, onTap: () async {
                itemcreationController.clearData();
              }, type: ButtonTypes.Secondary, text: 'Clear', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(() => Expanded(
                  child: CommonWidgets.elevatedButton(context, onTap: () {
                    if (itemcreationController.validation()) {
                      itemcreationController.createItem();
                      //itemcreationController.clearData();
                    }
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading: itemcreationController.isSaving.value),
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  commonPopUpList(
      {required BuildContext context,
      required String label,
      required List list,
      required bool code,
      required TextEditingController textController}) {
    itemcreationController.filterList.value = list;
    return CommonWidgets.commonDialog(
        context,
        label,
        Column(mainAxisSize: MainAxisSize.min, children: [
          CommonWidgets.textField(
            context,
            suffixicon: false,
            readonly: false,
            keyboardtype: TextInputType.text,
            label: "Search",
            onchanged: (element) =>
                itemcreationController.commonFilter(element, list),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(child: GetBuilder<ItemCreationController>(builder: (_) {
            return _.isLoading.value
                ? CommonWidgets.popShimmer()
                : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = itemcreationController.filterList[index];
                      return InkWell(
                        onTap: () {
                          textController.text = "${item.code}";
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AutoSizeText(
                            code == false
                                ? "${item.code ?? ''} - ${item.name ?? ''}"
                                : "${item.code ?? ''}",
                            minFontSize: 11,
                            maxFontSize: 13,
                            style: TextStyle(
                              color: mutedColor,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                    itemCount: itemcreationController.filterList.length,
                  );
          }))
        ]));
  }

  taxOptionContent({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textField(
          context,
          suffixicon: false,
          readonly: false,
          keyboardtype: TextInputType.text,
          label: "Search",
          onchanged: (element) =>
              itemcreationController.filterTaxOptionList(element),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(child: GetBuilder<ItemCreationController>(builder: (_) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            shrinkWrap: true,
            itemCount: itemcreationController.filtertaxOptionList.length,
            itemBuilder: (context, index) {
              var item = itemcreationController.filtertaxOptionList[index];
              return InkWell(
                  onTap: () {
                    itemcreationController.selectedtaxoption = item.value;
                    itemcreationController.taxOptionController.value.text =
                        "${item.name}";
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: AutoSizeText(
                      item.name,
                      minFontSize: 11,
                      maxFontSize: 13,
                      style: TextStyle(
                        color: mutedColor,
                      ),
                    ),
                  ));
            },
          );
        })),
      ],
    );
  }

  ItemTypeContent({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textField(
          context,
          suffixicon: false,
          readonly: false,
          keyboardtype: TextInputType.text,
          label: "Search",
          onchanged: (element) =>
              itemcreationController.filterItemtypeList(element),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(child: GetBuilder<ItemCreationController>(builder: (_) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            shrinkWrap: true,
            itemCount: itemcreationController.filterItemTypeList.length,
            itemBuilder: (context, index) {
              var item = itemcreationController.filterItemTypeList[index];
              return InkWell(
                  onTap: () {
                    itemcreationController.selectedItemType = item.value;
                    itemcreationController.itemtypeController.value.text =
                        "${item.name}";
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: AutoSizeText(
                      item.name,
                      minFontSize: 11,
                      maxFontSize: 13,
                      style: TextStyle(
                        color: mutedColor,
                      ),
                    ),
                  ));
            },
          );
        })),
      ],
    );
  }

  Column _buildOpenListHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => CommonWidgets.commonDateFilter(
                context,
                itemcreationController.dateIndex.value,
                itemcreationController.isToDate.value,
                itemcreationController.isFromDate.value,
                itemcreationController.fromDate.value,
                itemcreationController.toDate.value, (value) {
              selectedItemcode = value;
              itemcreationController.selectDateRange(selectedItemcode.value,
                  DateRangeSelector.dateRange.indexOf(selectedItemcode));
            },
                () => itemcreationController.selectDate(
                    context, itemcreationController.isFromDate.value))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              itemcreationController.getProductOpenList();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _buildOpenListPopContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
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
                itemcreationController.searchProduct(value);
              },
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => itemcreationController.isOpenListLoading.value
                    ? CommonWidgets.popShimmer()
                    : itemcreationController.filterProductList.isEmpty
                        ? Center(
                            child: Text('No Data Found'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                itemcreationController.filterProductList.length,
                            itemBuilder: (context, index) {
                              var item = itemcreationController
                                  .filterProductList[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: InkWell(
                                  splashColor: mutedColor.withOpacity(0.2),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () async {
                                    itemcreationController.getProductDetails(
                                        item.productId ?? "");
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              '${item.productId}',
                                              minFontSize: 12,
                                              maxFontSize: 18,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildTileRow(
                                            title: "Description",
                                            content:
                                                " ${item.description ?? ""}"),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Brand",
                                            content: item.brand ?? ""),
                                        SizedBox(height: 5),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Category",
                                            content: item.category ?? ""),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildPreview(BuildContext context,
      ItemCreationController controller, int index) async {
    Uint8List bytes = Uint8List(0);
    if (controller.productImage.isEmpty) {
      if (controller.result.value.files[index].bytes != null) {
        bytes = await controller.result.value.files[index].bytes!;
      } else {
        File file = File(controller.result.value.files[index]
            .path!); // Create a Dart File from the PlatformFile
        bytes = await file.readAsBytes();
      }
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            content: Container(
              // height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: LimitedBox(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  child: controller.productImage.isEmpty
                      ? Image(
                          fit: BoxFit.contain,
                          image: FileImage(
                              File(controller.result.value.files[index].path!)))
                      : Image(
                          fit: BoxFit.fill,
                          image: MemoryImage(Base64Codec()
                              .decode(controller.productImage.value)),
                        )),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: CommonWidgets.elevatedButton(context, onTap: () {
                  itemcreationController.removeFile(index);
                  Navigator.pop(context);
                }, type: ButtonTypes.Secondary, text: 'Delete'),
              )
            ],
          );
        });
  }

  Row _buildTileRow({required String title, required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '$title : ',
          minFontSize: 8,
          maxFontSize: 12,
          style: const TextStyle(
            color: mutedColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            content,
            minFontSize: 10,
            maxFontSize: 12,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
