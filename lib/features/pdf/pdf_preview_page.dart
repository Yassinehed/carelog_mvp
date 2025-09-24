import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'pdf_generator.dart';

class PdfPreviewPage extends StatelessWidget {
  final SignalementPdfModel model;

  const PdfPreviewPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: PdfPreview(
        build: (format) async => await generateSignalementPdf(model),
        allowPrinting: true,
        allowSharing: true,
      ),
    );
  }
}
