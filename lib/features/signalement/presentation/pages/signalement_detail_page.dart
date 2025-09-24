import 'package:flutter/material.dart';
import '../../domain/entities/signalement.dart';
import '../../../pdf/pdf_generator.dart';
import '../../../pdf/pdf_preview_page.dart';
import '../../../../l10n/app_localizations.dart';

class SignalementDetailPage extends StatelessWidget {
  final Signalement signalement;

  const SignalementDetailPage({Key? key, required this.signalement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.signalementListTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(signalement.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Type: ${signalement.type.name}'),
            Text('Severity: ${signalement.severity.name}'),
            Text('Status: ${signalement.status.name}'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.picture_as_pdf),
                label: Text('Esporta PDF'),
                onPressed: () {
                  // Map domain Signalement to PDF model
                  final pdfModel = SignalementPdfModel(
                    id: signalement.id,
                    title: 'Signalement ${signalement.id}',
                    description: signalement.description,
                    createdAt: signalement.createdAt,
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PdfPreviewPage(model: pdfModel),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
