import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/draft_list_controller.dart';
import 'package:axolon_inventory_manager/model/draft_items_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final draftListController = Get.put(DraftListController());

  @override
  void initState() {
    super.initState();
    draftListController.getDraftItemList(option: DraftItemOption.StockTake);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DraftListController>(
        builder: (_) {
          return ListView.builder(
              itemCount: _.draftItemList.length,
              itemBuilder: (context, index) {
                DraftItemListModel item = _.draftItemList[index];
                return ListTile(
                  title: Text(item.description ?? ''),
                  subtitle: Text(item.updatedQuatity.toString()),
                  leading: Text(item.updatedUnitId.toString()),
                );
              });
        },
      ),
    );
  }
}
