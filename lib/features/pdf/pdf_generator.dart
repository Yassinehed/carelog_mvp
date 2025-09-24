import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
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
  // Load CareLog PNG asset for header logo (if available)
  pw.Widget logoWidget = pw.Container(width: 60, height: 60, color: PdfColors.grey300);
  try {
    final bytes = await rootBundle.load('assets/images/carelog_logo.png');
    final list = bytes.buffer.asUint8List();
    // validate PNG bytes by attempting to decode with `package:image`
    try {
      final decoded = img.decodeImage(list);
      if (decoded != null) {
        final memImage = pw.MemoryImage(list);
        logoWidget = pw.Container(width: 60, height: 60, child: pw.Image(memImage, fit: pw.BoxFit.contain));
      }
    } catch (e) {
      // If decoding fails, keep placeholder
    }
  } catch (e) {
    // keep placeholder if asset not found
  }

  // Build header with CareLog logo
  final header = pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(model.title, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text('ID: ${model.id}'),
        ],
      ),
      logoWidget,
    ],
  );

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      final children = <pw.Widget>[];

      children.add(pw.Header(level: 0, child: header));

      // Details table
      children.add(pw.SizedBox(height: 8));
      children.add(pw.TableHelper.fromTextArray(
        context: context,
        headers: ['Field', 'Value'],
        data: [
          ['ID', model.id],
          ['Date', model.createdAt.toIso8601String()],
          ['Description', model.description],
        ],
        cellStyle: pw.TextStyle(fontSize: 10),
        headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
        cellAlignment: pw.Alignment.centerLeft,
      ));

      children.add(pw.SizedBox(height: 12));

      // Images
      if (model.images != null && model.images!.isNotEmpty) {
        children.add(pw.Text('Images', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)));
        children.add(pw.SizedBox(height: 8));

        final imageWidgets = <pw.Widget>[];
        for (final imgBytes in model.images!) {
          try {
            // validate image bytes decode before handing to pw.MemoryImage -
            // package:pdf decodes images during Document.save which can throw
            // and fail the whole PDF generation. Use package:image to pre-validate.
            final decoded = img.decodeImage(imgBytes);
            if (decoded == null) continue;
            final image = pw.MemoryImage(imgBytes);
            imageWidgets.add(pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Image(image, width: 200, height: 150, fit: pw.BoxFit.cover),
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
