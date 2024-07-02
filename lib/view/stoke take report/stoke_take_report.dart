import 'package:axolon_inventory_manager/controller/App%20Controls/sync_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/stock_snapshot_local_controller.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_header_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTakeReport extends StatelessWidget {
  StockTakeReport({super.key});

  final stockSnapshotLocalController = Get.put(StockSnapshotLocalController());
  final syncController = Get.put(SyncController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (stockSnapshotLocalController.stockSnapshotHeaders.isEmpty) {
        stockSnapshotLocalController.getStockSnapshotHeaders();
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stock Take Report"),
          actions: [
            IconButton(
                onPressed: () {
                  syncController.syncStockSnapshot();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: GetBuilder<StockSnapshotLocalController>(
          initState: (_) {},
          builder: (_) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  StockSnapshotHeaderModel item = _.stockSnapshotHeaders[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.sysdocid} - ${item.voucherid}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  _.deleteSnapshot(vouchetId: item.voucherid!);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          Text(
                            item.isSynced == 1 ? " Synced" : 'Not Synced',
                            style: TextStyle(
                                color: item.isSynced == 1
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            item.isError == 1 ? item.error.toString() : '',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: _.stockSnapshotHeaders.length);
          },
        ));
  }
}
