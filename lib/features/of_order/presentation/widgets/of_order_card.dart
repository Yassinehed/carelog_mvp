import 'package:flutter/material.dart';
import '../../domain/entities/of_order.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget per mostrare un singolo ordine di produzione in una card
class OfOrderCard extends StatelessWidget {
  final OfOrder ofOrder;
  final VoidCallback? onTap;
  final VoidCallback? onStatusUpdate;

  const OfOrderCard({
    super.key,
    required this.ofOrder,
    this.onTap,
    this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.ofOrderNumber(ofOrder.id),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(context, ofOrder.status),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                Icons.business,
                AppLocalizations.of(context)!.ofOrderClient(ofOrder.client),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.inventory,
                AppLocalizations.of(context)!.ofOrderProduct(ofOrder.product),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.numbers,
                AppLocalizations.of(context)!.ofOrderQuantity(ofOrder.quantity.toString()),
              ),
              if (ofOrder.description != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(
                  context,
                  Icons.description,
                  ofOrder.description!,
                  isDescription: true,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.ofOrderCreated(_formatDateTime(context, ofOrder.createdAt)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  if (onStatusUpdate != null)
                    IconButton(
                      onPressed: onStatusUpdate,
                      icon: const Icon(Icons.edit),
                      tooltip: AppLocalizations.of(context)!.newStatusLabel,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text, {bool isDescription = false}) {
    return Row(
      crossAxisAlignment: isDescription ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: isDescription
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )
                : Theme.of(context).textTheme.bodyMedium,
            maxLines: isDescription ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, OfOrderStatus status) {
    final color = _getStatusColor(context, status);
    final text = _getStatusText(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, OfOrderStatus status) {
    switch (status) {
      case OfOrderStatus.materialReception:
        return Colors.blue;
      case OfOrderStatus.materialPreparation:
        return Colors.orange;
      case OfOrderStatus.productionCoupe:
        return Colors.purple;
      case OfOrderStatus.productionProd:
        return Colors.indigo;
      case OfOrderStatus.productionTest:
        return Colors.teal;
      case OfOrderStatus.control:
        return Colors.amber;
      case OfOrderStatus.shipment:
        return Colors.cyan;
      case OfOrderStatus.completed:
        return Colors.green;
      case OfOrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(BuildContext context, OfOrderStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case OfOrderStatus.materialReception:
        return l10n.ofOrderStatus_materialReception;
      case OfOrderStatus.materialPreparation:
        return l10n.ofOrderStatus_materialPreparation;
      case OfOrderStatus.productionCoupe:
        return l10n.ofOrderStatus_productionCoupe;
      case OfOrderStatus.productionProd:
        return l10n.ofOrderStatus_productionProd;
      case OfOrderStatus.productionTest:
        return l10n.ofOrderStatus_productionTest;
      case OfOrderStatus.control:
        return l10n.ofOrderStatus_control;
      case OfOrderStatus.shipment:
        return l10n.ofOrderStatus_shipment;
      case OfOrderStatus.completed:
        return l10n.ofOrderStatus_completed;
      case OfOrderStatus.cancelled:
        return l10n.cancelledLabel;
    }
  }

  String _formatDateTime(BuildContext context, DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
           '${dateTime.month.toString().padLeft(2, '0')}/'
           '${dateTime.year} '
           '${dateTime.hour.toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}