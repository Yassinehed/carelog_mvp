import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Minimal Signalement model used for PDF generation.
class SignalementPdfModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  SignalementPdfModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}

/// Generates a PDF document for a Signalement model and returns bytes.
Future<Uint8List> generateSignalementPdf(SignalementPdfModel model) async {
  final pdf = pw.Document();

  final header = pw.Text('${model.title}', style: pw.TextStyle(fontSize: 20));

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) => [
      pw.Header(level: 0, child: header),
      pw.Paragraph(text: 'ID: ${model.id}'),
      pw.Paragraph(text: 'Date: ${model.createdAt.toIso8601String()}'),
      pw.SizedBox(height: 10),
      pw.Text('Descrizione', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
      pw.Paragraph(text: model.description),
    ],
  ));

  return pdf.save();
}
