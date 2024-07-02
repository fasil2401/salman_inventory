import 'dart:developer';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/loading_sheet_local_model.dart';
import 'package:axolon_inventory_manager/model/Out%20Transfer%20Model/create_transfer_out_local_model.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/grn_local_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_header_model.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_take_save_detail_model.dart';
import 'package:axolon_inventory_manager/model/get_tax_group_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_location_model.dart';
import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/model/draft_items_model.dart';
import 'package:axolon_inventory_manager/model/get_customer_list_model.dart';
import 'package:axolon_inventory_manager/model/get_user_security_model.dart';
import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/Db%20Helper/query_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  final _databaseName = 'inventory.db';
  final _databaseVersion = 42;
  final _newVersion = 43;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _newVersion,
        onCreate: (db, version) => _onCreate(db),
        onUpgrade: _onUpgrade);
  }

  getDatabaseApplicationPath() async {
    Directory? applicationPath = await getApplicationDocumentsDirectory();
    return applicationPath.path;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      for (int i = 0; i < (newVersion - oldVersion); i++) {
        try {
          await db.execute(QuerryTable.dbUpgradeQueryTable[i]);
        } catch (e) {
          continue;
        }
      }
    }
  }

  _onCreate(Database db) async {
    for (int i = 0; i < QuerryTable.dbQueryTable.length; i++) {
      try {
        await db.execute(QuerryTable.dbQueryTable[i]);
      } catch (e) {
        dev.log(e.toString());
        continue;
      }
    }
  }

  Future<int> updateOutTransferHeader(
      String voucherId, CreateTransferOutLocalModel header) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${CreateTransferOutImportantNames.tableName}
      SET ${CreateTransferOutImportantNames.sysDocId} = ?,
          ${CreateTransferOutImportantNames.voucherId} = ?,
          ${CreateTransferOutImportantNames.transferTypeId} = ?,
          ${CreateTransferOutImportantNames.acceptReference} = ?,
          ${CreateTransferOutImportantNames.transactionDate} = ?,
          ${CreateTransferOutImportantNames.divisionId} = ?,
          ${CreateTransferOutImportantNames.locationFromId} = ?,
          ${CreateTransferOutImportantNames.locationToId} = ?,
          ${CreateTransferOutImportantNames.vehicleNumber} = ?,
          ${CreateTransferOutImportantNames.driverId} = ?,
          ${CreateTransferOutImportantNames.reference} = ?,
          ${CreateTransferOutImportantNames.description} = ?,
          ${CreateTransferOutImportantNames.reason} = ?,
          ${CreateTransferOutImportantNames.isRejectedTransfer} = ?,
          ${CreateTransferOutImportantNames.isSynced} = ?,
          ${CreateTransferOutImportantNames.error} = ?, 
          ${CreateTransferOutImportantNames.quantity} = ?,
          ${CreateTransferOutImportantNames.isError} = ?
      WHERE ${CreateTransferOutImportantNames.voucherId} = ?
      ''', [
      header.sysDocId,
      header.voucherId,
      header.transferTypeId,
      header.acceptReference,
      header.transactionDate,
      header.divisionId,
      header.locationFromId,
      header.locationToId,
      header.vehicleNumber,
      header.driverId,
      header.reference,
      header.description,
      header.reason,
      header.isRejectedTransfer,
      header.isSynced,
      header.error,
      header.quantity,
      header.isError,
      voucherId
    ]);
  }

  insertProductList(List<ProductListModel> products) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var product in products) {
        batch.insert(ProductListModelName.tableName, {
          ProductListModelName.taxOption: product.taxOption,
          ProductListModelName.origin: product.origin,
          ProductListModelName.productId: product.productId,
          ProductListModelName.productimage: product.productimage,
          ProductListModelName.isTrackLot: product.isTrackLot,
          ProductListModelName.upc: product.upc,
          ProductListModelName.unitId: product.unitId,
          ProductListModelName.taxGroupId: product.taxGroupId,
          ProductListModelName.locationId: product.locationId,
          ProductListModelName.quantity: product.quantity,
          ProductListModelName.specialPrice: product.specialPrice,
          ProductListModelName.price1: product.price1,
          ProductListModelName.price2: product.price2,
          ProductListModelName.size: product.size,
          ProductListModelName.rackBin: product.rackBin,
          ProductListModelName.description: product.description,
          ProductListModelName.reorderLevel: product.reorderLevel,
          ProductListModelName.minPrice: product.minPrice,
          ProductListModelName.category: product.category,
          ProductListModelName.style: product.style,
          ProductListModelName.modelClass: product.modelClass,
          ProductListModelName.brand: product.brand,
          ProductListModelName.age: product.age,
          ProductListModelName.manufacturer: product.manufacturer,
          ProductListModelName.isHold: 0,
          ProductListModelName.isInactive: 0,
        });
      }
      await batch.commit();
    });
  }

  Future<int> insertProduct(ProductListModel product) async {
    Database? db = await DBHelper._database;
    return await db!.insert(ProductListModelName.tableName, {
      ProductListModelName.taxOption: product.taxOption,
      ProductListModelName.origin: product.origin,
      ProductListModelName.productId: product.productId,
      ProductListModelName.productimage: product.productimage,
      ProductListModelName.isTrackLot: product.isTrackLot,
      ProductListModelName.upc: product.upc,
      ProductListModelName.unitId: product.unitId,
      ProductListModelName.taxGroupId: product.taxGroupId,
      ProductListModelName.locationId: product.locationId,
      ProductListModelName.quantity: product.quantity,
      ProductListModelName.specialPrice: product.specialPrice,
      ProductListModelName.price1: product.price1,
      ProductListModelName.price2: product.price2,
      ProductListModelName.size: product.size,
      ProductListModelName.rackBin: product.rackBin,
      ProductListModelName.description: product.description,
      ProductListModelName.reorderLevel: product.reorderLevel,
      ProductListModelName.minPrice: product.minPrice,
      ProductListModelName.category: product.category,
      ProductListModelName.style: product.style,
      ProductListModelName.modelClass: product.modelClass,
      ProductListModelName.brand: product.brand,
      ProductListModelName.age: product.age,
      ProductListModelName.manufacturer: product.manufacturer,
      ProductListModelName.isHold: 0,
      ProductListModelName.isInactive: 0,
    });
  }

  insertUserLocationList(List<UserLocationModel> userlocations) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var userlocation in userlocations) {
        batch.insert(UserLocationModelName.tableName, {
          UserLocationModelName.code: userlocation.code,
          UserLocationModelName.name: userlocation.name,
          UserLocationModelName.isConsignOutLocation: 0,
          UserLocationModelName.isConsignInLocation: 0,
          UserLocationModelName.isposLocation: 0,
          UserLocationModelName.isWarehouse: 0,
          UserLocationModelName.isQuarantine: 0,
          UserLocationModelName.isUserLocation: userlocation.isUserLocation,
        });
      }
      await batch.commit();
    });
  }

  insertProductLocationList(List<Productlocationmodel> productLocations) async {
    print(productLocations);
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var productLocation in productLocations) {
        batch.insert(ProductlocationmodelName.tableName, {
          ProductlocationmodelName.locationId: productLocation.locationId,
          ProductlocationmodelName.productId: productLocation.productId,
          ProductlocationmodelName.quantity: productLocation.quantity,
        });
      }
      await batch.commit();
    });
  }

  insertUnitList(List<Unitmodel> units) async {
    print(units);
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var unit in units) {
        batch.insert(UnitmodelName.tableName, {
          UnitmodelName.code: unit.code,
          UnitmodelName.name: unit.name,
          UnitmodelName.productId: unit.productId,
          UnitmodelName.factorType: unit.factorType,
          UnitmodelName.factor: unit.factor,
          UnitmodelName.isMainUnit: unit.isMainUnit == true ? 1 : 0,
        });
      }
      await batch.commit();
    });
  }

  insertTransferTypeList(List<TransferTypeModel> transferTypes) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var transferType in transferTypes) {
        batch.insert(TransferTypeModelName.tableName, {
          TransferTypeModelName.code: transferType.code,
          TransferTypeModelName.name: transferType.name,
          TransferTypeModelName.accountId: transferType.accountId,
          TransferTypeModelName.locationId: transferType.locationId,
        });
      }
      await batch.commit();
    });
  }

  insertLocationList(List<LocationModel> locations) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var location in locations) {
        batch.insert(LocationModelName.tableName, {
          LocationModelName.code: location.code,
          LocationModelName.name: location.name,
        });
      }
      await batch.commit();
    });
  }

  insertOriginList(List<ProductCommonComboModel> origins) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var origin in origins) {
        batch.insert(ProductCommonComboModelName.originTableName, {
          ProductCommonComboModelName.code: origin.code,
          ProductCommonComboModelName.name: origin.name,
        });
      }
      await batch.commit();
    });
  }

  insertSalesPersonList(List<ProductCommonComboModel> salesPersons) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var salesPerson in salesPersons) {
        batch.insert(ProductCommonComboModelName.customerSalesPersonTableName, {
          ProductCommonComboModelName.code: salesPerson.code,
          ProductCommonComboModelName.name: salesPerson.name,
        });
      }
      await batch.commit();
    });
  }

  insertBrandList(List<ProductCommonComboModel> brands) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var brand in brands) {
        batch.insert(ProductCommonComboModelName.brandTableName, {
          ProductCommonComboModelName.code: brand.code,
          ProductCommonComboModelName.name: brand.name,
        });
      }
      await batch.commit();
    });
  }

  insertClassList(List<ProductCommonComboModel> classes) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var productClass in classes) {
        batch.insert(ProductCommonComboModelName.classTableName, {
          ProductCommonComboModelName.code: productClass.code,
          ProductCommonComboModelName.name: productClass.name,
        });
      }
      await batch.commit();
    });
  }

  insertCategoryList(List<ProductCommonComboModel> categorys) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var category in categorys) {
        batch.insert(ProductCommonComboModelName.categoryTableName, {
          ProductCommonComboModelName.code: category.code,
          ProductCommonComboModelName.name: category.name,
        });
      }
      await batch.commit();
    });
  }

  insertVendorList(List<VendorModel> vendors) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var vendor in vendors) {
        batch.insert(VendorModelImportantNames.tableName, vendor.toMap());
      }
      await batch.commit();
    });
  }

  insertVehicleList(List<ProductCommonComboModel> vehicles) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var vehicle in vehicles) {
        batch.insert(ProductCommonComboModelName.vehicleTableName, {
          ProductCommonComboModelName.code: vehicle.code,
          ProductCommonComboModelName.name: vehicle.name,
        });
      }
      await batch.commit();
    });
  }

  insertDriverList(List<ProductCommonComboModel> driver) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var driver in driver) {
        batch.insert(ProductCommonComboModelName.driverTableName, {
          ProductCommonComboModelName.code: driver.code,
          ProductCommonComboModelName.name: driver.name,
        });
      }
      await batch.commit();
    });
  }

  insertCustomerList(List<CustomerModel> customers) async {
    log("${customers.length} mmmmmmm");
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var customer in customers) {
        batch.insert(CustomerListImportantNames.tableName, customer.toMap());
      }
      await batch.commit();
    });
  }

  insertSysDocIdList(List<SysDocModel> sysdocs) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var sysdoc in sysdocs) {
        batch.insert(SystemDocumentName.tableName, {
          SystemDocumentName.code: sysdoc.code,
          SystemDocumentName.name: sysdoc.name,
          SystemDocumentName.sysDocType: sysdoc.sysDocType,
          SystemDocumentName.locationId: sysdoc.locationId,
          SystemDocumentName.printAfterSave: sysdoc.printAfterSave,
          SystemDocumentName.doPrint: sysdoc.doPrint,
          SystemDocumentName.printTemplateName: sysdoc.printTemplateName,
          SystemDocumentName.priceIncludeTax: sysdoc.priceIncludeTax,
          SystemDocumentName.divisionId: sysdoc.divisionId,
          SystemDocumentName.nextNumber: sysdoc.nextNumber,
          SystemDocumentName.lastNumber: sysdoc.lastNumber,
          SystemDocumentName.numberPrefix: sysdoc.numberPrefix,
        });
      }
      await batch.commit();
    });
  }

  Future<void> insertDefaultObjectList(List<DefaultsObj> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(DefaultsObjNames.tableName, {
          DefaultsObjNames.defaultSalespersonId: data.defaultSalespersonId,
          DefaultsObjNames.defaultInventoryLocationId:
              data.defaultInventoryLocationId,
          DefaultsObjNames.defaultTransactionLocationId:
              data.defaultTransactionLocationId,
          DefaultsObjNames.defaultTransactionRegisterId:
              data.defaultTransactionRegisterId,
          DefaultsObjNames.defaultCompanyDivisionId:
              data.defaultCompanyDivisionId,
        });
      }
      await batch.commit();
    });
  }

  Future<void> insertMenuSecurityObjectList(
      List<MenuSecurityObj> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(MenuSecurityObjNames.tableName, {
          MenuSecurityObjNames.menuId: data.menuId,
          MenuSecurityObjNames.subMenuId: data.subMenuId,
          MenuSecurityObjNames.dropDownId: data.dropDownId,
          MenuSecurityObjNames.enable: data.enable != null
              ? data.enable!
                  ? 1
                  : 0
              : null,
          MenuSecurityObjNames.visible: data.visible != null
              ? data.visible!
                  ? 1
                  : 0
              : null,
          MenuSecurityObjNames.userId: data.userId,
          MenuSecurityObjNames.groupId: data.groupId,
        });
      }
      await batch.commit();
    });
  }

  Future<void> insertScreenSecurityObjectList(
      List<ScreenSecurityObj> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(ScreenSecurityObjNames.tableName, {
          ScreenSecurityObjNames.screenId: data.screenId,
          ScreenSecurityObjNames.viewRight: data.viewRight != null
              ? data.viewRight!
                  ? 1
                  : 0
              : null,
          ScreenSecurityObjNames.newRight: data.newRight != null
              ? data.newRight!
                  ? 1
                  : 0
              : null,
          ScreenSecurityObjNames.editRight: data.editRight != null
              ? data.editRight!
                  ? 1
                  : 0
              : null,
          ScreenSecurityObjNames.deleteRight: data.deleteRight != null
              ? data.deleteRight!
                  ? 1
                  : 0
              : null,
          ScreenSecurityObjNames.userId: data.userId,
          ScreenSecurityObjNames.groupId: data.groupId,
        });
      }
      await batch.commit();
    });
  }

  Future<int> insertStockSnapshotHeader(StockSnapshotHeaderModel item) async {
    Database? db = await DBHelper._database;
    return await db!.insert(StockSnapshotHeaderModelNames.tableName, {
      StockSnapshotHeaderModelNames.sysdocid: item.sysdocid,
      StockSnapshotHeaderModelNames.voucherid: item.voucherid,
      StockSnapshotHeaderModelNames.companyid: item.companyid,
      StockSnapshotHeaderModelNames.divisionid: item.divisionid,
      StockSnapshotHeaderModelNames.locationid: item.locationid,
      StockSnapshotHeaderModelNames.adjustmenttype: item.adjustmenttype,
      StockSnapshotHeaderModelNames.refrence: item.refrence,
      StockSnapshotHeaderModelNames.description: item.description,
      StockSnapshotHeaderModelNames.isnewrecord: item.isnewrecord,
      StockSnapshotHeaderModelNames.status: item.status,
      StockSnapshotHeaderModelNames.transactiondate: item.transactiondate,
      StockSnapshotHeaderModelNames.isSynced: item.isSynced,
      StockSnapshotHeaderModelNames.isError: item.isError,
      StockSnapshotHeaderModelNames.error: item.error,
    });
  }

  Future<void> insertStockSnapshotDetailList(
      List<StockTakeSaveDetailModel> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(StockSnapshotDetailModelNames.tableName, {
          StockSnapshotDetailModelNames.itemcode: data.itemcode,
          StockSnapshotDetailModelNames.physicalqty: data.physicalqty,
          StockSnapshotDetailModelNames.onhand: data.onhand,
          StockSnapshotDetailModelNames.remarks: data.remarks,
          StockSnapshotDetailModelNames.rowindex: data.rowindex,
          StockSnapshotDetailModelNames.unitid: data.unitid,
          StockSnapshotDetailModelNames.listrowindex: data.listrowindex,
          StockSnapshotDetailModelNames.listsysdocid: data.listsysdocid,
          StockSnapshotDetailModelNames.listvoucherid: data.listvoucherid,
          StockSnapshotDetailModelNames.refslno: data.refslno,
          StockSnapshotDetailModelNames.reftext1: data.reftext1,
          StockSnapshotDetailModelNames.reftext2: data.reftext2,
          StockSnapshotDetailModelNames.refnum1: data.refnum1,
          StockSnapshotDetailModelNames.refnum2: data.refnum2,
          StockSnapshotDetailModelNames.description: data.description,
          StockSnapshotDetailModelNames.refdate1: data.refdate1,
          StockSnapshotDetailModelNames.refdate2: data.refdate2,
        });
      }
      await batch.commit();
    });
  }

  Future<int> insertOutTransferHeader(CreateTransferOutLocalModel unit) async {
    Database? db = await DBHelper._database;
    return await db!.insert(CreateTransferOutImportantNames.tableName, {
      CreateTransferOutImportantNames.sysDocId: unit.sysDocId,
      CreateTransferOutImportantNames.voucherId: unit.voucherId,
      CreateTransferOutImportantNames.transferTypeId: unit.transferTypeId,
      CreateTransferOutImportantNames.acceptReference: unit.acceptReference,
      CreateTransferOutImportantNames.transactionDate: unit.transactionDate,
      CreateTransferOutImportantNames.divisionId: unit.divisionId,
      CreateTransferOutImportantNames.locationFromId: unit.locationFromId,
      CreateTransferOutImportantNames.locationToId: unit.locationToId,
      CreateTransferOutImportantNames.vehicleNumber: unit.vehicleNumber,
      CreateTransferOutImportantNames.driverId: unit.driverId,
      CreateTransferOutImportantNames.reference: unit.reference,
      CreateTransferOutImportantNames.description: unit.description,
      CreateTransferOutImportantNames.reason: unit.reason,
      CreateTransferOutImportantNames.isRejectedTransfer:
          unit.isRejectedTransfer,
      CreateTransferOutImportantNames.isSynced: unit.isSynced,
      CreateTransferOutImportantNames.isError: unit.isError,
      CreateTransferOutImportantNames.error: unit.error,
      CreateTransferOutImportantNames.quantity: unit.quantity,
    });
  }

  // Future<int> insertOutTransferDetails(CreateTransferOutDetailsLocalModel transferout) async {
  //   Database? db = await DBHelper._database;
  //   return await db!.insert(CreateTransferOutDetailsImportantNames.tableName, {
  //     'sysDocId': transferout.sysDocId,
  //     'voucherId': transferout.voucherId,
  //     'remarks': transferout.remarks,
  //     'acceptedFactorType': transferout.acceptedFactorType,
  //     'productId': transferout.productId,
  //     'description': transferout.description,
  //     'rowIndex': transferout.rowIndex,
  //     'sourceDocType': transferout.sourceDocType,
  //     'sourceRowIndex': transferout.sourceRowIndex,
  //     'listRowIndex': transferout.listRowIndex,
  //     'listVoucherId': transferout.listVoucherId,
  //     'listSysDocId': transferout.listSysDocId,
  //     'sourceVoucherId': transferout.sourceVoucherId,
  //     'sourceSysDocId': transferout.sourceSysDocId,
  //     'isSourcedRow': transferout.isSourcedRow,
  //     'isTrackLot': transferout.isTrackLot,
  //     'isTrackSerial': transferout.isTrackSerial,
  //     'acceptedQuantity': transferout.acceptedQuantity,
  //     'acceptedUnitQuantity': transferout.acceptedUnitQuantity,
  //     'acceptedFactor': transferout.acceptedFactor,
  //     'rejectedQuantity': transferout.rejectedQuantity,
  //     'rejectedUnitQuantity': transferout.rejectedUnitQuantity,
  //     'rejectedFactor': transferout.rejectedFactor,
  //     'quantity': transferout.quantity,
  //     'unitQuantity': transferout.unitQuantity,
  //     'factor': transferout.factor,
  //     'factorType': transferout.factorType,
  //     'rejectedFactorType': transferout.rejectedFactorType,
  //     'unitId': transferout.unitId,
  //   });
  // }
  Future<void> insertOutTransferDetailsList(
      List<CreateTransferOutDetailsLocalModel> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(CreateTransferOutDetailsImportantNames.tableName, {
          CreateTransferOutDetailsImportantNames.sysDocId: data.sysDocId,
          CreateTransferOutDetailsImportantNames.voucherId: data.voucherId,
          CreateTransferOutDetailsImportantNames.remarks: data.remarks,
          CreateTransferOutDetailsImportantNames.acceptedFactorType:
              data.acceptedFactorType,
          CreateTransferOutDetailsImportantNames.productId: data.productId,
          CreateTransferOutDetailsImportantNames.description: data.description,
          CreateTransferOutDetailsImportantNames.rowIndex: data.rowIndex,
          CreateTransferOutDetailsImportantNames.sourceDocType:
              data.sourceDocType,
          CreateTransferOutDetailsImportantNames.sourceRowIndex:
              data.sourceRowIndex,
          CreateTransferOutDetailsImportantNames.listRowIndex:
              data.listRowIndex,
          CreateTransferOutDetailsImportantNames.listVoucherId:
              data.listVoucherId,
          CreateTransferOutDetailsImportantNames.listSysDocId:
              data.listSysDocId,
          CreateTransferOutDetailsImportantNames.sourceVoucherId:
              data.sourceVoucherId,
          CreateTransferOutDetailsImportantNames.sourceSysDocId:
              data.sourceSysDocId,
          CreateTransferOutDetailsImportantNames.isSourcedRow:
              data.isSourcedRow,
          CreateTransferOutDetailsImportantNames.isTrackLot: data.isTrackLot,
          CreateTransferOutDetailsImportantNames.isTrackSerial:
              data.isTrackSerial,
          CreateTransferOutDetailsImportantNames.acceptedQuantity:
              data.acceptedQuantity,
          CreateTransferOutDetailsImportantNames.acceptedUnitQuantity:
              data.acceptedUnitQuantity,
          CreateTransferOutDetailsImportantNames.acceptedFactor:
              data.acceptedFactor,
          CreateTransferOutDetailsImportantNames.rejectedQuantity:
              data.rejectedQuantity,
          CreateTransferOutDetailsImportantNames.rejectedUnitQuantity:
              data.rejectedUnitQuantity,
          CreateTransferOutDetailsImportantNames.rejectedFactor:
              data.rejectedFactor,
          CreateTransferOutDetailsImportantNames.quantity: data.quantity,
          CreateTransferOutDetailsImportantNames.unitQuantity:
              data.unitQuantity,
          CreateTransferOutDetailsImportantNames.factor: data.factor,
          CreateTransferOutDetailsImportantNames.factorType: data.factorType,
          CreateTransferOutDetailsImportantNames.rejectedFactorType:
              data.rejectedFactorType,
          CreateTransferOutDetailsImportantNames.unitId: data.unitId,
        });
      }
      await batch.commit();
    });
  }

  Future<List<Map<String, dynamic>>> queryAllDefaultObjects() async {
    Database? db = await DBHelper._database;
    return await db!.query(
      DefaultsObjNames.tableName,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllUserLocation() async {
    Database? db = await DBHelper._database;
    return await db!.query(UserLocationModelName.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllMenuSecurityObjects() async {
    Database? db = await DBHelper._database;
    return await db!.query(
      MenuSecurityObjNames.tableName,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllScreenSecurityObjects() async {
    Database? db = await DBHelper._database;
    return await db!.query(
      ScreenSecurityObjNames.tableName,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllProducts() async {
    Database? db = await DBHelper._database;

    return await db!.rawQuery(
        """SELECT taxOption, origin, productId, isTrackLot, upc, unitid, taxGroupId, locationid, quantity, specialPrice, price1, price2, description, minPrice, category, style, modelClass, brand, age, manufacturer, size, rackBin, reorderLevel, isHold, isInactive 
FROM productList P WHERE P.isInactive = 0;""");
  }

  Future<List<Map<String, dynamic>>> queryProduct(String productId) async {
    Database? db = await DBHelper._database;
    List<Map<String, dynamic>> list = await db!.rawQuery(
      """SELECT taxOption, origin, productId, isTrackLot, upc, unitid, taxGroupId, locationid, quantity, specialPrice, price1, price2, description, minPrice, category, style, modelClass, brand, age, manufacturer, size, rackBin, reorderLevel, isHold, isInactive 
FROM productList P WHERE P.isInactive = 0 AND P.productId = ?;""",
      [productId],
    );
    return list;
  }

  Future<String?> queryProductImage(String productid) async {
    Database? db = await DBHelper._database;

    List<Map<String, dynamic>> list = await db!.rawQuery("""
    SELECT productimage
    FROM productList P WHERE P.productId = "$productid";
  """);

    if (list.isNotEmpty) {
      String? productImage = list[0]['productimage'];
      if (productImage != null) {
        return productImage;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllUnits(
      {required String productId}) async {
    Database? db = await DBHelper._database;
    return await db!.rawQuery('''SELECT
    UL.*
