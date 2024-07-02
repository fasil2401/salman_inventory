


import 'package:axolon_inventory_manager/model/Pdf%20Models/location.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/transaction.dart';

class Invoice {
  final InvoiceInfo info;
  final Transaction transaction;
  final Location location;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.transaction,
    required this.location,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final int number;
  final String itemCode;
  final String itemDescription;
  final String unit;
  final double transferQty;

  const InvoiceItem({
    required this.number,
    required this.itemCode,
    required this.itemDescription,
    required this.unit,
    required this.transferQty,
  });
}
