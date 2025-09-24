import 'package:flutter_test/flutter_test.dart';
import 'package:carelog_mvp/features/pdf/pdf_generator.dart';
import 'dart:convert';

void main() {
  test('generateSignalementPdf returns non-empty bytes', () async {
    final model = SignalementPdfModel(
      id: 's1',
      title: 'Test Signalement',
      description: 'This is a sample description for testing.',
      createdAt: DateTime.parse('2025-09-24T12:00:00Z'),
      images: [
        base64Decode(
            'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII='),
      ],
    );

    final bytes = await generateSignalementPdf(model);
    expect(bytes, isNotNull);
    expect(bytes.length, greaterThan(0));
  });
}