FROM unitList UL
WHERE UL.productId = "$productId" ;''');
  }

  Future<List<Map<String, dynamic>>> queryAllUnitfromProduct() async {
    Database? db = await DBHelper._database;
    return await db!.query(UnitmodelName.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllProductLocation(
      {required String productId}) async {
    Database? db = await DBHelper._database;
    return await db!.rawQuery('''
SELECT
    PL.*,
 L.name as locationName
FROM product_location PL
LEFT JOIN location L ON PL.locationId = L.code
WHERE PL.productId = "$productId"  AND PL.locationId IS NOT NULL;''');
  }

  Future<List<Map<String, dynamic>>> queryAllSysDocId() async {
    Database? db = await DBHelper._database;
    return await db!.query(SystemDocumentName.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllSysDocIdByType(
      {required int sysDocType}) async {
    Database? db = await DBHelper._database;
    return await db!.rawQuery('''SELECT
    SD.*
FROM sysDocId SD
WHERE SD.sysDocType = $sysDocType;''');
  }

  Future<List<Map<String, dynamic>>> queryAllSysDocIdById(
      {required int sysDocType, required String sysDocId}) async {
    Database? db = await DBHelper._database;
    return await db!.rawQuery('''SELECT
    SD.*
FROM sysDocId SD
WHERE SD.sysDocType = $sysDocType AND SD.code = $sysDocId;''');
  }

  Future<List<Map<String, dynamic>>> queryAllLocation() async {
    Database? db = await DBHelper._database;
    return await db!.query(LocationModelName.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllBrand() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.brandTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllClass() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.classTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllCategory() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.categoryTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllOrigin() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.originTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllSalesPerson() async {
    Database? db = await DBHelper._database;
    return await db!
        .query(ProductCommonComboModelName.customerSalesPersonTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllVendor() async {
    Database? db = await DBHelper._database;
    return await db!.query(VendorModelImportantNames.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllDriver() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.driverTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllVehicle() async {
    Database? db = await DBHelper._database;
    return await db!.query(ProductCommonComboModelName.vehicleTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllCustomer() async {
    Database? db = await DBHelper._database;
    return await db!.query(CustomerListImportantNames.tableName);
  }

  Future<List<Map<String, dynamic>>> queryAllTransferType() async {
    Database? db = await DBHelper._database;
    return await db!.query(TransferTypeModelName.tableName);
  }

  Future<List<Map<String, dynamic>>> queryStockSanpshotDetail(
      {required String voucher}) async {
    Database? db = await DBHelper._database;
    String whereString = '${StockSnapshotDetailModelNames.listvoucherid} = ?';
    List<dynamic> whereArguments = [voucher];
    return await db!.query(StockSnapshotDetailModelNames.tableName,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryStockSanpshotHeader() async {
    Database? db = await DBHelper._database;
    await Future.delayed(Duration(milliseconds: 100));
    return await db!.query(StockSnapshotHeaderModelNames.tableName);
  }

  Future<List<Map<String, dynamic>>> queryOutTransferHeader() async {
    Database? db = await DBHelper._database;
    await Future.delayed(Duration(milliseconds: 100));
    return await db!.query(CreateTransferOutImportantNames.tableName);
  }

  Future<List<Map<String, dynamic>>> queryOutTransferDetail(
      {required String voucher}) async {
    Database? db = await DBHelper._database;
    String whereString =
        '${CreateTransferOutDetailsImportantNames.voucherId} = ?';
    List<dynamic> whereArguments = [voucher];
    return await db!.query(CreateTransferOutDetailsImportantNames.tableName,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryAllGoodsRecieveNoteHeaders() async {
    Database? db = await DBHelper._database;
    return await db!.query(
      GoodsRecieveNoteHeaderModelNames.tableName,
    );
  }

  Future<List<Map<String, dynamic>>> queryGoodsRecieveNoteDetails(
      {required String voucher}) async {
    Database? db = await DBHelper._database;
    String whereString = '${GRNDetailsModelNames.voucherId} = ?';
    List<dynamic> whereArguments = [voucher];
    return await db!.query(GRNDetailsModelNames.tableName,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryGoodsRecieveNoteLotDetails(
      {required String voucher}) async {
    Database? db = await DBHelper._database;
    String whereString = '${ProductLotReceivingDetailModelNames.voucherid} = ?';
    List<dynamic> whereArguments = [voucher];
    return await db!.query(ProductLotReceivingDetailModelNames.tableName,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryAllTaxGroup() async {
    Database? db = await DBHelper._database;
    return await db!.query(TaxGroupModelName.tableName);
  }

  Future<int> updateProductList(ProductListModel product) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate(
      '''
    UPDATE ${ProductListModelName.tableName}
    SET 
      ${ProductListModelName.productId} = ?,
      ${ProductListModelName.taxOption} = ?,
      ${ProductListModelName.origin} = ?,
      ${ProductListModelName.productimage} = ?,
      ${ProductListModelName.isTrackLot} = ?,
      ${ProductListModelName.upc} = ?,
      ${ProductListModelName.unitId} = ?,
      ${ProductListModelName.taxGroupId} = ?,
      ${ProductListModelName.locationId} = ?,
      ${ProductListModelName.quantity} = ?,
      ${ProductListModelName.specialPrice} = ?,
      ${ProductListModelName.price1} = ?,
      ${ProductListModelName.price2} = ?,
      ${ProductListModelName.size} = ?,
      ${ProductListModelName.rackBin} = ?,
      ${ProductListModelName.description} = ?,
      ${ProductListModelName.reorderLevel} = ?,
      ${ProductListModelName.minPrice} = ?,
      ${ProductListModelName.category} = ?,
      ${ProductListModelName.style} = ?,
      ${ProductListModelName.modelClass} = ?,
      ${ProductListModelName.brand} = ?,
      ${ProductListModelName.age} = ?,
      ${ProductListModelName.manufacturer} = ?,
      ${ProductListModelName.isHold} = ?,
      ${ProductListModelName.isInactive} = ?
    WHERE ${ProductListModelName.productId} = ?
    ''',
      [
        product.productId,
        product.taxOption,
        product.origin,
        product.productimage,
        product.isTrackLot,
        product.upc,
        product.unitId,
        product.taxGroupId,
        product.locationId,
        product.quantity,
        product.specialPrice,
        product.price1,
        product.price2,
        product.size,
        product.rackBin,
        product.description,
        product.reorderLevel,
        product.minPrice,
        product.category,
        product.style,
        product.modelClass,
        product.brand,
        product.age,
        product.manufacturer,
        product.isHold,
        product.isInactive,
        product.productId,
      ],
    );
  }

  Future<void> insertOrUpdateProduct(ProductListModel product) async {
    Database? db = await DBHelper._database;

    List<Map<String, dynamic>> result = await db!.query(
      ProductListModelName.tableName,
      where: '${ProductListModelName.productId} = ?',
      whereArgs: [product.productId],
    );

    if (result.isNotEmpty) {
      await updateProductList(product);
    } else {
      await insertProduct(product);
    }
  }

  Future<int> updateSysDoc(int nextNumber, String code) async {
    print('nextNumber$nextNumber');
    print('code$code');
    return await _database!.rawUpdate('''
    UPDATE ${SystemDocumentName.tableName}
    SET ${SystemDocumentName.nextNumber} = ?
    WHERE ${SystemDocumentName.code} = ?
    ''', [nextNumber, code]);
  }

  Future<int> updateIsHold(int ishold, String itemcode) async {
    log('ishold $ishold');
    log('product id$itemcode');
    return await _database!.rawUpdate('''
    UPDATE ${ProductListModelName.tableName}
    SET ${ProductListModelName.isHold} = ?
    WHERE ${ProductListModelName.productId} = ?
    ''', [ishold, itemcode]);
  }

  Future<int> updateIsInactive(int isInactive, String itemcode) async {
    print('nextNumber$isInactive');
    print('code$itemcode');
    return await _database!.rawUpdate('''
    UPDATE ${ProductListModelName.tableName}
    SET ${ProductListModelName.isInactive} = ?
    WHERE ${ProductListModelName.productId} = ?
    ''', [isInactive, itemcode]);
  }

  Future<int> updateStockSnapshotHeader(
      String voucherId, int isSynced, int isError, String error) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${StockSnapshotHeaderModelNames.tableName}
    SET ${StockSnapshotHeaderModelNames.isSynced} = ?, ${StockSnapshotHeaderModelNames.isError} = ?, ${StockSnapshotHeaderModelNames.error} = ?
    WHERE ${StockSnapshotHeaderModelNames.voucherid} = ?
    ''', [isSynced, isError, error, voucherId]);
    return res;
  }

  Future<int> updateStockSnapshotHeaderVoucher(
      String voucherId, String docNo) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${StockSnapshotHeaderModelNames.tableName}
    SET  ${StockSnapshotHeaderModelNames.voucherid} = ?
    WHERE ${StockSnapshotHeaderModelNames.voucherid} = ?
    ''', [docNo, voucherId]);
    return res;
  }

  Future<int> updateStockSnapshotDetail(String voucherId) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${StockSnapshotDetailModelNames.tableName}
    SET ${StockSnapshotDetailModelNames.listvoucherid} = ?
    WHERE ${StockSnapshotDetailModelNames.listvoucherid} = ?
    ''', [voucherId]);
  }

  Future<int> updateOutTransferDetail(String voucherId) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${CreateTransferOutDetailsImportantNames.tableName}
    SET ${CreateTransferOutDetailsImportantNames.voucherId} = ?
    WHERE ${CreateTransferOutDetailsImportantNames.voucherId} = ?
    ''', [voucherId]);
  }

  deleteProductsTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductListModelName.tableName);
  }

  deleteUserLocationTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(UserLocationModelName.tableName);
  }

  deleteUnitsTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(UnitmodelName.tableName);
  }

  deleteProductLocationTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductlocationmodelName.tableName);
  }

  deleteSysDocIdTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(SystemDocumentName.tableName);
  }

  deleteLocationTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(LocationModelName.tableName);
  }

  deleteBrandTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.brandTableName);
  }

  deleteClassTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.classTableName);
  }

  deleteCategoryTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.categoryTableName);
  }

  deleteOriginTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.originTableName);
  }

  deleteSalePersonTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.customerSalesPersonTableName);
  }

  deleteVendorTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(VendorModelImportantNames.tableName);
  }

  deleteVehicleTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.vehicleTableName);
  }

  deleteDriverTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ProductCommonComboModelName.driverTableName);
  }

  deleteCustomerTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(CustomerListImportantNames.tableName);
  }

  deleteTransferTypeTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(TransferTypeModelName.tableName);
  }

  deleteDefaultObjTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(DefaultsObjNames.tableName);
  }

  deleteMenuSecurityObjTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(MenuSecurityObjNames.tableName);
  }

  deleteScreenSecurityObjTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(ScreenSecurityObjNames.tableName);
  }

  Future<int> deleteStockSnapshotHeader({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(StockSnapshotHeaderModelNames.tableName,
        where: '${StockSnapshotHeaderModelNames.voucherid} = ?',
        whereArgs: [vouchetId]);
  }

  Future<int> deleteStockSnapshotDetail({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(StockSnapshotDetailModelNames.tableName,
        where: '${StockSnapshotDetailModelNames.listvoucherid} = ?',
        whereArgs: [vouchetId]);
  }

  Future<int> deleteOutTransferHeader({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(CreateTransferOutImportantNames.tableName,
        where: '${CreateTransferOutImportantNames.voucherId} = ?',
        whereArgs: [vouchetId]);
  }

  Future<int> deleteOutTransferDetail({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(CreateTransferOutDetailsImportantNames.tableName,
        where: '${CreateTransferOutDetailsImportantNames.voucherId} = ?',
        whereArgs: [vouchetId]);
  }

  Future<List<Map<String, dynamic>>> queryLoadingSheetsHeader() async {
    Database? db = await DBHelper._database;
    await Future.delayed(Duration(milliseconds: 100));

    // return await db!.query(LoadingSheetsHeaderModelNames.tableName);
    return await db!.rawQuery('''SELECT*,
    COALESCE(c.${CustomerListImportantNames.name}, v.${VendorModelImportantNames.name}, '') AS ${LoadingSheetsHeaderModelNames.partyName}
