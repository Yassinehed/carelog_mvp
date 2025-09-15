import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/material/presentation/providers/material_providers.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class MaterialStatsWidget extends ConsumerWidget {
  const MaterialStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(materialStatisticsProvider);

    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.materialStats_totalMaterials,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            statsAsync.when(
              data: (stats) => Column(
                children: [
                  _buildStatRow(l10n.materialStats_totalMaterials,
                      stats.totalMaterials.toString()),
                  _buildStatRow(l10n.materialStats_activeMaterials,
                      stats.activeMaterials.toString()),
                  _buildStatRow(
                      l10n.materialStats_inStock, stats.inStock.toString()),
                  _buildStatRow(
                      l10n.materialStats_lowStock, stats.lowStock.toString()),
                  _buildStatRow(l10n.materialStats_outOfStock,
                      stats.outOfStock.toString()),
                  _buildStatRow(
                      l10n.materialStats_expired, stats.expired.toString()),
                  _buildStatRow(l10n.materialStats_expiringSoon,
                      stats.expiringSoon.toString()),
                  _buildStatRow(l10n.materialStats_totalValue,
                      '\$${stats.totalInventoryValue.toStringAsFixed(2)}'),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Text(
                  l10n.genericError(error),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
