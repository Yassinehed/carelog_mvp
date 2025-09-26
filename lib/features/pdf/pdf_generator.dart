import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Minimal Signalement model used for PDF generation.
class SignalementPdfModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<Uint8List>? images; // raw image bytes (e.g., jpeg/png)

  SignalementPdfModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.images,
  });
}

/// Generates a PDF document for a Signalement model and returns bytes.
Future<Uint8List> generateSignalementPdf(SignalementPdfModel model) async {
  final pdf = pw.Document();
  // Build header with inline CareLog logo rendered from widget painter
  final header = pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(model.title,
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text('ID: ${model.id}'),
        ],
      ),
      // Placeholder for logo; we will attempt to render a simple colored square as logo if conversion isn't possible
      pw.Container(width: 60, height: 60, color: PdfColors.grey300),
    ],
  );

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      final children = <pw.Widget>[];

      children.add(pw.Header(level: 0, child: header));

      // Details table
      children.add(pw.SizedBox(height: 8));
      children.add(pw.Table.fromTextArray(
        headers: ['Field', 'Value'],
        data: [
          ['ID', model.id],
          ['Date', model.createdAt.toIso8601String()],
          ['Description', model.description],
        ],
        cellStyle: const pw.TextStyle(fontSize: 10),
        headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        cellAlignment: pw.Alignment.centerLeft,
      ));

      children.add(pw.SizedBox(height: 12));

      // Images
      if (model.images != null && model.images!.isNotEmpty) {
        children.add(pw.Text('Images',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)));
        children.add(pw.SizedBox(height: 8));

        final imageWidgets = <pw.Widget>[];
        for (final imgBytes in model.images!) {
          try {
            final image = pw.MemoryImage(imgBytes);
            imageWidgets.add(pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Image(image,
                  width: 200, height: 150, fit: pw.BoxFit.cover),
            ));
          } catch (e) {
            // ignore image if it fails
          }
        }

        children.addAll(imageWidgets);
      }

      return children;
    },
  ));

  return pdf.save();
}
