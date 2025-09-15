import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/material/presentation/providers/material_providers.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class MaterialListPage extends ConsumerWidget {
  const MaterialListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsAsync = ref.watch(materialsProvider);
    final lowStockAsync = ref.watch(lowStockMaterialsProvider);
    final outOfStockAsync = ref.watch(outOfStockMaterialsProvider);

    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.materialsPageTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.materialsTab_all),
              Tab(text: l10n.materialsTab_lowStock),
              Tab(text: l10n.materialsTab_outOf_stock),
              Tab(text: l10n.materialsTab_alerts),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to create material page
                Navigator.of(context).pushNamed('/materials/create');
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // All Materials Tab
            materialsAsync.when(
              data: (materials) => ListView.builder(
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  final material = materials[index];
                  return MaterialListTile(material: material);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text(l10n.genericError(error))),
            ),

            // Low Stock Tab
            lowStockAsync.when(
              data: (materials) => ListView.builder(
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  final material = materials[index];
                  return MaterialListTile(
                      material: material, highlightLowStock: true);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text(l10n.genericError(error))),
            ),

            // Out of Stock Tab
            outOfStockAsync.when(
              data: (materials) => ListView.builder(
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  final material = materials[index];
                  return MaterialListTile(
                      material: material, highlightOutOfStock: true);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text(l10n.genericError(error))),
            ),

            // Alerts Tab
            ref.watch(stockAlertsProvider).when(
                  data: (alerts) => ListView.builder(
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      final alert = alerts[index];
                      return ListTile(
                        title: Text(alert.materialName),
                        subtitle: Text(alert.message),
                        leading: Icon(
                          Icons.warning,
                          color: alert.alertType == 'out_of_stock'
                              ? Colors.red
                              : Colors.orange,
                        ),
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Center(child: Text(l10n.genericError(error))),
                ),
          ],
        ),
      ),
    );
  }
}

class MaterialListTile extends StatelessWidget {
  final dynamic material;
  final bool highlightLowStock;
  final bool highlightOutOfStock;

  const MaterialListTile({
    super.key,
    required this.material,
    this.highlightLowStock = false,
    this.highlightOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final stockStatus = material.currentStock <= 0
        ? l10n.stockStatus_out
        : material.currentStock <= material.minimumStock
            ? l10n.stockStatus_low
            : l10n.stockStatus_in;

    final stockColor = material.currentStock <= 0
        ? Colors.red
        : material.currentStock <= material.minimumStock
            ? Colors.orange
            : Colors.green;

    return ListTile(
      title: Text(material.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.referencePrefix(material.reference)),
          Text(l10n.stockPrefix(
              material.currentStock, material.unitOfMeasure.name)),
          Text(
            '${l10n.statusLabel}: $stockStatus',
            style: TextStyle(color: stockColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.typeLabelUpper(material.type.name.toUpperCase())),
          Text(
            l10n.stockFraction(material.currentStock, material.maximumStock),
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      onTap: () {
        // Navigate to material detail page
        Navigator.of(context).pushNamed('/materials/${material.id}');
      },
    );
  }
}