FROM 
    ${LoadingSheetsHeaderModelNames.tableName} AS t
LEFT JOIN 
    ${CustomerListImportantNames.tableName} AS c ON t.${LoadingSheetsHeaderModelNames.partyId} = c.${CustomerListImportantNames.code}
LEFT JOIN 
    ${VendorModelImportantNames.tableName} AS v ON t.${LoadingSheetsHeaderModelNames.partyId} = v.${VendorModelImportantNames.code};''');
  }

  Future<List<Map<String, dynamic>>> queryLoadingSheetsDetail(
      {required String voucher}) async {
    Database? db = await DBHelper._database;
    String whereString =
        '${ItemTransactionDetailsModelNames.sourceVoucherID} = ?';
    List<dynamic> whereArguments = [voucher];
    return await db!.query(ItemTransactionDetailsModelNames.tableName,
        where: whereString, whereArgs: whereArguments);
  }

  Future<int> insertLoadingSheetsHeader(LoadingSheetsHeaderModel item) async {
    log("${item.fromLocationId} ${item.toLocationId} locations");
    Database? db = await DBHelper._database;
    return await db!.insert(LoadingSheetsHeaderModelNames.tableName, {
      LoadingSheetsHeaderModelNames.token: item.token,
      LoadingSheetsHeaderModelNames.sysdocid: item.sysdocid,
      LoadingSheetsHeaderModelNames.voucherid: item.voucherid,
      LoadingSheetsHeaderModelNames.partyType: item.partyType,
      LoadingSheetsHeaderModelNames.partyId: item.partyId,
      LoadingSheetsHeaderModelNames.locationId: item.fromLocationId,
      LoadingSheetsHeaderModelNames.toLocationId: item.toLocationId,
      LoadingSheetsHeaderModelNames.address: item.address,
      LoadingSheetsHeaderModelNames.containerNo: item.containerNo,
      LoadingSheetsHeaderModelNames.driverName: item.driverName,
      LoadingSheetsHeaderModelNames.vehicleNo: item.vehicleNo,
      LoadingSheetsHeaderModelNames.phoneNumber: item.phoneNumber,
      LoadingSheetsHeaderModelNames.salespersonid: item.salespersonid,
      LoadingSheetsHeaderModelNames.currencyid: item.currencyid,
      LoadingSheetsHeaderModelNames.transactionDate: item.transactionDate,
      LoadingSheetsHeaderModelNames.reference1: item.reference1,
      LoadingSheetsHeaderModelNames.reference2: item.reference2,
      LoadingSheetsHeaderModelNames.reference3: item.reference3,
      LoadingSheetsHeaderModelNames.note: item.note,
      LoadingSheetsHeaderModelNames.documentType: item.documentType,
      LoadingSheetsHeaderModelNames.startTime: item.startTime,
      LoadingSheetsHeaderModelNames.endTime: item.endTime,
      LoadingSheetsHeaderModelNames.isvoid: item.isvoid,
      LoadingSheetsHeaderModelNames.discount: item.discount,
      LoadingSheetsHeaderModelNames.total: item.total,
      LoadingSheetsHeaderModelNames.roundoff: item.roundoff,
      LoadingSheetsHeaderModelNames.isnewrecord: item.isnewrecord,
      LoadingSheetsHeaderModelNames.isSynced: item.isSynced,
      LoadingSheetsHeaderModelNames.isError: item.isError,
      LoadingSheetsHeaderModelNames.isCompleted: item.isCompleted,
      LoadingSheetsHeaderModelNames.error: item.error,
      LoadingSheetsHeaderModelNames.categories: item.categories,
    });
  }

  Future<void> insertItemTransactionDetailsList(
      List<ItemTransactionDetailsModel> dataList) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in dataList) {
        batch.insert(ItemTransactionDetailsModelNames.tableName, {
          ItemTransactionDetailsModelNames.itemCode: data.itemcode,
          ItemTransactionDetailsModelNames.description: data.description,
          ItemTransactionDetailsModelNames.quantity: data.quantity,
          ItemTransactionDetailsModelNames.rowIndex: data.rowindex,
          ItemTransactionDetailsModelNames.unitId: data.unitid,
          ItemTransactionDetailsModelNames.unitPrice: data.unitPrice,
          ItemTransactionDetailsModelNames.quantityReturned:
              data.quantityReturned,
          ItemTransactionDetailsModelNames.quantityShipped:
              data.quantityShipped,
          ItemTransactionDetailsModelNames.unitQuantity: data.unitQuantity,
          ItemTransactionDetailsModelNames.unitFactor: data.unitFactor,
          ItemTransactionDetailsModelNames.factorType: data.factorType,
          ItemTransactionDetailsModelNames.subunitPrice: data.subunitPrice,
          ItemTransactionDetailsModelNames.jobID: data.jobId,
          ItemTransactionDetailsModelNames.costCategoryID: data.costCategoryId,
          ItemTransactionDetailsModelNames.locationID: data.locationId,
          ItemTransactionDetailsModelNames.sourceVoucherID:
              data.sourceVoucherId,
          ItemTransactionDetailsModelNames.sourceSysDocID: data.sourceSysDocId,
          ItemTransactionDetailsModelNames.sourceRowIndex: data.sourceRowIndex,
          ItemTransactionDetailsModelNames.rowSource: data.rowSource,
          ItemTransactionDetailsModelNames.refSlNo: data.refSlNo,
          ItemTransactionDetailsModelNames.refText1: data.refText1,
          ItemTransactionDetailsModelNames.refText2: data.refText2,
          ItemTransactionDetailsModelNames.refText3: data.refText3,
          ItemTransactionDetailsModelNames.refText4: data.refText4,
          ItemTransactionDetailsModelNames.refText5: data.refText5,
          ItemTransactionDetailsModelNames.refNum1: data.refNum1,
          ItemTransactionDetailsModelNames.refNum2: data.refNum2,
          ItemTransactionDetailsModelNames.refDate1: data.refDate1,
          ItemTransactionDetailsModelNames.refDate2: data.refDate2,
          ItemTransactionDetailsModelNames.remarks: data.remarks,
          ItemTransactionDetailsModelNames.listQuantity: data.listQuantity,
        });
      }
      await batch.commit();
    });
  }

  Future<int> updateLoadingSheetsHeader(
      String voucherId, int isSynced, int isError, String error) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
    SET ${LoadingSheetsHeaderModelNames.isSynced} = ?, ${LoadingSheetsHeaderModelNames.isError} = ?, ${LoadingSheetsHeaderModelNames.error} = ?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [isSynced, isError, error, voucherId]);
    return res;
  }

  Future<int> updateloadingSheetsHeadersIscompleted(
      String voucherId, int isCompleted) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
    SET ${LoadingSheetsHeaderModelNames.isCompleted} = ?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [isCompleted, voucherId]);
    return res;
  }

  getPartyName({required String code}) async {
    Database? db = await DBHelper._database;
    var names = await db!.rawQuery('''SELECT name
