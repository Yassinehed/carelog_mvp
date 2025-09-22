import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/of_order.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

/// Widget per mostrare le informazioni dettagliate di un ordine di fabbricazione
class OfOrderDetailCard extends StatelessWidget {
  final OfOrder ofOrder;

  const OfOrderDetailCard({
    super.key,
    required this.ofOrder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'it_IT');

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
            // Header con ID e stato
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.ofOrderNumber(ofOrder.id),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(ofOrder.createdAt),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(context, ofOrder.status),
              ],
            ),

            const SizedBox(height: 20),

            // Informazioni principali
            _buildInfoRow(
              context,
              icon: Icons.business,
              label: l10n.clientLabel,
              value: ofOrder.client,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.inventory_2,
              label: l10n.productLabel,
              value: ofOrder.product,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.numbers,
              label: l10n.quantityLabel,
              value: '${ofOrder.quantity} ${l10n.unitsLabel}',
            ),

            if (ofOrder.description != null) ...[
              const SizedBox(height: 16),
              _buildInfoRow(
                context,
                icon: Icons.description,
                label: l10n.descriptionOptionalLabel,
                value: ofOrder.description!,
                isMultiline: true,
              ),
            ],

            const SizedBox(height: 16),

            // Date aggiuntive
            Row(
              children: [
                Expanded(
                  child: _buildDateInfo(
                    context,
                    label: l10n.createdOnLabel,
                    date: ofOrder.createdAt,
                  ),
                ),
                if (ofOrder.updatedAt != null) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateInfo(
                      context,
                      label: 'Aggiornato il',
                      date: ofOrder.updatedAt!,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isMultiline = false,
  }) {
    return Row(
      crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: isMultiline ? null : 1,
                overflow: isMultiline ? null : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo(BuildContext context, {
    required String label,
    required DateTime date,
  }) {
    final dateFormat = DateFormat('dd/MM/yyyy', 'it_IT');
    final timeFormat = DateFormat('HH:mm', 'it_IT');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          dateFormat.format(date),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          timeFormat.format(date),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, OfOrderStatus status) {
    final l10n = AppLocalizations.of(context)!;

    Color color;
    String label;

    switch (status) {
      case OfOrderStatus.materialReception:
        color = Colors.blue;
        label = l10n.ofOrderStatus_materialReception;
        break;
      case OfOrderStatus.materialPreparation:
        color = Colors.orange;
        label = l10n.ofOrderStatus_materialPreparation;
        break;
      case OfOrderStatus.productionCoupe:
        color = Colors.purple;
        label = l10n.ofOrderStatus_productionCoupe;
        break;
      case OfOrderStatus.productionProd:
        color = Colors.indigo;
        label = l10n.ofOrderStatus_productionProd;
        break;
      case OfOrderStatus.productionTest:
        color = Colors.teal;
        label = l10n.ofOrderStatus_productionTest;
        break;
      case OfOrderStatus.control:
        color = Colors.amber;
        label = l10n.ofOrderStatus_control;
        break;
      case OfOrderStatus.shipment:
        color = Colors.cyan;
        label = l10n.ofOrderStatus_shipment;
        break;
      case OfOrderStatus.completed:
        color = Colors.green;
        label = l10n.ofOrderStatus_completed;
        break;
      case OfOrderStatus.cancelled:
        color = Colors.red;
        label = l10n.cancelledLabel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}