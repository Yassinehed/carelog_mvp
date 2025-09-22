import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/of_order.dart';

/// Widget per mostrare i materiali utilizzati nell'ordine di fabbricazione
class OfOrderMaterialsWidget extends StatelessWidget {
  final OfOrder ofOrder;

  const OfOrderMaterialsWidget({
    super.key,
    required this.ofOrder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Per ora mostriamo materiali di esempio
    // In futuro questi verranno dal database collegato all'ordine
    final materials = _getSampleMaterials();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.materialsUsedTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    l10n.materialsCount(materials.length),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (materials.isEmpty)
              _buildEmptyState(context)
            else
              ...materials.map((material) => _buildMaterialItem(context, material)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noMaterialsAssociated,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.materialsWillBeShown,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialItem(BuildContext context, Map<String, dynamic> material) {
    final l10n = AppLocalizations.of(context)!;
    final quantity = material['quantity'] as int;
    final unit = material['unit'] as String;
    final status = material['status'] as String;

    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'available':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'low_stock':
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        break;
      case 'out_of_stock':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Icona del materiale
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.inventory_2,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Informazioni del materiale
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material['name'] as String,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  material['code'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      statusIcon,
                      size: 16,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusText(context, status),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantità richiesta
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$quantity $unit',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.requiredLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'available':
        return l10n.materialStatus_available;
      case 'low_stock':
        return l10n.materialStatus_low_stock;
      case 'out_of_stock':
        return l10n.materialStatus_out_of_stock;
      default:
        return l10n.materialStatus_unknown;
    }
  }

  List<Map<String, dynamic>> _getSampleMaterials() {
    // Materiali di esempio per la demo
    // In futuro questi verranno dal database
    return [
      {
        'name': 'Tela Cotone 200g/m²',
        'code': 'MAT-001',
        'quantity': 50,
        'unit': 'm²',
        'status': 'available',
      },
      {
        'name': 'Filo Poliestere 1000m',
        'code': 'MAT-002',
        'quantity': 25,
        'unit': 'bobine',
        'status': 'low_stock',
      },
      {
        'name': 'Bottoni Plastica 15mm',
        'code': 'MAT-003',
        'quantity': 200,
        'unit': 'pz',
        'status': 'available',
      },
      {
        'name': 'Cerniera Lampo 60cm',
        'code': 'MAT-004',
        'quantity': 30,
        'unit': 'pz',
        'status': 'out_of_stock',
      },
    ];
  }
}