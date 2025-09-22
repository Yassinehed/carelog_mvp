import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/core/presentation/widgets/material_stats_card.dart';
import 'package:carelog_mvp/core/presentation/providers/dashboard_providers.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

void main() {
  testWidgets('MaterialStatsCard shows stats and progress bar', (WidgetTester tester) async {
    const fakeStats = DashboardStats(
      ofOrders: OfOrderStats(total: 0, active: 0, completed: 0),
      signalements: SignalementStats(total: 0, open: 0, urgent: 0),
      materials: MaterialStats(total: 10, lowStock: 2),
    );

    await tester.pumpWidget(ProviderScope(
      overrides: [
  // Override the FutureProvider to immediately return our fake stats
  dashboardStatsProvider.overrideWith((ref) => Future.value(fakeStats)),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: MaterialStatsCard(),
        ),
      ),
    ));

    // Wait for frames
    await tester.pumpAndSettle();

    // Expect to find the materials label (from localization key, but the widget uses AppLocalizations; we check for Icon and number text)
    expect(find.byIcon(Icons.inventory), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    // Progress indicator should be present
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
