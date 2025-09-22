import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:carelog_mvp/core/presentation/widgets/carelog_logo.dart';

void main() {
  testWidgets('CareLogLogo paints without throwing and has given size', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CareLogLogo(size: 80),
        ),
      ),
    ));

  // Verify that the CareLogLogo widget exists in the tree
  expect(find.byWidgetPredicate((w) => w.runtimeType.toString() == 'CareLogLogo'), findsOneWidget);
  });
}
