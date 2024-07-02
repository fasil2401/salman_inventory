import 'dart:io';
import 'package:axolon_inventory_manager/model/Pdf%20Models/invoice.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/location.dart';
import 'package:axolon_inventory_manager/model/Pdf%20Models/transaction.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/utils/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(invoice),
        // Divider(),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildTotal(invoice),
        pw.Expanded(child: SizedBox()),
        buildFooter(invoice)
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildTransferNumber(invoice.transaction),
            SizedBox(height: 1 * PdfPageFormat.cm),
            buildTransferLocation(invoice.location),
          ]),
          pw.Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            buildDate(invoice.transaction),
            SizedBox(height: 1 * PdfPageFormat.cm),
            buildInvoiceInfo(invoice.info),
          ])
          // SizedBox(height: 1 * PdfPageFormat.cm),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     buildSupplierAddress(invoice.supplier),
          //     buildDate(invoice.supplier)
          //     // Container(
          //     //   height: 50,
          //     //   width: 50,
          //     //   child: BarcodeWidget(
          //     //     barcode: Barcode.qrCode(),
          //     //     data: invoice.info.number,
          //     //   ),
          //     // ),
          //   ],
          // ),
          // SizedBox(height: 1 * PdfPageFormat.cm),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     buildCustomerAddress(invoice.customer),
          //     buildInvoiceInfo(invoice.info),
          //   ],
          // ),
        ],
      );

  static Widget buildTransferLocation(Location location) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location:', style: TextStyle(fontWeight: FontWeight.bold)),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Transfer From:',
              ),
              SizedBox(width: 5),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(location.locationFromcode),
                  pw.Text(location.locationFromname),
                ],
              )
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Transfer To    :',
              ),
              SizedBox(width: 5),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(location.locationTocode),
                  pw.Text(location.locationToname),
                ],
              )
            ],
          ),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Vehicle Number',
      'Driver Name ',
      'Driver Number',
    ];
    // final data = <String>[
    //   info.number,
    //   Utils.formatDate(info.date),
    //   paymentTerms,
    //   Utils.formatDate(info.dueDate),
    // ];
    final data = <String>[
      '',
      '',
      '',
    ];

    return pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Details:', style: TextStyle(fontWeight: FontWeight.bold)),
      pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(titles.length, (index) {
          final title = titles[index];
          final value = data[index];

          return buildText(title: title, value: value, width: 200);
        }),
      )
    ]);
  }

  static Widget buildTransferNumber(Transaction transaction) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ISSUE INVENTORY TRANSFER',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Text(transaction.transferNumber),
        ],
      );

  static Widget buildDate(Transaction transaction) => pw.Container(
          // decoration: pw.BoxDecoration(
          //   // border: pw.Border.all(
          //   //   color: PdfColors.black,
          //   //   width: 1,
          //   // ),
          // ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(transaction.transferNumber,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: PdfColors.red)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Text('Date: ${Utils.formatDate(DateTime.now())}'),
        ],
      ));

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'No  ',
      'Item Code',
      'Item Description',
      'Unit   ',
      'Transfer Qty',
    ];
    final data = invoice.items.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.number,
        item.itemCode,
        item.itemDescription,
        item.unit,
        item.transferQty,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder.all(width: 0.5, color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        // 5: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.transferQty)
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    final total = netTotal;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildText(
                //   title: 'Net total',
                //   value: Utils.formatPrice(netTotal),
                //   unite: true,
                // ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                buildText(
                  title: 'Total ',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  // value: Utils.formatPrice(total),
                  value: total.toString(),
                  unite: true,
                ),
                SizedBox(height: 1 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => pw.Container(
      height: 2 * PdfPageFormat.cm,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: PdfColors.black,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(),
          SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Column(children: [
                  Container(height: 2, color: PdfColors.black),
                  pw.Text('Prepared By')
                ]),
                pw.Column(children: [
                  Container(height: 2, color: PdfColors.black),
                  pw.Text('Drivers Name & Signature')
                ]),
                pw.Column(children: [
                  Container(height: 2, color: PdfColors.black),
                  pw.Text('Recievers Signature')
                ])
              ]),
          // buildSimpleText(
          //     title: 'Address', value: invoice.transaction.transferNumber),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(
          //     title: 'Paypal', value: invoice.transaction.transferNumber),
        ],
      ));

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle();

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(':$value', style: unite ? style : null),
          pw.Spacer(flex: 1),
        ],
      ),
    );
  }
}