FROM (
    SELECT ${CustomerListImportantNames.name} FROM ${CustomerListImportantNames.tableName} WHERE ${CustomerListImportantNames.code} = $code
    UNION
    SELECT ${VendorModelImportantNames.name} FROM ${VendorModelImportantNames.tableName} WHERE ${VendorModelImportantNames.code} = '$code
    UNION ALL
    SELECT '' AS name 
    LIMIT 1 
) 
WHERE name IS NOT NULL
LIMIT 1;''');
    return names.first['name'];
  }

  Future<int> updateOutTransferHeaders(
      String voucherId, int isSynced, int isError, String error) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${CreateTransferOutImportantNames.tableName}
    SET ${CreateTransferOutImportantNames.isSynced} = ?, ${CreateTransferOutImportantNames.isError} = ?, ${CreateTransferOutImportantNames.error} = ?
    WHERE ${CreateTransferOutImportantNames.voucherId} = ?
    ''', [isSynced, isError, error, voucherId]);
    return res;
  }

  Future<int> updateLoadingSheetsHeaderVoucher(
      String voucherId, String docNo) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
    SET  ${LoadingSheetsHeaderModelNames.voucherid} = ?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [docNo, voucherId]);

    return res;
  }

  Future<int> updateOutTransferHeaderVoucher(
      String voucherId, String docNo) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${CreateTransferOutImportantNames.tableName}
    SET  ${CreateTransferOutImportantNames.voucherId} = ?
    WHERE ${CreateTransferOutImportantNames.voucherId} = ?
    ''', [docNo, voucherId]);

    return res;
  }

  Future<int> updateLoadingSheetHeaderPartyIdOrDocumentType(
      String voucherId, String txt, bool partyId) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
   SET ${partyId ? LoadingSheetsHeaderModelNames.partyId : LoadingSheetsHeaderModelNames.documentType} = ?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [
      txt,
      voucherId,
    ]);
  }

  Future<int> updateLoadingSheetsDetail(String voucherId) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${ItemTransactionDetailsModelNames.tableName}
    SET ${ItemTransactionDetailsModelNames.sourceVoucherID} = ?
    WHERE ${ItemTransactionDetailsModelNames.sourceVoucherID} = ?
    ''', [voucherId]);
  }

  Future<int> deleteLoadingSheetsHeader({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(LoadingSheetsHeaderModelNames.tableName,
        where: '${LoadingSheetsHeaderModelNames.voucherid} = ?',
        whereArgs: [vouchetId]);
  }

  Future<int> updateLoadingSheetHeaderPartyId(
    String voucherId,
    String partyId,
  ) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
   SET ${LoadingSheetsHeaderModelNames.partyId} = ?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [
      partyId,
      voucherId,
    ]);
  }

  Future<int> deleteLoadingSheetsDetail({required String vouchetId}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(ItemTransactionDetailsModelNames.tableName,
        where: '${ItemTransactionDetailsModelNames.sourceVoucherID} = ?',
        whereArgs: [vouchetId]);
  }

  Future<int> updateLoadingSheetsItem(
      String voucherId, double quantity, String itemCode) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${ItemTransactionDetailsModelNames.tableName}
   SET ${ItemTransactionDetailsModelNames.quantity} = ?
    WHERE ${ItemTransactionDetailsModelNames.sourceVoucherID} = ? 
    AND ${ItemTransactionDetailsModelNames.itemCode} = ? 
    ''', [quantity, voucherId, itemCode]);
  }

  Future<int> insertItemTransactionItem(
      ItemTransactionDetailsModel dataList) async {
    Database? db = await DBHelper._database;
    return await db!.insert(ItemTransactionDetailsModelNames.tableName, {
      ItemTransactionDetailsModelNames.itemCode: dataList.itemcode,
      ItemTransactionDetailsModelNames.description: dataList.description,
      ItemTransactionDetailsModelNames.quantity: dataList.quantity,
      ItemTransactionDetailsModelNames.rowIndex: dataList.rowindex,
      ItemTransactionDetailsModelNames.unitId: dataList.unitid,
      ItemTransactionDetailsModelNames.unitPrice: dataList.unitPrice,
      ItemTransactionDetailsModelNames.quantityReturned:
          dataList.quantityReturned,
      ItemTransactionDetailsModelNames.quantityShipped:
          dataList.quantityShipped,
      ItemTransactionDetailsModelNames.unitQuantity: dataList.unitQuantity,
      ItemTransactionDetailsModelNames.unitFactor: dataList.unitFactor,
      ItemTransactionDetailsModelNames.factorType: dataList.factorType,
      ItemTransactionDetailsModelNames.subunitPrice: dataList.subunitPrice,
      ItemTransactionDetailsModelNames.jobID: dataList.jobId,
      ItemTransactionDetailsModelNames.costCategoryID: dataList.costCategoryId,
      ItemTransactionDetailsModelNames.locationID: dataList.locationId,
      ItemTransactionDetailsModelNames.sourceVoucherID:
          dataList.sourceVoucherId,
      ItemTransactionDetailsModelNames.sourceSysDocID: dataList.sourceSysDocId,
      ItemTransactionDetailsModelNames.sourceRowIndex: dataList.sourceRowIndex,
      ItemTransactionDetailsModelNames.rowSource: dataList.rowSource,
      ItemTransactionDetailsModelNames.refSlNo: dataList.refSlNo,
      ItemTransactionDetailsModelNames.refText1: dataList.refText1,
      ItemTransactionDetailsModelNames.refText2: dataList.refText2,
      ItemTransactionDetailsModelNames.refText3: dataList.refText3,
      ItemTransactionDetailsModelNames.refText4: dataList.refText4,
      ItemTransactionDetailsModelNames.refText5: dataList.refText5,
      ItemTransactionDetailsModelNames.refNum1: dataList.refNum1,
      ItemTransactionDetailsModelNames.refNum2: dataList.refNum2,
      ItemTransactionDetailsModelNames.refDate1: dataList.refDate1,
      ItemTransactionDetailsModelNames.refDate2: dataList.refDate2,
      ItemTransactionDetailsModelNames.remarks: dataList.remarks,
      ItemTransactionDetailsModelNames.listQuantity: dataList.listQuantity,
    });
  }

  Future<int> deleteLoadingSheetsItem({
    required String voucherId,
    required String itemCode,
  }) async {
    Database? db = await DBHelper._database;
    return await db!.delete(
      ItemTransactionDetailsModelNames.tableName,
      where:
          '${ItemTransactionDetailsModelNames.sourceVoucherID} = ? AND ${ItemTransactionDetailsModelNames.itemCode} = ?',
      whereArgs: [voucherId, itemCode],
    );
  }

  Future<int?> getLastVoucher({
    //required String prefix,
    required SysDocModel sysDoc,
    // required int nextNumber
  }) async {
    log(sysDoc.nextNumber.toString(), name: 'sysdoc');
    Database? db = await DBHelper._database;
    List<Map<String, dynamic>> rows = await db!.query(
      LoadingSheetsHeaderModelNames.tableName,
      where: '${LoadingSheetsHeaderModelNames.sysdocid} = ?',
      whereArgs: [sysDoc.code],
      orderBy: '${LoadingSheetsHeaderModelNames.voucherid} DESC',
      limit: 1,
    );
    int lastNumber = sysDoc.nextNumber ?? 0;
    if (rows.isNotEmpty) {
      int number = getIntegerFromString(
          rows.first[LoadingSheetsHeaderModelNames.voucherid]);
      lastNumber = number + 1;
      await updateSysDoc(lastNumber, sysDoc.code ?? '');
    }
    return lastNumber;
  }

  int getIntegerFromString(String inputString) {
    // Remove non-numeric characters
    String numericString = inputString.replaceAll(RegExp(r'[^0-9]'), '');

    // Convert the extracted string to an integer
    int number = int.tryParse(numericString) ?? 0;
    return number;
  }

  Future<int?> getLastOutTransferVoucher({
    //required String prefix,
    required SysDocModel sysDoc,
    // required int nextNumber
  }) async {
    Database? db = await DBHelper._database;
    List<Map<String, dynamic>> rows = await db!.query(
      CreateTransferOutImportantNames.tableName,
      orderBy: '${CreateTransferOutImportantNames.voucherId} DESC',
      limit: 1,
    );
    int lastNumber = sysDoc.nextNumber ?? 0;
    if (rows.isNotEmpty) {
      int number = int.parse(rows
          .first[CreateTransferOutImportantNames.voucherId]
          .split(sysDoc.numberPrefix)
          .last);
      lastNumber = number + 1;
      await updateSysDoc(lastNumber, sysDoc.code ?? '');
    }
    return lastNumber;
  }

  Future<int> updateLoadingSheetHeader(
      String voucherId, LoadingSheetsHeaderModel header) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${LoadingSheetsHeaderModelNames.tableName}
    SET ${LoadingSheetsHeaderModelNames.sysdocid} =?,
  ${LoadingSheetsHeaderModelNames.partyType} =?,
  ${LoadingSheetsHeaderModelNames.partyId} =?,
  ${LoadingSheetsHeaderModelNames.locationId} =?,
  ${LoadingSheetsHeaderModelNames.toLocationId} =?,
  ${LoadingSheetsHeaderModelNames.address} =?,
  ${LoadingSheetsHeaderModelNames.containerNo} =?,
  ${LoadingSheetsHeaderModelNames.driverName} =?,
  ${LoadingSheetsHeaderModelNames.vehicleNo} =?,
  ${LoadingSheetsHeaderModelNames.phoneNumber} =?, 
  ${LoadingSheetsHeaderModelNames.salespersonid} =?,
  ${LoadingSheetsHeaderModelNames.currencyid} =?,
  ${LoadingSheetsHeaderModelNames.transactionDate} =?,
  ${LoadingSheetsHeaderModelNames.reference1} =?,
  ${LoadingSheetsHeaderModelNames.reference2} =?,
  ${LoadingSheetsHeaderModelNames.reference3} =?,
  ${LoadingSheetsHeaderModelNames.note} =?,
  ${LoadingSheetsHeaderModelNames.documentType} =?,
  ${LoadingSheetsHeaderModelNames.startTime} =?,
  ${LoadingSheetsHeaderModelNames.endTime} =?,
  ${LoadingSheetsHeaderModelNames.isvoid} =?,
  ${LoadingSheetsHeaderModelNames.discount} =?,
  ${LoadingSheetsHeaderModelNames.total} =?,
  ${LoadingSheetsHeaderModelNames.roundoff} =?, 
  ${LoadingSheetsHeaderModelNames.isnewrecord} =?,
  ${LoadingSheetsHeaderModelNames.isSynced} =?,
  ${LoadingSheetsHeaderModelNames.isError} =?,
  ${LoadingSheetsHeaderModelNames.isCompleted} =?,
  ${LoadingSheetsHeaderModelNames.error} =?,
  ${LoadingSheetsHeaderModelNames.categories} =?
    WHERE ${LoadingSheetsHeaderModelNames.voucherid} = ?
    ''', [
      header.sysdocid,
      header.partyType,
      header.partyId,
      header.fromLocationId,
      header.toLocationId,
      header.address,
      header.containerNo,
      header.driverName,
      header.vehicleNo,
      header.phoneNumber,
      header.salespersonid,
      header.currencyid,
      header.transactionDate,
      header.reference1,
      header.reference2,
      header.reference3,
      header.note,
      header.documentType,
      header.startTime,
      header.endTime,
      header.isvoid,
      header.discount,
      header.total,
      header.roundoff,
      header.isnewrecord,
      header.isSynced,
      header.isError,
      header.isCompleted,
      header.error,
      header.categories,
      voucherId
    ]);
  }

  Future<int> updateItemTransactionDetails(String sourceVoucherId,
      String itemCode, ItemTransactionDetailsModel itemDetails) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${ItemTransactionDetailsModelNames.tableName}
    SET 
      ${ItemTransactionDetailsModelNames.itemCode} = ?,
      ${ItemTransactionDetailsModelNames.description} = ?,
      ${ItemTransactionDetailsModelNames.quantity} = ?,
      ${ItemTransactionDetailsModelNames.rowIndex} = ?,
      ${ItemTransactionDetailsModelNames.unitId} = ?,
      ${ItemTransactionDetailsModelNames.unitPrice} = ?,
      ${ItemTransactionDetailsModelNames.quantityReturned} = ?,
      ${ItemTransactionDetailsModelNames.quantityShipped} = ?,
      ${ItemTransactionDetailsModelNames.unitQuantity} = ?,
      ${ItemTransactionDetailsModelNames.unitFactor} = ?,
      ${ItemTransactionDetailsModelNames.factorType} = ?,
      ${ItemTransactionDetailsModelNames.subunitPrice} = ?,
      ${ItemTransactionDetailsModelNames.jobID} = ?,
      ${ItemTransactionDetailsModelNames.costCategoryID} = ?,
      ${ItemTransactionDetailsModelNames.locationID} = ?,
      ${ItemTransactionDetailsModelNames.sourceVoucherID} = ?,
      ${ItemTransactionDetailsModelNames.sourceSysDocID} = ?,
      ${ItemTransactionDetailsModelNames.sourceRowIndex} = ?,
      ${ItemTransactionDetailsModelNames.rowSource} = ?,
      ${ItemTransactionDetailsModelNames.refSlNo} = ?,
      ${ItemTransactionDetailsModelNames.refText1} = ?,
      ${ItemTransactionDetailsModelNames.refText2} = ?,
      ${ItemTransactionDetailsModelNames.refText3} = ?,
      ${ItemTransactionDetailsModelNames.refText4} = ?,
      ${ItemTransactionDetailsModelNames.refText5} = ?,
      ${ItemTransactionDetailsModelNames.refNum1} = ?,
      ${ItemTransactionDetailsModelNames.refNum2} = ?,
      ${ItemTransactionDetailsModelNames.refDate1} = ?,
      ${ItemTransactionDetailsModelNames.refDate2} = ?,
      ${ItemTransactionDetailsModelNames.remarks} = ?,
      ${ItemTransactionDetailsModelNames.listQuantity} = ?
    WHERE ${ItemTransactionDetailsModelNames.sourceVoucherID} = ?
    AND ${ItemTransactionDetailsModelNames.itemCode} = ?
    ''', [
      itemDetails.itemcode,
      itemDetails.description,
      itemDetails.quantity,
      itemDetails.rowindex,
      itemDetails.unitid,
      itemDetails.unitPrice,
      itemDetails.quantityReturned,
      itemDetails.quantityShipped,
      itemDetails.unitQuantity,
      itemDetails.unitFactor,
      itemDetails.factorType,
      itemDetails.subunitPrice,
      itemDetails.jobId,
      itemDetails.costCategoryId,
      itemDetails.locationId,
      itemDetails.sourceVoucherId,
      itemDetails.sourceSysDocId,
      itemDetails.sourceRowIndex,
      itemDetails.rowSource,
      itemDetails.refSlNo,
      itemDetails.refText1,
      itemDetails.refText2,
      itemDetails.refText3,
      itemDetails.refText4,
      itemDetails.refText5,
      itemDetails.refNum1,
      itemDetails.refNum2,
      itemDetails.refDate1,
      itemDetails.refDate2,
      itemDetails.remarks,
      itemDetails.listQuantity,
      sourceVoucherId,
      itemCode
    ]);
  }

  Future<List<Map<String, dynamic>>> queryDraftItemList(int draftOption) async {
    Database? db = await DBHelper._database;
    return await db!.rawQuery('''SELECT
    DL.*
