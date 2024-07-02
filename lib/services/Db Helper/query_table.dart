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

class QuerryTable {
  static var dbUpgradeQueryTable = [
    '''
    CREATE TABLE ${TaxGroupModelName.tableName}(
      ${TaxGroupModelName.code} TEXT,
      ${TaxGroupModelName.name} TEXT,
      ${TaxGroupModelName.taxRate} INTEGER
    )
    ''',
        '''ALTER TABLE ${ProductListModelName.tableName} ADD COLUMN ${ProductListModelName.isHold} INTEGER, ADD COLUMN ${ProductListModelName.isInactive} INTEGER''',
    '''
        CREATE TABLE ${ProductLotReceivingDetailModelNames.tableName} (
          ${ProductLotReceivingDetailModelNames.sysdocid} TEXT,
          ${ProductLotReceivingDetailModelNames.voucherid} TEXT,
          ${ProductLotReceivingDetailModelNames.productID} TEXT,
          ${ProductLotReceivingDetailModelNames.unitID} TEXT,
          ${ProductLotReceivingDetailModelNames.locationId} TEXT,
          ${ProductLotReceivingDetailModelNames.lotNumber} TEXT,
          ${ProductLotReceivingDetailModelNames.reference} TEXT,
          ${ProductLotReceivingDetailModelNames.sourceLotNumber} TEXT,
          ${ProductLotReceivingDetailModelNames.quantity} INTEGER,
          ${ProductLotReceivingDetailModelNames.binID} TEXT,
          ${ProductLotReceivingDetailModelNames.reference2} TEXT,
          ${ProductLotReceivingDetailModelNames.unitPrice} REAL,
          ${ProductLotReceivingDetailModelNames.rowIndex} INTEGER,
          ${ProductLotReceivingDetailModelNames.cost} REAL,
          ${ProductLotReceivingDetailModelNames.soldQty} REAL,
          ${ProductLotReceivingDetailModelNames.rackID} TEXT,
          ${ProductLotReceivingDetailModelNames.lotQty} INTEGER,
          ${ProductLotReceivingDetailModelNames.expiryDate} TEXT,
          ${ProductLotReceivingDetailModelNames.refSlNo} INTEGER,
          ${ProductLotReceivingDetailModelNames.refext1} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext2} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext3} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext4} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext5} TEXT,
          ${ProductLotReceivingDetailModelNames.refNum1} INTEGER,
          ${ProductLotReceivingDetailModelNames.refNum2} INTEGER,
          ${ProductLotReceivingDetailModelNames.refDate1} TEXT,
          ${ProductLotReceivingDetailModelNames.refDate2} TEXT
        )
      ''',
    '''
        CREATE TABLE ${GRNDetailsModelNames.tableName} (
          ${GRNDetailsModelNames.voucherId} TEXT,
          ${GRNDetailsModelNames.itemcode} TEXT,
          ${GRNDetailsModelNames.description} TEXT,
          ${GRNDetailsModelNames.quantity} INTEGER,
          ${GRNDetailsModelNames.refSlNo} INTEGER,
          ${GRNDetailsModelNames.refText1} TEXT,
          ${GRNDetailsModelNames.refText2} TEXT,
          ${GRNDetailsModelNames.refNum1} INTEGER,
          ${GRNDetailsModelNames.refNum2} INTEGER,
          ${GRNDetailsModelNames.refDate1} TEXT,
          ${GRNDetailsModelNames.refDate2} TEXT,
          ${GRNDetailsModelNames.locationid} TEXT,
          ${GRNDetailsModelNames.jobid} TEXT,
          ${GRNDetailsModelNames.costcategoryid} TEXT,
          ${GRNDetailsModelNames.unitprice} REAL,
          ${GRNDetailsModelNames.unitID} TEXT,
          ${GRNDetailsModelNames.remarks} TEXT,
          ${GRNDetailsModelNames.rowindex} INTEGER,
          ${GRNDetailsModelNames.jobSubCategoryid} TEXT,
          ${GRNDetailsModelNames.jobCategoryid} TEXT,
          ${GRNDetailsModelNames.specificationID} TEXT,
          ${GRNDetailsModelNames.taxoption} INTEGER,
          ${GRNDetailsModelNames.taxGroupID} TEXT,
          ${GRNDetailsModelNames.styleid} TEXT,
          ${GRNDetailsModelNames.itemtype} INTEGER,
          ${GRNDetailsModelNames.isNew} INTEGER,
          ${GRNDetailsModelNames.cost} REAL,
          ${GRNDetailsModelNames.amount} REAL,
          ${GRNDetailsModelNames.rowSource} INTEGER
        )
      ''',
    '''
      CREATE TABLE ${GoodsRecieveNoteHeaderModelNames.tableName} (
        ${GoodsRecieveNoteHeaderModelNames.isnewrecord} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.sysdocid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.voucherid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.companyid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.divisionid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vendorID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.transporterID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.termID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.transactiondate} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.purchaseFlow} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.currencyid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.currencyrate} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.shippingmethodid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.reference} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.reference2} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vendorReferenceNo} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.note} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.isvoid} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isImport} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.payeetaxgroupid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.taxoption} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.driverID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vehicleID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.advanceamount} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.activateGRNEdit} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isSynced} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isError} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.error} TEXT
      )
    ''',
    '''
    CREATE TABLE ${UserLocationModelName.tableName}(
      ${UserLocationModelName.code} TEXT,
      ${UserLocationModelName.name} TEXT,
      ${UserLocationModelName.isConsignInLocation} INTEGER,
      ${UserLocationModelName.isConsignOutLocation} INTEGER,
      ${UserLocationModelName.isposLocation} INTEGER,
      ${UserLocationModelName.isWarehouse} INTEGER,
      ${UserLocationModelName.isQuarantine} INTEGER,
      ${UserLocationModelName.isUserLocation} TEXT
    )
    ''',
    '''ALTER TABLE ${LoadingSheetsHeaderModelNames.tableName} ADD COLUMN ${LoadingSheetsHeaderModelNames.categories} TEXT''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.vehicleTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.driverTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.customerSalesPersonTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.brandTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.classTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.categoryTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.originTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
CREATE TABLE ${CustomerListImportantNames.tableName}(
  ${CustomerListImportantNames.code} TEXT,
  ${CustomerListImportantNames.name} TEXT,
  ${CustomerListImportantNames.searchColumn} TEXT,
  ${CustomerListImportantNames.currencyId} TEXT,
  ${CustomerListImportantNames.allowConsignment} INTEGER,
  ${CustomerListImportantNames.isHold} INTEGER,
  ${CustomerListImportantNames.priceLevelId} TEXT,
  ${CustomerListImportantNames.balance} INTEGER,
  ${CustomerListImportantNames.parentCustomerId} TEXT,
  ${CustomerListImportantNames.paymentTermId} TEXT,
  ${CustomerListImportantNames.paymentMethodId} TEXT,
  ${CustomerListImportantNames.shippingMethodId} TEXT,
  ${CustomerListImportantNames.billToAddressId} TEXT,
  ${CustomerListImportantNames.shipToAddressId} TEXT,
  ${CustomerListImportantNames.salesPersonId} TEXT,
  ${CustomerListImportantNames.isWeightInvoice} INTEGER,
  ${CustomerListImportantNames.customerClassId} TEXT,
  ${CustomerListImportantNames.taxOption} INTEGER,
  ${CustomerListImportantNames.taxGroupId} TEXT,
  ${CustomerListImportantNames.childCustomers} INTEGER,
  ${CustomerListImportantNames.isLpo} INTEGER,
  ${CustomerListImportantNames.isPro} INTEGER,
  ${CustomerListImportantNames.mobile} TEXT
)
''',
    '''
CREATE TABLE ${VendorModelImportantNames.tableName}(
  ${VendorModelImportantNames.code} TEXT,
  ${VendorModelImportantNames.name} TEXT,
  ${VendorModelImportantNames.searchColumn} TEXT,
  ${VendorModelImportantNames.currencyId} TEXT,
  ${VendorModelImportantNames.parentVendorId} TEXT,
  ${VendorModelImportantNames.allowConsignment} INTEGER,
  ${VendorModelImportantNames.allowOap} INTEGER,
  ${VendorModelImportantNames.consignComPercent} REAL,
  ${VendorModelImportantNames.shippingMethodId} TEXT,
  ${VendorModelImportantNames.paymentTermId} TEXT,
  ${VendorModelImportantNames.paymentMethodId} TEXT,
  ${VendorModelImportantNames.buyerId} TEXT,
  ${VendorModelImportantNames.primaryAddressId} TEXT,
  ${VendorModelImportantNames.vendorClassId} TEXT,
  ${VendorModelImportantNames.taxOption} INTEGER,
  ${VendorModelImportantNames.taxGroupId} TEXT
)
''',
    '''ALTER TABLE ${LoadingSheetsHeaderModelNames.tableName} ADD COLUMN ${LoadingSheetsHeaderModelNames.toLocationId} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.address} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.containerNo} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.driverName} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.vehicleNo} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.phoneNumber} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.startTime} TEXT, ADD COLUMN ${LoadingSheetsHeaderModelNames.endTime} TEXT''',
    '''ALTER TABLE ${ItemTransactionDetailsModelNames.tableName} ADD COLUMN ${ItemTransactionDetailsModelNames.listQuantity} TEXT''',
    '''
  CREATE TABLE ${DraftItemListImpNames.tableName}(
    ${DraftItemListImpNames.taxOption} TEXT,
    ${DraftItemListImpNames.origin} TEXT,
    ${DraftItemListImpNames.productId} TEXT,
    ${DraftItemListImpNames.productimage} TEXT,
    ${DraftItemListImpNames.isTrackLot} INTEGER,
    ${DraftItemListImpNames.upc} TEXT,
    ${DraftItemListImpNames.unitId} TEXT,
    ${DraftItemListImpNames.taxGroupId} TEXT,
    ${DraftItemListImpNames.locationId} TEXT,
    ${DraftItemListImpNames.quantity} REAL,
    ${DraftItemListImpNames.specialPrice} REAL,
    ${DraftItemListImpNames.price1} REAL,
    ${DraftItemListImpNames.price2} REAL,
    ${DraftItemListImpNames.description} TEXT,
    ${DraftItemListImpNames.minPrice} DOUBLE,
    ${DraftItemListImpNames.category} TEXT,
    ${DraftItemListImpNames.style} TEXT,
    ${DraftItemListImpNames.modelClass} TEXT,
    ${DraftItemListImpNames.brand} TEXT,
    ${DraftItemListImpNames.age} TEXT,
    ${DraftItemListImpNames.manufacturer} TEXT,
    ${DraftItemListImpNames.size} TEXT,
    ${DraftItemListImpNames.rackBin} TEXT,   
    ${DraftItemListImpNames.reorderLevel} REAL,
    ${DraftItemListImpNames.draftOption} INTEGER,
    ${DraftItemListImpNames.index} INTEGER,
    ${DraftItemListImpNames.updatedQuatity} REAL,
    ${DraftItemListImpNames.updatedUnitId} TEXT,
    ${DraftItemListImpNames.remarks} TEXT,
    ${DraftItemListImpNames.sysDocId} TEXT,
    ${DraftItemListImpNames.voucherId} TEXT,
    ${DraftItemListImpNames.headerDescription} TEXT,
    ${DraftItemListImpNames.headerLocationId} TEXT,
    ${DraftItemListImpNames.transactionDate} TEXT,
    ${DraftItemListImpNames.isNewRecord} INTEGER
  )
  ''',
    '''
CREATE TABLE ${CreateTransferOutDetailsImportantNames.tableName}(
  ${CreateTransferOutDetailsImportantNames.sysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.voucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.remarks} TEXT,
  ${CreateTransferOutDetailsImportantNames.acceptedFactorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.productId} TEXT,
  ${CreateTransferOutDetailsImportantNames.description} TEXT,
  ${CreateTransferOutDetailsImportantNames.rowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.sourceDocType} INTEGER,
  ${CreateTransferOutDetailsImportantNames.sourceRowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.listRowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.listVoucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.listSysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.sourceVoucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.sourceSysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.isSourcedRow} TEXT,
  ${CreateTransferOutDetailsImportantNames.isTrackLot} INTEGER,
  ${CreateTransferOutDetailsImportantNames.isTrackSerial} INTEGER,
  ${CreateTransferOutDetailsImportantNames.acceptedQuantity} DOUBLE,
  ${CreateTransferOutDetailsImportantNames.acceptedUnitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.acceptedFactor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedUnitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedFactor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.quantity} DOUBLE,
  ${CreateTransferOutDetailsImportantNames.unitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.factor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.factorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.rejectedFactorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.unitId} TEXT
)
''',
    '''
CREATE TABLE ${CreateTransferOutImportantNames.tableName}(
  ${CreateTransferOutImportantNames.sysDocId} TEXT,
  ${CreateTransferOutImportantNames.voucherId} TEXT,
  ${CreateTransferOutImportantNames.transferTypeId} TEXT,
  ${CreateTransferOutImportantNames.acceptReference} TEXT,
  ${CreateTransferOutImportantNames.transactionDate} TEXT,
  ${CreateTransferOutImportantNames.divisionId} TEXT,
  ${CreateTransferOutImportantNames.locationFromId} TEXT,
  ${CreateTransferOutImportantNames.locationToId} TEXT,
  ${CreateTransferOutImportantNames.vehicleNumber} TEXT,
  ${CreateTransferOutImportantNames.driverId} TEXT,
  ${CreateTransferOutImportantNames.reference} TEXT,
  ${CreateTransferOutImportantNames.description} TEXT,
  ${CreateTransferOutImportantNames.reason} INTEGER,
  ${CreateTransferOutImportantNames.isRejectedTransfer} INTEGER,
  ${CreateTransferOutImportantNames.isSynced} INTEGER,
  ${CreateTransferOutImportantNames.isError} INTEGER,
  ${CreateTransferOutImportantNames.error} TEXT,
  ${CreateTransferOutImportantNames.quantity} DOUBLE
)
''',
    '''
CREATE TABLE ${ItemTransactionDetailsModelNames.tableName}(
  ${ItemTransactionDetailsModelNames.itemCode} TEXT,
  ${ItemTransactionDetailsModelNames.description} TEXT,
  ${ItemTransactionDetailsModelNames.quantity} REAL,
  ${ItemTransactionDetailsModelNames.rowIndex} INTEGER,
  ${ItemTransactionDetailsModelNames.unitId} TEXT,
  ${ItemTransactionDetailsModelNames.unitPrice} INTEGER,
  ${ItemTransactionDetailsModelNames.quantityReturned} REAL,
  ${ItemTransactionDetailsModelNames.quantityShipped} REAL,
  ${ItemTransactionDetailsModelNames.unitQuantity} REAL,
  ${ItemTransactionDetailsModelNames.unitFactor} INTEGER,
  ${ItemTransactionDetailsModelNames.factorType} TEXT,
  ${ItemTransactionDetailsModelNames.subunitPrice} INTEGER,
  ${ItemTransactionDetailsModelNames.jobID} TEXT,
  ${ItemTransactionDetailsModelNames.costCategoryID} TEXT,
  ${ItemTransactionDetailsModelNames.locationID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceVoucherID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceSysDocID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceRowIndex} INTEGER,
  ${ItemTransactionDetailsModelNames.rowSource} TEXT,
  ${ItemTransactionDetailsModelNames.refSlNo} TEXT,
  ${ItemTransactionDetailsModelNames.refText1} TEXT,
  ${ItemTransactionDetailsModelNames.refText2} TEXT,
  ${ItemTransactionDetailsModelNames.refText3} TEXT,
  ${ItemTransactionDetailsModelNames.refText4} TEXT,
  ${ItemTransactionDetailsModelNames.refText5} TEXT,
  ${ItemTransactionDetailsModelNames.refNum1} INTEGER,
  ${ItemTransactionDetailsModelNames.refNum2} INTEGER,
  ${ItemTransactionDetailsModelNames.refDate1} TEXT,
  ${ItemTransactionDetailsModelNames.refDate2} TEXT,
  ${ItemTransactionDetailsModelNames.remarks} TEXT,
  ${ItemTransactionDetailsModelNames.listQuantity} TEXT
)
''',
    '''
CREATE TABLE ${LoadingSheetsHeaderModelNames.tableName}(
  ${LoadingSheetsHeaderModelNames.token} TEXT,
  ${LoadingSheetsHeaderModelNames.sysdocid} TEXT,
  ${LoadingSheetsHeaderModelNames.voucherid} TEXT,
  ${LoadingSheetsHeaderModelNames.partyType} TEXT,
  ${LoadingSheetsHeaderModelNames.partyId} TEXT,
  ${LoadingSheetsHeaderModelNames.locationId} TEXT,
  ${LoadingSheetsHeaderModelNames.toLocationId} TEXT,
  ${LoadingSheetsHeaderModelNames.address} TEXT,
  ${LoadingSheetsHeaderModelNames.containerNo} TEXT,
  ${LoadingSheetsHeaderModelNames.driverName} TEXT,
  ${LoadingSheetsHeaderModelNames.vehicleNo} TEXT,
  ${LoadingSheetsHeaderModelNames.phoneNumber} TEXT,
  ${LoadingSheetsHeaderModelNames.salespersonid} TEXT,
  ${LoadingSheetsHeaderModelNames.currencyid} TEXT,
  ${LoadingSheetsHeaderModelNames.transactionDate} TEXT,
  ${LoadingSheetsHeaderModelNames.reference1} TEXT,
  ${LoadingSheetsHeaderModelNames.reference2} TEXT,
  ${LoadingSheetsHeaderModelNames.reference3} TEXT,
  ${LoadingSheetsHeaderModelNames.note} TEXT,
  ${LoadingSheetsHeaderModelNames.documentType} TEXT,
  ${LoadingSheetsHeaderModelNames.startTime} TEXT,
  ${LoadingSheetsHeaderModelNames.endTime} TEXT,
  ${LoadingSheetsHeaderModelNames.isvoid} INTEGER,
  ${LoadingSheetsHeaderModelNames.discount} INTEGER,
  ${LoadingSheetsHeaderModelNames.total} REAL,
  ${LoadingSheetsHeaderModelNames.roundoff} INTEGER,
  ${LoadingSheetsHeaderModelNames.isnewrecord} INTEGER,
  ${LoadingSheetsHeaderModelNames.isSynced} INTEGER,
  ${LoadingSheetsHeaderModelNames.isError} INTEGER,
  ${LoadingSheetsHeaderModelNames.isCompleted} INTEGER,
  ${LoadingSheetsHeaderModelNames.error} TEXT,
  ${LoadingSheetsHeaderModelNames.categories} TEXT
)
''',
    '''
    CREATE TABLE ${StockSnapshotHeaderModelNames.tableName}(
      ${StockSnapshotHeaderModelNames.token} TEXT,
      ${StockSnapshotHeaderModelNames.sysdocid} TEXT,
      ${StockSnapshotHeaderModelNames.voucherid} TEXT,
      ${StockSnapshotHeaderModelNames.companyid} TEXT,
      ${StockSnapshotHeaderModelNames.divisionid} TEXT,
      ${StockSnapshotHeaderModelNames.locationid} TEXT,
      ${StockSnapshotHeaderModelNames.adjustmenttype} TEXT,
      ${StockSnapshotHeaderModelNames.refrence} TEXT,
      ${StockSnapshotHeaderModelNames.description} TEXT,
      ${StockSnapshotHeaderModelNames.isnewrecord} INTEGER,
      ${StockSnapshotHeaderModelNames.status} INTEGER,
      ${StockSnapshotHeaderModelNames.transactiondate} TEXT,
      ${StockSnapshotHeaderModelNames.isSynced} INTEGER,
      ${StockSnapshotHeaderModelNames.isError} INTEGER,
      ${StockSnapshotHeaderModelNames.error} TEXT
    )
''',
    '''
    CREATE TABLE ${StockSnapshotDetailModelNames.tableName} (
      ${StockSnapshotDetailModelNames.itemcode} TEXT,
      ${StockSnapshotDetailModelNames.physicalqty} REAL,
      ${StockSnapshotDetailModelNames.onhand} REAL,
      ${StockSnapshotDetailModelNames.remarks} TEXT,
      ${StockSnapshotDetailModelNames.rowindex} INTEGER,
      ${StockSnapshotDetailModelNames.unitid} TEXT,
      ${StockSnapshotDetailModelNames.listrowindex} REAL,
      ${StockSnapshotDetailModelNames.listsysdocid} TEXT,
      ${StockSnapshotDetailModelNames.listvoucherid} TEXT,
      ${StockSnapshotDetailModelNames.refslno} TEXT,
      ${StockSnapshotDetailModelNames.reftext1} TEXT,
      ${StockSnapshotDetailModelNames.reftext2} TEXT,
      ${StockSnapshotDetailModelNames.refnum1} TEXT,
      ${StockSnapshotDetailModelNames.refnum2} TEXT,
      ${StockSnapshotDetailModelNames.description} TEXT,
      ${StockSnapshotDetailModelNames.refdate1} TEXT,
      ${StockSnapshotDetailModelNames.refdate2} TEXT
    )
''',
    '''
    CREATE TABLE ${DefaultsObjNames.tableName} (
      ${DefaultsObjNames.defaultSalespersonId} TEXT,
      ${DefaultsObjNames.defaultInventoryLocationId} TEXT,
      ${DefaultsObjNames.defaultTransactionLocationId} TEXT,
      ${DefaultsObjNames.defaultTransactionRegisterId} TEXT,
      ${DefaultsObjNames.defaultCompanyDivisionId} TEXT
    )
''',
    '''
    CREATE TABLE ${MenuSecurityObjNames.tableName} (
      ${MenuSecurityObjNames.menuId} TEXT,
      ${MenuSecurityObjNames.subMenuId} TEXT,
      ${MenuSecurityObjNames.dropDownId} TEXT,
      ${MenuSecurityObjNames.enable} INTEGER,
      ${MenuSecurityObjNames.visible} INTEGER,
      ${MenuSecurityObjNames.userId} TEXT,
      ${MenuSecurityObjNames.groupId} TEXT
    )
''',
    '''
    CREATE TABLE ${ScreenSecurityObjNames.tableName} (
      ${ScreenSecurityObjNames.screenId} TEXT,
      ${ScreenSecurityObjNames.viewRight} INTEGER,
      ${ScreenSecurityObjNames.newRight} INTEGER,
      ${ScreenSecurityObjNames.editRight} INTEGER,
      ${ScreenSecurityObjNames.deleteRight} INTEGER,
      ${ScreenSecurityObjNames.userId} TEXT,
      ${ScreenSecurityObjNames.groupId} TEXT
    )
''',
//     '''
//     CREATE TABLE ${StockSnapshotHeaderModelNames.tableName}(
//       ${StockSnapshotHeaderModelNames.token} TEXT,
//       ${StockSnapshotHeaderModelNames.sysdocid} TEXT,
//       ${StockSnapshotHeaderModelNames.voucherid} TEXT,
//       ${StockSnapshotHeaderModelNames.companyid} TEXT,
//       ${StockSnapshotHeaderModelNames.divisionid} TEXT,
//       ${StockSnapshotHeaderModelNames.locationid} TEXT,
//       ${StockSnapshotHeaderModelNames.adjustmenttype} TEXT,
//       ${StockSnapshotHeaderModelNames.refrence} TEXT,
//       ${StockSnapshotHeaderModelNames.description} TEXT,
//       ${StockSnapshotHeaderModelNames.isnewrecord} INTEGER,
//       ${StockSnapshotHeaderModelNames.status} INTEGER,
//       ${StockSnapshotHeaderModelNames.transactiondate} TEXT,
//       ${StockSnapshotHeaderModelNames.isSynced} INTEGER,
//       ${StockSnapshotHeaderModelNames.isError} INTEGER,
//       ${StockSnapshotHeaderModelNames.error} TEXT
//     )
// ''',
//     '''
//     CREATE TABLE ${StockSnapshotDetailModelNames.tableName} (
//       ${StockSnapshotDetailModelNames.itemcode} TEXT,
//       ${StockSnapshotDetailModelNames.physicalqty} REAL,
//       ${StockSnapshotDetailModelNames.onhand} REAL,
//       ${StockSnapshotDetailModelNames.remarks} TEXT,
//       ${StockSnapshotDetailModelNames.rowindex} INTEGER,
//       ${StockSnapshotDetailModelNames.unitid} TEXT,
//       ${StockSnapshotDetailModelNames.listrowindex} REAL,
//       ${StockSnapshotDetailModelNames.listsysdocid} TEXT,
//       ${StockSnapshotDetailModelNames.listvoucherid} TEXT,
//       ${StockSnapshotDetailModelNames.refslno} TEXT,
//       ${StockSnapshotDetailModelNames.reftext1} TEXT,
//       ${StockSnapshotDetailModelNames.reftext2} TEXT,
//       ${StockSnapshotDetailModelNames.refnum1} TEXT,
//       ${StockSnapshotDetailModelNames.refnum2} TEXT,
//       ${StockSnapshotDetailModelNames.description} TEXT,
//       ${StockSnapshotDetailModelNames.refdate1} TEXT,
//       ${StockSnapshotDetailModelNames.refdate2} TEXT
//     )
// ''',
//     '''ALTER TABLE ${ArrivalReportOpenListNames.tableName}
//           ADD COLUMN ${ArrivalReportOpenListNames.issue2CountDouble} DOUBLE
//       ''',
//     '''ALTER TABLE ${ArrivalReportOpenListNames.tableName}
//           ADD COLUMN ${ArrivalReportOpenListNames.issue3CountDouble} DOUBLE
//       ''',
//     '''ALTER TABLE ${ArrivalReportOpenListNames.tableName}
//           ADD COLUMN ${ArrivalReportOpenListNames.issue4CountDouble} DOUBLE
//       ''',
//     '''ALTER TABLE ${ArrivalReportOpenListNames.tableName}
//           ADD COLUMN ${ArrivalReportOpenListNames.issue1CountDouble} DOUBLE
//       ''',
//     '''
//     CREATE TABLE ${ArrivalReportOpenListNames.tableName}(
//       ${ArrivalReportOpenListNames.itemId} TEXT,
//        ${ArrivalReportOpenListNames.sysDoc} TEXT,
//        ${ArrivalReportOpenListNames.voucherId} TEXT,
//         ${ArrivalReportOpenListNames.lotNo} TEXT,
//         ${ArrivalReportOpenListNames.comodityId} TEXT,
//         ${ArrivalReportOpenListNames.varietyId} TEXT,
//         ${ArrivalReportOpenListNames.brandId} TEXT,
//         ${ArrivalReportOpenListNames.itemSize} TEXT,
//         ${ArrivalReportOpenListNames.grade} TEXT,
//         ${ArrivalReportOpenListNames.sampleCount} INTEGER,
//         ${ArrivalReportOpenListNames.issue1Count} INTEGER,
//         ${ArrivalReportOpenListNames.issue2Count} INTEGER,
//         ${ArrivalReportOpenListNames.issue3Count} INTEGER,
//         ${ArrivalReportOpenListNames.issue4Count} INTEGER,
//         ${ArrivalReportOpenListNames.temperature} TEXT,
//         ${ArrivalReportOpenListNames.standardWeight} DOUBLE,
//         ${ArrivalReportOpenListNames.weight} DOUBLE,
//         ${ArrivalReportOpenListNames.pressure} DOUBLE,
//         ${ArrivalReportOpenListNames.brix} DOUBLE,
//         ${ArrivalReportOpenListNames.remarks} TEXT,
//         ${ArrivalReportOpenListNames.grower} TEXT,
//         ${ArrivalReportOpenListNames.commodityName} TEXT,
//         ${ArrivalReportOpenListNames.varietyName} TEXT,
//         ${ArrivalReportOpenListNames.brandName} TEXT,
//         ${ArrivalReportOpenListNames.issue1CountDouble} DOUBLE,
//         ${ArrivalReportOpenListNames.issue2CountDouble} DOUBLE,
//         ${ArrivalReportOpenListNames.issue3CountDouble} DOUBLE,
//         ${ArrivalReportOpenListNames.issue4CountDouble} DOUBLE
//     )
//     ''',
//     '''
//     CREATE TABLE ${ConnectionModelImpNames.tableName}(
//        ${ConnectionModelImpNames.connectionName} TEXT,
//        ${ConnectionModelImpNames.serverIp} TEXT,
//         ${ConnectionModelImpNames.port} TEXT,
//         ${ConnectionModelImpNames.databaseName} TEXT,
//         ${ConnectionModelImpNames.userName} TEXT,
//         ${ConnectionModelImpNames.password} TEXT
//     )
//     ''',
//     '''
//     CREATE TABLE ${StockSnapshotHeaderModelNames.tableName}(
//       ${StockSnapshotHeaderModelNames.token} TEXT,
//       ${StockSnapshotHeaderModelNames.sysdocid} TEXT,
//       ${StockSnapshotHeaderModelNames.voucherid} TEXT,
//       ${StockSnapshotHeaderModelNames.companyid} TEXT,
//       ${StockSnapshotHeaderModelNames.divisionid} TEXT,
//       ${StockSnapshotHeaderModelNames.locationid} TEXT,
//       ${StockSnapshotHeaderModelNames.adjustmenttype} TEXT,
//       ${StockSnapshotHeaderModelNames.refrence} TEXT,
//       ${StockSnapshotHeaderModelNames.description} TEXT,
//       ${StockSnapshotHeaderModelNames.isnewrecord} INTEGER,
//       ${StockSnapshotHeaderModelNames.status} INTEGER,
//       ${StockSnapshotHeaderModelNames.transactiondate} TEXT,
//       ${StockSnapshotHeaderModelNames.isSynced} INTEGER,
//       ${StockSnapshotHeaderModelNames.isError} INTEGER,
//       ${StockSnapshotHeaderModelNames.error} TEXT
//     )
//     ''',
//     '''
//     CREATE TABLE ${StockSnapshotDetailModelNames.tableName} (
//       ${StockSnapshotDetailModelNames.itemcode} TEXT,
//       ${StockSnapshotDetailModelNames.physicalqty} REAL,
//       ${StockSnapshotDetailModelNames.onhand} REAL,
//       ${StockSnapshotDetailModelNames.remarks} TEXT,
//       ${StockSnapshotDetailModelNames.rowindex} INTEGER,
//       ${StockSnapshotDetailModelNames.unitid} TEXT,
//       ${StockSnapshotDetailModelNames.listrowindex} REAL,
//       ${StockSnapshotDetailModelNames.listsysdocid} TEXT,
//       ${StockSnapshotDetailModelNames.listvoucherid} TEXT,
//       ${StockSnapshotDetailModelNames.refslno} TEXT,
//       ${StockSnapshotDetailModelNames.reftext1} TEXT,
//       ${StockSnapshotDetailModelNames.reftext2} TEXT,
//       ${StockSnapshotDetailModelNames.refnum1} TEXT,
//       ${StockSnapshotDetailModelNames.refnum2} TEXT,
//       ${StockSnapshotDetailModelNames.description} TEXT,
//       ${StockSnapshotDetailModelNames.refdate1} TEXT,
//       ${StockSnapshotDetailModelNames.refdate2} TEXT
//     )
// '''
  ];
  static var dbQueryTable = [
    // '''
    // CREATE TABLE ${UserActivityLogImportantNames.tableName}(
    //   ${UserActivityLogImportantNames.activityType} TEXT,
    //   ${UserActivityLogImportantNames.date} TEXT,
    //   ${UserActivityLogImportantNames.userId} TEXT,
    //   ${UserActivityLogImportantNames.machine} TEXT,
    //   ${UserActivityLogImportantNames.description} TEXT
    // )
    // ''',
    '''
  CREATE TABLE ${DraftItemListImpNames.tableName}(
    ${DraftItemListImpNames.taxOption} TEXT,
    ${DraftItemListImpNames.origin} TEXT,
    ${DraftItemListImpNames.productId} TEXT,
    ${DraftItemListImpNames.productimage} TEXT,
    ${DraftItemListImpNames.isTrackLot} INTEGER,
    ${DraftItemListImpNames.upc} TEXT,
    ${DraftItemListImpNames.unitId} TEXT,
    ${DraftItemListImpNames.taxGroupId} TEXT,
    ${DraftItemListImpNames.locationId} TEXT,
    ${DraftItemListImpNames.quantity} REAL,
    ${DraftItemListImpNames.specialPrice} REAL,
    ${DraftItemListImpNames.price1} REAL,
    ${DraftItemListImpNames.price2} REAL,
    ${DraftItemListImpNames.description} TEXT,
    ${DraftItemListImpNames.minPrice} DOUBLE,
    ${DraftItemListImpNames.category} TEXT,
    ${DraftItemListImpNames.style} TEXT,
    ${DraftItemListImpNames.modelClass} TEXT,
    ${DraftItemListImpNames.brand} TEXT,
    ${DraftItemListImpNames.age} TEXT,
    ${DraftItemListImpNames.manufacturer} TEXT,
    ${DraftItemListImpNames.size} TEXT,
    ${DraftItemListImpNames.rackBin} TEXT,   
    ${DraftItemListImpNames.reorderLevel} REAL,
    ${DraftItemListImpNames.draftOption} INTEGER,
    ${DraftItemListImpNames.index} INTEGER,
    ${DraftItemListImpNames.updatedQuatity} REAL,
    ${DraftItemListImpNames.updatedUnitId} TEXT,
    ${DraftItemListImpNames.remarks} TEXT,
    ${DraftItemListImpNames.sysDocId} TEXT,
    ${DraftItemListImpNames.voucherId} TEXT,
    ${DraftItemListImpNames.headerDescription} TEXT,
    ${DraftItemListImpNames.headerLocationId} TEXT,
    ${DraftItemListImpNames.transactionDate} TEXT,
    ${DraftItemListImpNames.isNewRecord} INTEGER
  )
  ''',
    '''
    CREATE TABLE ${ProductlocationmodelName.tableName}(
      ${ProductlocationmodelName.productId} TEXT,
      ${ProductlocationmodelName.locationId} TEXT,
      ${ProductlocationmodelName.quantity} DOUBLE
    )
    ''',
    '''
    CREATE TABLE ${ProductListModelName.tableName}(
      ${ProductListModelName.taxOption} TEXT,
      ${ProductListModelName.origin} TEXT,
      ${ProductListModelName.productId} TEXT,
      ${ProductListModelName.productimage} TEXT,
      ${ProductListModelName.isTrackLot} INTEGER,
      ${ProductListModelName.upc} TEXT,
      ${ProductListModelName.unitId} TEXT,
      ${ProductListModelName.taxGroupId} TEXT,
      ${ProductListModelName.locationId} TEXT,
      ${ProductListModelName.quantity} DOUBLE,
      ${ProductListModelName.specialPrice} DOUBLE,
      ${ProductListModelName.price1} DOUBLE,
      ${ProductListModelName.price2} DOUBLE,
      ${ProductListModelName.description} TEXT,
      ${ProductListModelName.minPrice} DOUBLE,
      ${ProductListModelName.category} TEXT,
      ${ProductListModelName.style} TEXT,
      ${ProductListModelName.modelClass} TEXT,
      ${ProductListModelName.brand} TEXT,
      ${ProductListModelName.age} TEXT,
      ${ProductListModelName.manufacturer} TEXT,
      ${ProductListModelName.size} TEXT,
      ${ProductListModelName.rackBin} TEXT,   
      ${ProductListModelName.reorderLevel} DOUBLE,
      ${ProductListModelName.isHold} INTEGER,
      ${ProductListModelName.isInactive} INTEGER 
    )
    ''',
    // '''
    // CREATE TABLE ${InventoryItemListImpNames.tableName}(
    //   ${InventoryItemListImpNames.taxOption} TEXT,
    //   ${InventoryItemListImpNames.productId} TEXT,
    //   ${InventoryItemListImpNames.productimage} TEXT,
    //   ${InventoryItemListImpNames.isTrackLot} INTEGER,
    //   ${InventoryItemListImpNames.upc} TEXT,
    //   ${InventoryItemListImpNames.unitId} TEXT,
    //   ${InventoryItemListImpNames.taxGroupId} TEXT,
    //   ${InventoryItemListImpNames.locationId} TEXT,
    //   ${InventoryItemListImpNames.quantity} DOUBLE,
    //   ${InventoryItemListImpNames.specialPrice} DOUBLE,
    //   ${InventoryItemListImpNames.price1} DOUBLE,
    //   ${InventoryItemListImpNames.price2} DOUBLE,
    //   ${InventoryItemListImpNames.description} TEXT,
    //   ${InventoryItemListImpNames.minPrice} DOUBLE,
    //   ${InventoryItemListImpNames.category} TEXT,
    //   ${InventoryItemListImpNames.style} TEXT,
    //   ${InventoryItemListImpNames.modelClass} TEXT,
    //   ${InventoryItemListImpNames.brand} TEXT,
    //   ${InventoryItemListImpNames.age} TEXT,
    //   ${InventoryItemListImpNames.manufacturer} TEXT,
    //   ${InventoryItemListImpNames.updatedQuantity} DOUBLE,
    //   ${InventoryItemListImpNames.updatedUnit} TEXT,
    //   ${InventoryItemListImpNames.updatedStock} DOUBLE
    // )
    // ''',
    '''
    CREATE TABLE ${UnitmodelName.tableName}(
       ${UnitmodelName.code} TEXT,
        ${UnitmodelName.name} TEXT,
        ${UnitmodelName.productId} TEXT,
        ${UnitmodelName.factorType} TEXT,
        ${UnitmodelName.factor} TEXT,
        ${UnitmodelName.isMainUnit} INTEGER
    )
    ''',
    //  '''
    //   CREATE TABLE ${InventoryTransferDetailsImportantNames.tableName}(
    //     ${InventoryTransferDetailsImportantNames.sysDocId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.voucherId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.remarks} TEXT,
    //     ${InventoryTransferDetailsImportantNames.acceptedFactorType} TEXT,
    //     ${InventoryTransferDetailsImportantNames.productId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.description} TEXT,
    //     ${InventoryTransferDetailsImportantNames.rowIndex} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.sourceDocType} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.sourceRowIndex} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.listRowIndex} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.listVoucherId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.listSysDocId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.sourceVoucherId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.sourceSysDocId} TEXT,
    //     ${InventoryTransferDetailsImportantNames.isSourcedRow} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.isTrackLot} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.isTrackSerial} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.acceptedQuantity} DOUBLE,
    //     ${InventoryTransferDetailsImportantNames.acceptedUnitQuantity} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.acceptedFactor} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.rejectedQuantity} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.rejectedUnitQuantity} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.rejectedFactor} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.quantity} DOUBLE,
    //     ${InventoryTransferDetailsImportantNames.unitQuantity} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.factor} INTEGER,
    //     ${InventoryTransferDetailsImportantNames.factorType} TEXT,
    //     ${InventoryTransferDetailsImportantNames.rejectedFactorType} TEXT,
    //     ${InventoryTransferDetailsImportantNames.unitId} TEXT
    //   )
    //   ''',
    // '''
    // CREATE TABLE ${InventoryTransferDetailsReportImportantNames.tableName}(
    //   ${InventoryTransferDetailsReportImportantNames.sysDocId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.voucherId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.remarks} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.acceptedFactorType} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.productId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.description} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.rowIndex} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.sourceDocType} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.sourceRowIndex} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.listRowIndex} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.listVoucherId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.listSysDocId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.sourceVoucherId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.sourceSysDocId} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.isSourcedRow} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.isTrackLot} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.isTrackSerial} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.acceptedQuantity} DOUBLE,
    //   ${InventoryTransferDetailsReportImportantNames.acceptedUnitQuantity} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.acceptedFactor} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.rejectedQuantity} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.rejectedUnitQuantity} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.rejectedFactor} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.quantity} DOUBLE,
    //   ${InventoryTransferDetailsReportImportantNames.unitQuantity} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.factor} INTEGER,
    //   ${InventoryTransferDetailsReportImportantNames.factorType} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.rejectedFactorType} TEXT,
    //   ${InventoryTransferDetailsReportImportantNames.unitId} TEXT
    // )
    // ''',
    // '''
    // CREATE TABLE ${CreateTransferOutImportantNames.tableName}(
    //   ${CreateTransferOutImportantNames.sysDocId} TEXT,
    //   ${CreateTransferOutImportantNames.voucherId} TEXT,
    //   ${CreateTransferOutImportantNames.transferTypeId} TEXT,
    //   ${CreateTransferOutImportantNames.acceptReference} TEXT,
    //   ${CreateTransferOutImportantNames.transactionDate} TEXT,
    //   ${CreateTransferOutImportantNames.divisionId} TEXT,
    //   ${CreateTransferOutImportantNames.locationFromId} TEXT,
    //   ${CreateTransferOutImportantNames.locationToId} TEXT,
    //   ${CreateTransferOutImportantNames.vehicleNumber} TEXT,
    //   ${CreateTransferOutImportantNames.driverId} TEXT,
    //   ${CreateTransferOutImportantNames.reference} TEXT,
    //   ${CreateTransferOutImportantNames.description} TEXT,
    //   ${CreateTransferOutImportantNames.reason} INTEGER,
    //   ${CreateTransferOutImportantNames.isRejectedTransfer} INTEGER,
    //   ${CreateTransferOutImportantNames.isSynced} INTEGER,
    //   ${CreateTransferOutImportantNames.error} TEXT,
    //   ${CreateTransferOutImportantNames.quantity} DOUBLE
    // )
    // ''',
    // '''
    // CREATE TABLE ${CreateTransferOutReportImportantNames.tableName}(
    //   ${CreateTransferOutReportImportantNames.sysDocId} TEXT,
    //   ${CreateTransferOutReportImportantNames.voucherId} TEXT,
    //   ${CreateTransferOutReportImportantNames.transferTypeId} TEXT,
    //   ${CreateTransferOutReportImportantNames.acceptReference} TEXT,
    //   ${CreateTransferOutReportImportantNames.transactionDate} TEXT,
    //   ${CreateTransferOutReportImportantNames.divisionId} TEXT,
    //   ${CreateTransferOutReportImportantNames.locationFromId} TEXT,
    //   ${CreateTransferOutReportImportantNames.locationToId} TEXT,
    //   ${CreateTransferOutReportImportantNames.vehicleNumber} TEXT,
    //   ${CreateTransferOutReportImportantNames.driverId} TEXT,
    //   ${CreateTransferOutReportImportantNames.reference} TEXT,
    //   ${CreateTransferOutReportImportantNames.description} TEXT,
    //   ${CreateTransferOutReportImportantNames.reason} INTEGER,
    //   ${CreateTransferOutReportImportantNames.isRejectedTransfer} INTEGER,
    //   ${CreateTransferOutReportImportantNames.isSynced} INTEGER,
    //   ${CreateTransferOutReportImportantNames.error} TEXT,
    //   ${CreateTransferOutReportImportantNames.quantity} DOUBLE
    // )
    // ''',
    '''
    CREATE TABLE ${SystemDocumentName.tableName}(
      ${SystemDocumentName.code} TEXT,
      ${SystemDocumentName.name} TEXT,
      ${SystemDocumentName.sysDocType} INTEGER,
      ${SystemDocumentName.locationId} TEXT,
      ${SystemDocumentName.printAfterSave} INTEGER,
      ${SystemDocumentName.doPrint} INTEGER,
      ${SystemDocumentName.printTemplateName} TEXT,
      ${SystemDocumentName.priceIncludeTax} INTEGER,
      ${SystemDocumentName.divisionId} TEXT,
      ${SystemDocumentName.nextNumber} INTEGER,
      ${SystemDocumentName.lastNumber} TEXT,
      ${SystemDocumentName.numberPrefix} TEXT
    )
    ''',
    '''
    CREATE TABLE ${LocationModelName.tableName}(
      ${LocationModelName.code} TEXT,
      ${LocationModelName.name} TEXT
    )
    ''',
    // db.execute('''
    // CREATE TABLE ${UserLocationLocalImportantNames.tableName}(
    //   ${UserLocationLocalImportantNames.code} TEXT,
    //   ${UserLocationLocalImportantNames.name} TEXT
    // )
    // ''');
    '''
    CREATE TABLE ${TransferTypeModelName.tableName}(
      ${TransferTypeModelName.code} TEXT,
      ${TransferTypeModelName.name} TEXT,
      ${TransferTypeModelName.accountId} TEXT,
      ${TransferTypeModelName.locationId} TEXT
    )
    ''',
    // '''
    // CREATE TABLE ${ConnectionModelImpNames.tableName}(
    //    ${ConnectionModelImpNames.connectionName} TEXT,
    //    ${ConnectionModelImpNames.serverIp} TEXT,
    //     ${ConnectionModelImpNames.port} TEXT,
    //     ${ConnectionModelImpNames.databaseName} TEXT,
    //     ${ConnectionModelImpNames.userName} TEXT,
    //     ${ConnectionModelImpNames.password} TEXT
    // )
    // ''',

    // '''
    // CREATE TABLE ${ArrivalReportOpenListNames.tableName}(
    //   ${ArrivalReportOpenListNames.itemId} TEXT,
    //     ${ArrivalReportOpenListNames.sysDoc} TEXT,
    //    ${ArrivalReportOpenListNames.voucherId} TEXT,
    //     ${ArrivalReportOpenListNames.lotNo} TEXT,
    //     ${ArrivalReportOpenListNames.comodityId} TEXT,
    //     ${ArrivalReportOpenListNames.varietyId} TEXT,
    //     ${ArrivalReportOpenListNames.brandId} TEXT,
    //     ${ArrivalReportOpenListNames.itemSize} TEXT,
    //     ${ArrivalReportOpenListNames.grade} TEXT,
    //     ${ArrivalReportOpenListNames.sampleCount} INTEGER,
    //     ${ArrivalReportOpenListNames.issue1Count} INTEGER,
    //     ${ArrivalReportOpenListNames.issue2Count} INTEGER,
    //     ${ArrivalReportOpenListNames.issue3Count} INTEGER,
    //     ${ArrivalReportOpenListNames.issue4Count} INTEGER,
    //     ${ArrivalReportOpenListNames.temperature} TEXT,
    //     ${ArrivalReportOpenListNames.standardWeight} DOUBLE,
    //     ${ArrivalReportOpenListNames.weight} DOUBLE,
    //     ${ArrivalReportOpenListNames.pressure} DOUBLE,
    //     ${ArrivalReportOpenListNames.brix} DOUBLE,
    //     ${ArrivalReportOpenListNames.remarks} TEXT,
    //     ${ArrivalReportOpenListNames.grower} TEXT,
    //     ${ArrivalReportOpenListNames.commodityName} TEXT,
    //     ${ArrivalReportOpenListNames.varietyName} TEXT,
    //     ${ArrivalReportOpenListNames.brandName} TEXT,
    //     ${ArrivalReportOpenListNames.issue1CountDouble} DOUBLE,
    //     ${ArrivalReportOpenListNames.issue2CountDouble} DOUBLE,
    //     ${ArrivalReportOpenListNames.issue3CountDouble} DOUBLE,
    //     ${ArrivalReportOpenListNames.issue4CountDouble} DOUBLE

    // )
    // ''',
//     '''
//     CREATE TABLE ${StockSnapshotHeaderModelNames.tableName}(
//       ${StockSnapshotHeaderModelNames.token} TEXT,
//       ${StockSnapshotHeaderModelNames.sysdocid} TEXT,
//       ${StockSnapshotHeaderModelNames.voucherid} TEXT,
//       ${StockSnapshotHeaderModelNames.companyid} TEXT,
//       ${StockSnapshotHeaderModelNames.divisionid} TEXT,
//       ${StockSnapshotHeaderModelNames.locationid} TEXT,
//       ${StockSnapshotHeaderModelNames.adjustmenttype} TEXT,
//       ${StockSnapshotHeaderModelNames.refrence} TEXT,
//       ${StockSnapshotHeaderModelNames.description} TEXT,
//       ${StockSnapshotHeaderModelNames.isnewrecord} INTEGER,
//       ${StockSnapshotHeaderModelNames.status} INTEGER,
//       ${StockSnapshotHeaderModelNames.transactiondate} TEXT,
//       ${StockSnapshotHeaderModelNames.isSynced} INTEGER,
//       ${StockSnapshotHeaderModelNames.isError} INTEGER,
//       ${StockSnapshotHeaderModelNames.error} TEXT
//     )
// ''',
//    '''
//     CREATE TABLE ${StockSnapshotDetailModelNames.tableName} (
//       ${StockSnapshotDetailModelNames.itemcode} TEXT,
//       ${StockSnapshotDetailModelNames.physicalqty} REAL,
//       ${StockSnapshotDetailModelNames.onhand} REAL,
//       ${StockSnapshotDetailModelNames.remarks} TEXT,
//       ${StockSnapshotDetailModelNames.rowindex} INTEGER,
//       ${StockSnapshotDetailModelNames.unitid} TEXT,
//       ${StockSnapshotDetailModelNames.listrowindex} REAL,
//       ${StockSnapshotDetailModelNames.listsysdocid} TEXT,
//       ${StockSnapshotDetailModelNames.listvoucherid} TEXT,
//       ${StockSnapshotDetailModelNames.refslno} TEXT,
//       ${StockSnapshotDetailModelNames.reftext1} TEXT,
//       ${StockSnapshotDetailModelNames.reftext2} TEXT,
//       ${StockSnapshotDetailModelNames.refnum1} TEXT,
//       ${StockSnapshotDetailModelNames.refnum2} TEXT,
//       ${StockSnapshotDetailModelNames.description} TEXT,
//       ${StockSnapshotDetailModelNames.refdate1} TEXT,
//       ${StockSnapshotDetailModelNames.refdate2} TEXT
//     )
// ''',
    '''
    CREATE TABLE ${DefaultsObjNames.tableName} (
      ${DefaultsObjNames.defaultSalespersonId} TEXT,
      ${DefaultsObjNames.defaultInventoryLocationId} TEXT,
      ${DefaultsObjNames.defaultTransactionLocationId} TEXT,
      ${DefaultsObjNames.defaultTransactionRegisterId} TEXT,
      ${DefaultsObjNames.defaultCompanyDivisionId} TEXT
    )
''',
    '''
    CREATE TABLE ${MenuSecurityObjNames.tableName} (
      ${MenuSecurityObjNames.menuId} TEXT,
      ${MenuSecurityObjNames.subMenuId} TEXT,
      ${MenuSecurityObjNames.dropDownId} TEXT,
      ${MenuSecurityObjNames.enable} INTEGER,
      ${MenuSecurityObjNames.visible} INTEGER,
      ${MenuSecurityObjNames.userId} TEXT,
      ${MenuSecurityObjNames.groupId} TEXT
    )
''',
    '''
    CREATE TABLE ${ScreenSecurityObjNames.tableName} (
      ${ScreenSecurityObjNames.screenId} TEXT,
      ${ScreenSecurityObjNames.viewRight} INTEGER,
      ${ScreenSecurityObjNames.newRight} INTEGER,
      ${ScreenSecurityObjNames.editRight} INTEGER,
      ${ScreenSecurityObjNames.deleteRight} INTEGER,
      ${ScreenSecurityObjNames.userId} TEXT,
      ${ScreenSecurityObjNames.groupId} TEXT
    )
''',
    '''
    CREATE TABLE ${StockSnapshotHeaderModelNames.tableName}(
      ${StockSnapshotHeaderModelNames.token} TEXT,
      ${StockSnapshotHeaderModelNames.sysdocid} TEXT,
      ${StockSnapshotHeaderModelNames.voucherid} TEXT,
      ${StockSnapshotHeaderModelNames.companyid} TEXT,
      ${StockSnapshotHeaderModelNames.divisionid} TEXT,
      ${StockSnapshotHeaderModelNames.locationid} TEXT,
      ${StockSnapshotHeaderModelNames.adjustmenttype} TEXT,
      ${StockSnapshotHeaderModelNames.refrence} TEXT,
      ${StockSnapshotHeaderModelNames.description} TEXT,
      ${StockSnapshotHeaderModelNames.isnewrecord} INTEGER,
      ${StockSnapshotHeaderModelNames.status} INTEGER,
      ${StockSnapshotHeaderModelNames.transactiondate} TEXT,
      ${StockSnapshotHeaderModelNames.isSynced} INTEGER,
      ${StockSnapshotHeaderModelNames.isError} INTEGER,
      ${StockSnapshotHeaderModelNames.error} TEXT
    )
''',
    '''
    CREATE TABLE ${StockSnapshotDetailModelNames.tableName} (
      ${StockSnapshotDetailModelNames.itemcode} TEXT,
      ${StockSnapshotDetailModelNames.physicalqty} REAL,
      ${StockSnapshotDetailModelNames.onhand} REAL,
      ${StockSnapshotDetailModelNames.remarks} TEXT,
      ${StockSnapshotDetailModelNames.rowindex} INTEGER,
      ${StockSnapshotDetailModelNames.unitid} TEXT,
      ${StockSnapshotDetailModelNames.listrowindex} REAL,
      ${StockSnapshotDetailModelNames.listsysdocid} TEXT,
      ${StockSnapshotDetailModelNames.listvoucherid} TEXT,
      ${StockSnapshotDetailModelNames.refslno} TEXT,
      ${StockSnapshotDetailModelNames.reftext1} TEXT,
      ${StockSnapshotDetailModelNames.reftext2} TEXT,
      ${StockSnapshotDetailModelNames.refnum1} TEXT,
      ${StockSnapshotDetailModelNames.refnum2} TEXT,
      ${StockSnapshotDetailModelNames.description} TEXT,
      ${StockSnapshotDetailModelNames.refdate1} TEXT,
      ${StockSnapshotDetailModelNames.refdate2} TEXT
    )
''',
    '''
CREATE TABLE ${LoadingSheetsHeaderModelNames.tableName}(
  ${LoadingSheetsHeaderModelNames.token} TEXT,
  ${LoadingSheetsHeaderModelNames.sysdocid} TEXT,
  ${LoadingSheetsHeaderModelNames.voucherid} TEXT,
  ${LoadingSheetsHeaderModelNames.partyType} TEXT,
  ${LoadingSheetsHeaderModelNames.partyId} TEXT,
  ${LoadingSheetsHeaderModelNames.locationId} TEXT,
  ${LoadingSheetsHeaderModelNames.toLocationId} TEXT,
  ${LoadingSheetsHeaderModelNames.address} TEXT,
  ${LoadingSheetsHeaderModelNames.containerNo} TEXT,
  ${LoadingSheetsHeaderModelNames.driverName} TEXT,
  ${LoadingSheetsHeaderModelNames.vehicleNo} TEXT,
  ${LoadingSheetsHeaderModelNames.phoneNumber} TEXT,
  ${LoadingSheetsHeaderModelNames.salespersonid} TEXT,
  ${LoadingSheetsHeaderModelNames.currencyid} TEXT,
  ${LoadingSheetsHeaderModelNames.transactionDate} TEXT,
  ${LoadingSheetsHeaderModelNames.reference1} TEXT,
  ${LoadingSheetsHeaderModelNames.reference2} TEXT,
  ${LoadingSheetsHeaderModelNames.reference3} TEXT,
  ${LoadingSheetsHeaderModelNames.note} TEXT,
  ${LoadingSheetsHeaderModelNames.documentType} TEXT,
  ${LoadingSheetsHeaderModelNames.startTime} TEXT,
  ${LoadingSheetsHeaderModelNames.endTime} TEXT,
  ${LoadingSheetsHeaderModelNames.isvoid} INTEGER,
  ${LoadingSheetsHeaderModelNames.discount} INTEGER,
  ${LoadingSheetsHeaderModelNames.total} REAL,
  ${LoadingSheetsHeaderModelNames.roundoff} INTEGER,
  ${LoadingSheetsHeaderModelNames.isnewrecord} INTEGER,
  ${LoadingSheetsHeaderModelNames.isSynced} INTEGER,
  ${LoadingSheetsHeaderModelNames.isError} INTEGER,
  ${LoadingSheetsHeaderModelNames.isCompleted} INTEGER,
  ${LoadingSheetsHeaderModelNames.error} TEXT,
  ${LoadingSheetsHeaderModelNames.categories} TEXT
)
''',
    '''
CREATE TABLE ${ItemTransactionDetailsModelNames.tableName}(
  ${ItemTransactionDetailsModelNames.itemCode} TEXT,
  ${ItemTransactionDetailsModelNames.description} TEXT,
  ${ItemTransactionDetailsModelNames.quantity} REAL,
  ${ItemTransactionDetailsModelNames.rowIndex} INTEGER,
  ${ItemTransactionDetailsModelNames.unitId} TEXT,
  ${ItemTransactionDetailsModelNames.unitPrice} INTEGER,
  ${ItemTransactionDetailsModelNames.quantityReturned} REAL,
  ${ItemTransactionDetailsModelNames.quantityShipped} REAL,
  ${ItemTransactionDetailsModelNames.unitQuantity} REAL,
  ${ItemTransactionDetailsModelNames.unitFactor} INTEGER,
  ${ItemTransactionDetailsModelNames.factorType} TEXT,
  ${ItemTransactionDetailsModelNames.subunitPrice} INTEGER,
  ${ItemTransactionDetailsModelNames.jobID} TEXT,
  ${ItemTransactionDetailsModelNames.costCategoryID} TEXT,
  ${ItemTransactionDetailsModelNames.locationID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceVoucherID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceSysDocID} TEXT,
  ${ItemTransactionDetailsModelNames.sourceRowIndex} INTEGER,
  ${ItemTransactionDetailsModelNames.rowSource} TEXT,
  ${ItemTransactionDetailsModelNames.refSlNo} TEXT,
  ${ItemTransactionDetailsModelNames.refText1} TEXT,
  ${ItemTransactionDetailsModelNames.refText2} TEXT,
  ${ItemTransactionDetailsModelNames.refText3} TEXT,
  ${ItemTransactionDetailsModelNames.refText4} TEXT,
  ${ItemTransactionDetailsModelNames.refText5} TEXT,
  ${ItemTransactionDetailsModelNames.refNum1} INTEGER,
  ${ItemTransactionDetailsModelNames.refNum2} INTEGER,
  ${ItemTransactionDetailsModelNames.refDate1} TEXT,
  ${ItemTransactionDetailsModelNames.refDate2} TEXT,
  ${ItemTransactionDetailsModelNames.remarks} TEXT,
  ${ItemTransactionDetailsModelNames.listQuantity} TEXT
)
''',
    '''
CREATE TABLE ${CreateTransferOutImportantNames.tableName}(
  ${CreateTransferOutImportantNames.sysDocId} TEXT,
  ${CreateTransferOutImportantNames.voucherId} TEXT,
  ${CreateTransferOutImportantNames.transferTypeId} TEXT,
  ${CreateTransferOutImportantNames.acceptReference} TEXT,
  ${CreateTransferOutImportantNames.transactionDate} TEXT,
  ${CreateTransferOutImportantNames.divisionId} TEXT,
  ${CreateTransferOutImportantNames.locationFromId} TEXT,
  ${CreateTransferOutImportantNames.locationToId} TEXT,
  ${CreateTransferOutImportantNames.vehicleNumber} TEXT,
  ${CreateTransferOutImportantNames.driverId} TEXT,
  ${CreateTransferOutImportantNames.reference} TEXT,
  ${CreateTransferOutImportantNames.description} TEXT,
  ${CreateTransferOutImportantNames.reason} INTEGER,
  ${CreateTransferOutImportantNames.isRejectedTransfer} INTEGER,
  ${CreateTransferOutImportantNames.isSynced} INTEGER,
  ${CreateTransferOutImportantNames.isError} INTEGER,
  ${CreateTransferOutImportantNames.error} TEXT,
  ${CreateTransferOutImportantNames.quantity} DOUBLE
)
''',

    '''
CREATE TABLE ${CreateTransferOutDetailsImportantNames.tableName}(
  ${CreateTransferOutDetailsImportantNames.sysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.voucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.remarks} TEXT,
  ${CreateTransferOutDetailsImportantNames.acceptedFactorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.productId} TEXT,
  ${CreateTransferOutDetailsImportantNames.description} TEXT,
  ${CreateTransferOutDetailsImportantNames.rowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.sourceDocType} INTEGER,
  ${CreateTransferOutDetailsImportantNames.sourceRowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.listRowIndex} INTEGER,
  ${CreateTransferOutDetailsImportantNames.listVoucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.listSysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.sourceVoucherId} TEXT,
  ${CreateTransferOutDetailsImportantNames.sourceSysDocId} TEXT,
  ${CreateTransferOutDetailsImportantNames.isSourcedRow} TEXT,
  ${CreateTransferOutDetailsImportantNames.isTrackLot} INTEGER,
  ${CreateTransferOutDetailsImportantNames.isTrackSerial} INTEGER,
  ${CreateTransferOutDetailsImportantNames.acceptedQuantity} DOUBLE,
  ${CreateTransferOutDetailsImportantNames.acceptedUnitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.acceptedFactor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedUnitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.rejectedFactor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.quantity} DOUBLE,
  ${CreateTransferOutDetailsImportantNames.unitQuantity} INTEGER,
  ${CreateTransferOutDetailsImportantNames.factor} INTEGER,
  ${CreateTransferOutDetailsImportantNames.factorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.rejectedFactorType} TEXT,
  ${CreateTransferOutDetailsImportantNames.unitId} TEXT
)
''',
    '''
CREATE TABLE ${VendorModelImportantNames.tableName}(
  ${VendorModelImportantNames.code} TEXT,
  ${VendorModelImportantNames.name} TEXT,
  ${VendorModelImportantNames.searchColumn} TEXT,
  ${VendorModelImportantNames.currencyId} TEXT,
  ${VendorModelImportantNames.parentVendorId} TEXT,
  ${VendorModelImportantNames.allowConsignment} INTEGER,
  ${VendorModelImportantNames.allowOap} INTEGER,
  ${VendorModelImportantNames.consignComPercent} REAL,
  ${VendorModelImportantNames.shippingMethodId} TEXT,
  ${VendorModelImportantNames.paymentTermId} TEXT,
  ${VendorModelImportantNames.paymentMethodId} TEXT,
  ${VendorModelImportantNames.buyerId} TEXT,
  ${VendorModelImportantNames.primaryAddressId} TEXT,
  ${VendorModelImportantNames.vendorClassId} TEXT,
  ${VendorModelImportantNames.taxOption} INTEGER,
  ${VendorModelImportantNames.taxGroupId} TEXT
)
''',
    '''
CREATE TABLE ${CustomerListImportantNames.tableName}(
  ${CustomerListImportantNames.code} TEXT,
  ${CustomerListImportantNames.name} TEXT,
  ${CustomerListImportantNames.searchColumn} TEXT,
  ${CustomerListImportantNames.currencyId} TEXT,
  ${CustomerListImportantNames.allowConsignment} INTEGER,
  ${CustomerListImportantNames.isHold} INTEGER,
  ${CustomerListImportantNames.priceLevelId} TEXT,
  ${CustomerListImportantNames.balance} INTEGER,
  ${CustomerListImportantNames.parentCustomerId} TEXT,
  ${CustomerListImportantNames.paymentTermId} TEXT,
  ${CustomerListImportantNames.paymentMethodId} TEXT,
  ${CustomerListImportantNames.shippingMethodId} TEXT,
  ${CustomerListImportantNames.billToAddressId} TEXT,
  ${CustomerListImportantNames.shipToAddressId} TEXT,
  ${CustomerListImportantNames.salesPersonId} TEXT,
  ${CustomerListImportantNames.isWeightInvoice} INTEGER,
  ${CustomerListImportantNames.customerClassId} TEXT,
  ${CustomerListImportantNames.taxOption} INTEGER,
  ${CustomerListImportantNames.taxGroupId} TEXT,
  ${CustomerListImportantNames.childCustomers} INTEGER,
  ${CustomerListImportantNames.isLpo} INTEGER,
  ${CustomerListImportantNames.isPro} INTEGER,
  ${CustomerListImportantNames.mobile} TEXT
)
''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.originTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.categoryTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.classTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.brandTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.customerSalesPersonTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.driverTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${ProductCommonComboModelName.vehicleTableName}(
      ${ProductCommonComboModelName.code} TEXT,
      ${ProductCommonComboModelName.name} TEXT
    )
    ''',
    '''
    CREATE TABLE ${UserLocationModelName.tableName}(
      ${UserLocationModelName.code} TEXT,
      ${UserLocationModelName.name} TEXT,
      ${UserLocationModelName.isConsignInLocation} INTEGER,
      ${UserLocationModelName.isConsignOutLocation} INTEGER,
      ${UserLocationModelName.isposLocation} REAL,
      ${UserLocationModelName.isWarehouse} REAL,
      ${UserLocationModelName.isQuarantine} INTEGER,
      ${UserLocationModelName.isUserLocation} TEXT

    )
    ''',
    '''
      CREATE TABLE ${GoodsRecieveNoteHeaderModelNames.tableName} (
        ${GoodsRecieveNoteHeaderModelNames.isnewrecord} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.sysdocid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.voucherid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.companyid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.divisionid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vendorID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.transporterID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.termID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.transactiondate} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.purchaseFlow} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.currencyid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.currencyrate} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.shippingmethodid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.reference} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.reference2} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vendorReferenceNo} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.note} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.isvoid} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isImport} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.payeetaxgroupid} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.taxoption} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.driverID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.vehicleID} TEXT,
        ${GoodsRecieveNoteHeaderModelNames.advanceamount} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.activateGRNEdit} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isSynced} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.isError} INTEGER,
        ${GoodsRecieveNoteHeaderModelNames.error} TEXT
      )
    ''',
    '''
        CREATE TABLE ${GRNDetailsModelNames.tableName} (
          ${GRNDetailsModelNames.voucherId} TEXT,
          ${GRNDetailsModelNames.itemcode} TEXT,
          ${GRNDetailsModelNames.description} TEXT,
          ${GRNDetailsModelNames.quantity} INTEGER,
          ${GRNDetailsModelNames.refSlNo} INTEGER,
          ${GRNDetailsModelNames.refText1} TEXT,
          ${GRNDetailsModelNames.refText2} TEXT,
          ${GRNDetailsModelNames.refNum1} INTEGER,
          ${GRNDetailsModelNames.refNum2} INTEGER,
          ${GRNDetailsModelNames.refDate1} TEXT,
          ${GRNDetailsModelNames.refDate2} TEXT,
          ${GRNDetailsModelNames.locationid} TEXT,
          ${GRNDetailsModelNames.jobid} TEXT,
          ${GRNDetailsModelNames.costcategoryid} TEXT,
          ${GRNDetailsModelNames.unitprice} REAL,
          ${GRNDetailsModelNames.unitID} TEXT,
          ${GRNDetailsModelNames.remarks} TEXT,
          ${GRNDetailsModelNames.rowindex} INTEGER,
          ${GRNDetailsModelNames.jobSubCategoryid} TEXT,
          ${GRNDetailsModelNames.jobCategoryid} TEXT,
          ${GRNDetailsModelNames.specificationID} TEXT,
          ${GRNDetailsModelNames.taxoption} INTEGER,
          ${GRNDetailsModelNames.taxGroupID} TEXT,
          ${GRNDetailsModelNames.styleid} TEXT,
          ${GRNDetailsModelNames.itemtype} INTEGER,
          ${GRNDetailsModelNames.isNew} INTEGER,
          ${GRNDetailsModelNames.cost} REAL,
          ${GRNDetailsModelNames.amount} REAL,
          ${GRNDetailsModelNames.rowSource} INTEGER
        )
      ''',
    '''
        CREATE TABLE ${ProductLotReceivingDetailModelNames.tableName} (
          ${ProductLotReceivingDetailModelNames.sysdocid} TEXT,
          ${ProductLotReceivingDetailModelNames.voucherid} TEXT,
          ${ProductLotReceivingDetailModelNames.productID} TEXT,
          ${ProductLotReceivingDetailModelNames.unitID} TEXT,
          ${ProductLotReceivingDetailModelNames.locationId} TEXT,
          ${ProductLotReceivingDetailModelNames.lotNumber} TEXT,
          ${ProductLotReceivingDetailModelNames.reference} TEXT,
          ${ProductLotReceivingDetailModelNames.sourceLotNumber} TEXT,
          ${ProductLotReceivingDetailModelNames.quantity} INTEGER,
          ${ProductLotReceivingDetailModelNames.binID} TEXT,
          ${ProductLotReceivingDetailModelNames.reference2} TEXT,
          ${ProductLotReceivingDetailModelNames.unitPrice} REAL,
          ${ProductLotReceivingDetailModelNames.rowIndex} INTEGER,
          ${ProductLotReceivingDetailModelNames.cost} REAL,
          ${ProductLotReceivingDetailModelNames.soldQty} REAL,
          ${ProductLotReceivingDetailModelNames.rackID} TEXT,
          ${ProductLotReceivingDetailModelNames.lotQty} INTEGER,
          ${ProductLotReceivingDetailModelNames.expiryDate} TEXT,
          ${ProductLotReceivingDetailModelNames.refSlNo} INTEGER,
          ${ProductLotReceivingDetailModelNames.refext1} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext2} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext3} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext4} TEXT,
          ${ProductLotReceivingDetailModelNames.reftext5} TEXT,
          ${ProductLotReceivingDetailModelNames.refNum1} INTEGER,
          ${ProductLotReceivingDetailModelNames.refNum2} INTEGER,
          ${ProductLotReceivingDetailModelNames.refDate1} TEXT,
          ${ProductLotReceivingDetailModelNames.refDate2} TEXT
        )
      ''',
    '''
    CREATE TABLE ${TaxGroupModelName.tableName}(
      ${TaxGroupModelName.code} TEXT,
      ${TaxGroupModelName.name} TEXT,
      ${TaxGroupModelName.taxRate} INTEGER
    )
    ''',
  ];
}
