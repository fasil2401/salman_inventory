import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Components {
  static Widget buildPdfView(Uint8List bytes) {
    return PDFView(
      pdfData: bytes,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageSnap: false,
      pageFling: false,
      fitPolicy: FitPolicy.WIDTH,
    );
  }
}