FROM ${DraftItemListImpNames.tableName} DL
WHERE DL.draftOption = $draftOption;''');
  }

  Future<int> insertDraftItem(
      {required DraftItemListModel item, required int draftOption}) async {
    Database? db = await DBHelper._database;
    return await db!.insert(DraftItemListImpNames.tableName, {
      DraftItemListImpNames.taxOption: item.taxOption,
      DraftItemListImpNames.origin: item.origin,
      DraftItemListImpNames.productId: item.productId,
      DraftItemListImpNames.productimage: item.productimage,
      DraftItemListImpNames.isTrackLot: item.isTrackLot,
      DraftItemListImpNames.upc: item.upc,
      DraftItemListImpNames.unitId: item.unitId,
      DraftItemListImpNames.taxGroupId: item.taxGroupId,
      DraftItemListImpNames.locationId: item.locationId,
      DraftItemListImpNames.quantity: item.quantity,
      DraftItemListImpNames.specialPrice: item.specialPrice,
      DraftItemListImpNames.price1: item.price1,
      DraftItemListImpNames.price2: item.price2,
      DraftItemListImpNames.size: item.size,
      DraftItemListImpNames.rackBin: item.rackBin,
      DraftItemListImpNames.description: item.description,
      DraftItemListImpNames.reorderLevel: item.reorderLevel,
      DraftItemListImpNames.minPrice: item.minPrice,
      DraftItemListImpNames.category: item.category,
      DraftItemListImpNames.style: item.style,
      DraftItemListImpNames.modelClass: item.modelClass,
      DraftItemListImpNames.brand: item.brand,
      DraftItemListImpNames.age: item.age,
      DraftItemListImpNames.manufacturer: item.manufacturer,
      DraftItemListImpNames.draftOption: draftOption,
      DraftItemListImpNames.index: item.index,
      DraftItemListImpNames.updatedUnitId: item.updatedUnitId,
      DraftItemListImpNames.updatedQuatity: item.updatedQuatity,
      DraftItemListImpNames.remarks: item.remarks,
      DraftItemListImpNames.sysDocId: item.sysDocId,
      DraftItemListImpNames.voucherId: item.voucherId,
      DraftItemListImpNames.headerDescription: item.headerDescription,
      DraftItemListImpNames.headerLocationId: item.headerLocationId,
      DraftItemListImpNames.transactionDate: item.transactionDate,
      DraftItemListImpNames.isNewRecord: item.isNewRecord,
    });
  }

  insertDraftItemList(
      {required List<DraftItemListModel> items,
      required int draftOption}) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var item in items) {
        batch.insert(DraftItemListImpNames.tableName, {
          DraftItemListImpNames.taxOption: item.taxOption,
          DraftItemListImpNames.origin: item.origin,
          DraftItemListImpNames.productId: item.productId,
          DraftItemListImpNames.productimage: item.productimage,
          DraftItemListImpNames.isTrackLot: item.isTrackLot,
          DraftItemListImpNames.upc: item.upc,
          DraftItemListImpNames.unitId: item.unitId,
          DraftItemListImpNames.taxGroupId: item.taxGroupId,
          DraftItemListImpNames.locationId: item.locationId,
          DraftItemListImpNames.quantity: item.quantity,
          DraftItemListImpNames.specialPrice: item.specialPrice,
          DraftItemListImpNames.price1: item.price1,
          DraftItemListImpNames.price2: item.price2,
          DraftItemListImpNames.size: item.size,
          DraftItemListImpNames.rackBin: item.rackBin,
          DraftItemListImpNames.description: item.description,
          DraftItemListImpNames.reorderLevel: item.reorderLevel,
          DraftItemListImpNames.minPrice: item.minPrice,
          DraftItemListImpNames.category: item.category,
          DraftItemListImpNames.style: item.style,
          DraftItemListImpNames.modelClass: item.modelClass,
          DraftItemListImpNames.brand: item.brand,
          DraftItemListImpNames.age: item.age,
          DraftItemListImpNames.manufacturer: item.manufacturer,
          DraftItemListImpNames.draftOption: draftOption,
          DraftItemListImpNames.index: item.index,
          DraftItemListImpNames.updatedUnitId: item.updatedUnitId,
          DraftItemListImpNames.updatedQuatity: item.updatedQuatity,
          DraftItemListImpNames.remarks: item.remarks,
          DraftItemListImpNames.sysDocId: item.sysDocId,
          DraftItemListImpNames.voucherId: item.voucherId,
          DraftItemListImpNames.headerDescription: item.headerDescription,
          DraftItemListImpNames.headerLocationId: item.headerLocationId,
          DraftItemListImpNames.transactionDate: item.transactionDate,
          DraftItemListImpNames.isNewRecord: item.isNewRecord,
        });
      }
      await batch.commit();
    });
  }

  Future<int> insertGoodsRecieveNoteHeader(
      GoodsRecieveNoteHeaderModel data) async {
    Database? db = await DBHelper._database;
    return await db!.insert(GoodsRecieveNoteHeaderModelNames.tableName, {
      GoodsRecieveNoteHeaderModelNames.isnewrecord: data.isnewrecord,
      GoodsRecieveNoteHeaderModelNames.sysdocid: data.sysdocid,
      GoodsRecieveNoteHeaderModelNames.voucherid: data.voucherid,
      GoodsRecieveNoteHeaderModelNames.companyid: data.companyid,
      GoodsRecieveNoteHeaderModelNames.divisionid: data.divisionid,
      GoodsRecieveNoteHeaderModelNames.vendorID: data.vendorId,
      GoodsRecieveNoteHeaderModelNames.transporterID: data.transporterId,
      GoodsRecieveNoteHeaderModelNames.termID: data.termId,
      GoodsRecieveNoteHeaderModelNames.transactiondate:
          data.transactiondate?.toIso8601String(),
      GoodsRecieveNoteHeaderModelNames.purchaseFlow: data.purchaseFlow,
      GoodsRecieveNoteHeaderModelNames.currencyid: data.currencyid,
      GoodsRecieveNoteHeaderModelNames.currencyrate: data.currencyrate,
      GoodsRecieveNoteHeaderModelNames.shippingmethodid: data.shippingmethodid,
      GoodsRecieveNoteHeaderModelNames.reference: data.reference,
      GoodsRecieveNoteHeaderModelNames.reference2: data.reference2,
      GoodsRecieveNoteHeaderModelNames.vendorReferenceNo:
          data.vendorReferenceNo,
      GoodsRecieveNoteHeaderModelNames.note: data.note,
      GoodsRecieveNoteHeaderModelNames.isvoid: data.isvoid,
      GoodsRecieveNoteHeaderModelNames.isImport: data.isImport,
      GoodsRecieveNoteHeaderModelNames.payeetaxgroupid: data.payeetaxgroupid,
      GoodsRecieveNoteHeaderModelNames.taxoption: data.taxoption,
      GoodsRecieveNoteHeaderModelNames.driverID: data.driverId,
      GoodsRecieveNoteHeaderModelNames.vehicleID: data.vehicleId,
      GoodsRecieveNoteHeaderModelNames.advanceamount: data.advanceamount,
      GoodsRecieveNoteHeaderModelNames.activateGRNEdit: data.activateGrnEdit,
      GoodsRecieveNoteHeaderModelNames.isSynced: data.isSynced,
      GoodsRecieveNoteHeaderModelNames.isError: data.isError,
      GoodsRecieveNoteHeaderModelNames.error: data.error,
    });
  }

  insertGoodsRecieveNoteDetail(List<GRNDetailsModel> datas) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in datas) {
        batch.insert(GRNDetailsModelNames.tableName, {
          GRNDetailsModelNames.voucherId: data.voucherId,
          GRNDetailsModelNames.itemcode: data.itemcode,
          GRNDetailsModelNames.description: data.description,
          GRNDetailsModelNames.quantity: data.quantity,
          GRNDetailsModelNames.refSlNo: data.refSlNo,
          GRNDetailsModelNames.refText1: data.refText1,
          GRNDetailsModelNames.refText2: data.refText2,
          GRNDetailsModelNames.refNum1: data.refNum1,
          GRNDetailsModelNames.refNum2: data.refNum2,
          GRNDetailsModelNames.refDate1: data.refDate1?.toIso8601String(),
          GRNDetailsModelNames.refDate2: data.refDate2?.toIso8601String(),
          GRNDetailsModelNames.locationid: data.locationid,
          GRNDetailsModelNames.jobid: data.jobid,
          GRNDetailsModelNames.costcategoryid: data.costcategoryid,
          GRNDetailsModelNames.unitprice: data.unitprice,
          GRNDetailsModelNames.unitID: data.unitID,
          GRNDetailsModelNames.remarks: data.remarks,
          GRNDetailsModelNames.rowindex: data.rowindex,
          GRNDetailsModelNames.jobSubCategoryid: data.jobSubCategoryid,
          GRNDetailsModelNames.jobCategoryid: data.jobCategoryid,
          GRNDetailsModelNames.specificationID: data.specificationID,
          GRNDetailsModelNames.taxoption: data.taxoption,
          GRNDetailsModelNames.taxGroupID: data.taxGroupID,
          GRNDetailsModelNames.styleid: data.styleid,
          GRNDetailsModelNames.itemtype: data.itemtype,
          GRNDetailsModelNames.isNew: data.isNew,
          GRNDetailsModelNames.cost: data.cost,
          GRNDetailsModelNames.amount: data.amount,
          GRNDetailsModelNames.rowSource: data.rowSource,
        });
      }
      await batch.commit();
    });
  }

  insertgoodsRecieveNoteLotDetail(
      List<ProductLotReceivingDetailModel> datas) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var data in datas) {
        batch.insert(ProductLotReceivingDetailModelNames.tableName, {
          ProductLotReceivingDetailModelNames.sysdocid: data.sysdocid,
          ProductLotReceivingDetailModelNames.voucherid: data.voucherid,
          ProductLotReceivingDetailModelNames.productID: data.productID,
          ProductLotReceivingDetailModelNames.unitID: data.unitID,
          ProductLotReceivingDetailModelNames.locationId: data.locationId,
          ProductLotReceivingDetailModelNames.lotNumber: data.lotNumber,
          ProductLotReceivingDetailModelNames.reference: data.reference,
          ProductLotReceivingDetailModelNames.sourceLotNumber:
              data.sourceLotNumber,
          ProductLotReceivingDetailModelNames.quantity: data.quantity,
          ProductLotReceivingDetailModelNames.binID: data.binID,
          ProductLotReceivingDetailModelNames.reference2: data.reference2,
          ProductLotReceivingDetailModelNames.unitPrice: data.unitPrice,
          ProductLotReceivingDetailModelNames.rowIndex: data.rowIndex,
          ProductLotReceivingDetailModelNames.cost: data.cost,
          ProductLotReceivingDetailModelNames.soldQty: data.soldQty,
          ProductLotReceivingDetailModelNames.rackID: data.rackID,
          ProductLotReceivingDetailModelNames.lotQty: data.lotQty,
          ProductLotReceivingDetailModelNames.expiryDate:
              data.expiryDate?.toIso8601String(),
          ProductLotReceivingDetailModelNames.refSlNo: data.refSlNo,
          ProductLotReceivingDetailModelNames.refext1: data.refext1,
          ProductLotReceivingDetailModelNames.reftext2: data.reftext2,
          ProductLotReceivingDetailModelNames.reftext3: data.reftext3,
          ProductLotReceivingDetailModelNames.reftext4: data.reftext4,
          ProductLotReceivingDetailModelNames.reftext5: data.reftext5,
          ProductLotReceivingDetailModelNames.refNum1: data.refNum1,
          ProductLotReceivingDetailModelNames.refNum2: data.refNum2,
          ProductLotReceivingDetailModelNames.refDate1:
              data.refDate1?.toIso8601String(),
          ProductLotReceivingDetailModelNames.refDate2:
              data.refDate2?.toIso8601String(),
        });
      }
      await batch.commit();
    });
  }

  insertTaxGroupList(List<TaxGroupComboModel> taxGroups) async {
    Database? db = await DBHelper._database;
    final batch = db!.batch();
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var taxGroup in taxGroups) {
        batch.insert(TaxGroupModelName.tableName, {
          TaxGroupModelName.code: taxGroup.code,
          TaxGroupModelName.name: taxGroup.name,
          TaxGroupModelName.taxRate: taxGroup.taxRate,
        });
      }
      await batch.commit();
    });
  }
  // Future<int> updateDraftItem({
  //   required String productId,
  //   required int draftOption,
  //   required int index,
  //   required double quantity,
  // }) async {
  //   Database? db = await DBHelper._database;
  //   int res = await db!.rawUpdate('''
  //   UPDATE ${DraftItemListImpNames.tableName}
  //   SET ${DraftItemListImpNames.quantity} = ?
  //   WHERE ${DraftItemListImpNames.draftOption} = ? AND ${DraftItemListImpNames.index} = ? AND ${DraftItemListImpNames.productId} = ?
  //   ''', [quantity, draftOption, index, productId]);
  //   return res;
  // }

  Future<int> updateDraftItem(
      {required String productId,
      required int draftOption,
      required int index,
      required double quantity,
      required String unitId}) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${DraftItemListImpNames.tableName}
