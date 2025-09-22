import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DI static smoke test: injection.config.dart contains key registrations',
    () async {
  final configFile = File('lib/injection.config.dart');
  expect(await configFile.exists(), isTrue,
    reason: 'Generated file lib/injection.config.dart should exist');

  final content = await configFile.readAsString();

  // Look for the factory registrations for repository implementations
  expect(
    content.contains('OfOrderRepositoryImpl'), isTrue,
    reason:
      'injection.config.dart should reference OfOrderRepositoryImpl');

  expect(
    content.contains('SignalementRepositoryImpl'), isTrue,
    reason:
      'injection.config.dart should reference SignalementRepositoryImpl');

  // Also check the file contains both interface and implementation identifiers
  expect(content.contains('OfOrderRepository'), isTrue,
    reason: 'injection.config.dart should reference OfOrderRepository interface');
  expect(content.contains('SignalementRepository'), isTrue,
    reason: 'injection.config.dart should reference SignalementRepository interface');

  expect(content.contains('OfOrderRepositoryImpl'), isTrue,
    reason: 'injection.config.dart should reference OfOrderRepositoryImpl');
  expect(content.contains('SignalementRepositoryImpl'), isTrue,
    reason: 'injection.config.dart should reference SignalementRepositoryImpl');
  });
}
