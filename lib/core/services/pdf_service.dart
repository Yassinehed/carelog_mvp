import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../data/models/of_order_model.dart';
import '../../data/models/signalement_model.dart';
import '../../data/models/material_model.dart' as material_model;

/// Service for generating PDF documents for CareLog
class PdfService {
  static const String companyName = 'APF ENTREPRISE';
  static const String companyAddress = 'Adresse de l\'entreprise';
  static const String companyPhone = '+33 X XX XX XX XX';
  static const String companyEmail = 'contact@apf-entreprise.fr';

  /// Generate PDF for OF Order
  Future<Uint8List> generateOfOrderPdf(OfOrder order) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _buildOfOrderContent(order),
        ],
      ),
    );

    return pdf.save();
  }

  /// Generate PDF for Signalement Report
  Future<Uint8List> generateSignalementPdf(Signalement signalement) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _buildSignalementContent(signalement),
        ],
      ),
    );

    return pdf.save();
  }

  /// Generate PDF for Material Inventory Report
  Future<Uint8List> generateMaterialReportPdf(List<material_model.Material> materials) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _buildMaterialReportContent(materials),
        ],
      ),
    );

    return pdf.save();
  }

  /// Preview PDF document
  Future<void> previewPdf(Uint8List pdfData, String fileName) async {
    await Printing.sharePdf(bytes: pdfData, filename: fileName);
  }

  /// Download PDF document
  Future<void> downloadPdf(Uint8List pdfData, String fileName) async {
    await Printing.sharePdf(bytes: pdfData, filename: fileName);
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        children: [
          pw.Text(
            companyName,
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            companyAddress,
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            'Tél: $companyPhone | Email: $companyEmail',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Divider(thickness: 2, color: PdfColors.blue900),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Column(
        children: [
          pw.Divider(thickness: 1, color: PdfColors.grey400),
          pw.SizedBox(height: 8),
          pw.Text(
            'Document généré le ${DateTime.now().toString().split(' ')[0]}',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
          pw.Text(
            'CareLog - Système de Gestion Logistique',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildOfOrderContent(OfOrder order) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'ORDRE DE FABRICATION',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.SizedBox(height: 20),
        _buildInfoRow('Numéro OF:', order.ofNumber),
        _buildInfoRow('Client:', order.clientName),
        _buildInfoRow('Produit:', order.title),
        _buildInfoRow('Quantité:', order.plannedQuantity.toString()),
        _buildInfoRow('Date de création:', order.createdAt.toString().split(' ')[0]),
        _buildInfoRow('Statut:', order.status.toString().split('.').last),
        pw.SizedBox(height: 20),
        if (order.description.isNotEmpty) ...[
          pw.Text(
            'Description:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(order.description),
        ],
      ],
    );
  }

  pw.Widget _buildSignalementContent(Signalement signalement) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RAPPORT DE SIGNALEMENT',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.red900,
          ),
        ),
        pw.SizedBox(height: 20),
        _buildInfoRow('Numéro:', signalement.id),
        _buildInfoRow('Type:', signalement.category.toString().split('.').last),
        _buildInfoRow('Priorité:', signalement.priority.toString().split('.').last),
        _buildInfoRow('Statut:', signalement.status.toString().split('.').last),
        _buildInfoRow('Date de création:', signalement.createdAt.toString().split(' ')[0]),
        _buildInfoRow('Auteur:', signalement.createdBy),
        pw.SizedBox(height: 20),
        pw.Text(
          'Description:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(signalement.description),
        if (signalement.resolutionNotes?.isNotEmpty ?? false) ...[
          pw.SizedBox(height: 20),
          pw.Text(
            'Solution proposée:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(signalement.resolutionNotes ?? ''),
        ],
      ],
    );
  }

  pw.Widget _buildMaterialReportContent(List<material_model.Material> materials) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RAPPORT D\'INVENTAIRE MATÉRIAUX',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.green900,
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Text(
          'Date de génération: ${DateTime.now().toString().split(' ')[0]}',
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.SizedBox(height: 20),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _buildTableHeader('Nom'),
                _buildTableHeader('Référence'),
                _buildTableHeader('Stock'),
                _buildTableHeader('Seuil'),
                _buildTableHeader('Statut'),
              ],
            ),
            ...materials.map((material) => pw.TableRow(
              children: [
                _buildTableCell(material.name),
                _buildTableCell(material.reference),
                _buildTableCell(material.currentStock.toString()),
                _buildTableCell(material.minimumStock.toString()),
                _buildTableCell(_getStockStatusText(material)),
              ],
            )),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
      ),
    );
  }

  String _getStockStatusText(material_model.Material material) {
    if (material.currentStock <= material.minimumStock) {
      return 'Stock faible';
    } else if (material.currentStock == 0) {
      return 'Rupture';
    } else {
      return 'En stock';
    }
  }
}