SET ${DraftItemListImpNames.updatedQuatity} = ?,
${DraftItemListImpNames.updatedUnitId} = ?
WHERE ${DraftItemListImpNames.productId} = ? 
  AND ${DraftItemListImpNames.index} = ? 
  AND ${DraftItemListImpNames.draftOption} = ?
    ''', [quantity, unitId, productId, index, draftOption]);
    return res;
  }

  Future<int> updateDraftItemSysDoc(
      {required String sysDocId,
      required String newSysDoc,
      required String voucherId}) async {
    Database? db = await DBHelper._database;
    int res = await db!.rawUpdate('''
    UPDATE ${DraftItemListImpNames.tableName}
SET ${DraftItemListImpNames.sysDocId} = ?,
${DraftItemListImpNames.voucherId} = ?
WHERE ${DraftItemListImpNames.sysDocId} = ? 
    ''', [newSysDoc, voucherId, sysDocId]);
    return res;
  }

  Future<int> updateGoodsRecieveNoteHeader(String voucherId, int isSynced,
      int isError, String error, String docNo) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${GoodsRecieveNoteHeaderModelNames.tableName}
    SET ${GoodsRecieveNoteHeaderModelNames.isSynced} = ?, ${GoodsRecieveNoteHeaderModelNames.isError} = ?, ${GoodsRecieveNoteHeaderModelNames.error} = ?, ${GoodsRecieveNoteHeaderModelNames.voucherid} = ?
    WHERE ${GoodsRecieveNoteHeaderModelNames.voucherid} = ?
    ''', [isSynced, isError, error, docNo, voucherId]);
  }

  Future<int> updateGoodsRecieveNoteDetail(
      String voucherId, String docNo) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${GRNDetailsModelNames.tableName}
    SET ${GRNDetailsModelNames.voucherId} = ?
    WHERE ${GRNDetailsModelNames.voucherId} = ?
    ''', [docNo, voucherId]);
  }

  Future<int> updategoodsRecieveNoteLotDetail(
      String voucherId, String docNo) async {
    Database? db = await DBHelper._database;
    return await db!.rawUpdate('''
    UPDATE ${ProductLotReceivingDetailModelNames.tableName}
    SET ${ProductLotReceivingDetailModelNames.voucherid} = ?
    WHERE ${ProductLotReceivingDetailModelNames.voucherid} = ?
    ''', [docNo, voucherId]);
  }

  Future<int> deleteDraftItemList({required int draftOption}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(DraftItemListImpNames.tableName,
        where: '${DraftItemListImpNames.draftOption} = ?',
        whereArgs: [draftOption]);
  }

  Future<int> deleteDraftItem(
      {required int draftOption, required int index}) async {
    Database? db = await DBHelper._database;
    return await db!.delete(DraftItemListImpNames.tableName,
        where:
            '${DraftItemListImpNames.draftOption} = ? AND ${DraftItemListImpNames.index} = ?',
        whereArgs: [draftOption, index]);
  }

  isLoadingSheeHeaderExist(String voucherID) async {
    log("${voucherID}");
    Database? db = await DBHelper._database;
    var dbs = await db!.rawQuery('''
    SELECT CASE WHEN EXISTS (
    SELECT 1
    FROM ${LoadingSheetsHeaderModelNames.tableName} LS
    WHERE LS.${LoadingSheetsHeaderModelNames.voucherid} = "${voucherID}"
    ) THEN TRUE ELSE FALSE END AS result;
    ''');
    return dbs.first['result'];
  }

  isLoadingSheeDetailExist(String voucherID, String itemCode) async {
    Database? db = await DBHelper._database;
    var dbs = await db!.rawQuery('''
    SELECT CASE WHEN EXISTS (
    SELECT 1
    FROM ${ItemTransactionDetailsModelNames.tableName} IT
    WHERE IT.${ItemTransactionDetailsModelNames.sourceVoucherID} = "${voucherID}" AND IT.${ItemTransactionDetailsModelNames.itemCode} = "${itemCode}"
    ) THEN TRUE ELSE FALSE END AS result;
    ''');
    return dbs.first['result'];
  }

  Future<int> deletegoodsRecieveNoteHeader(String voucher) async {
    Database? db = await DBHelper._database;
    return await db!.delete(GoodsRecieveNoteHeaderModelNames.tableName,
        where: '${GoodsRecieveNoteHeaderModelNames.voucherid} = ?',
        whereArgs: [voucher]);
  }

  Future<int> deletegoodsRecieveNoteDetails(String voucher) async {
    Database? db = await DBHelper._database;
    return await db!.delete(GRNDetailsModelNames.tableName,
        where: '${GRNDetailsModelNames.voucherId} = ?', whereArgs: [voucher]);
  }

  Future<int> deletegoodsRecieveNoteLotDetails(String voucher) async {
    Database? db = await DBHelper._database;
    int status = await db!.delete(ProductLotReceivingDetailModelNames.tableName,
        where: '${ProductLotReceivingDetailModelNames.voucherid} = ?',
        whereArgs: [voucher]);
    log(status.toString(), name: 'lot details deleting');
    return status;
  }

  deleteTaxGroupTable() async {
    Database? db = await DBHelper._database;
    await db!.delete(TaxGroupModelName.tableName);
  }
}
