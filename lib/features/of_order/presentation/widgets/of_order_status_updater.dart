import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/of_order.dart';
import '../../domain/usecases/update_of_order_status.dart';

/// Widget per aggiornare lo stato di un ordine di produzione
class OfOrderStatusUpdater extends StatefulWidget {
  final OfOrder ofOrder;
  final Function(UpdateOfOrderStatusParams) onStatusUpdate;
  final bool isLoading;

  const OfOrderStatusUpdater({
    super.key,
    required this.ofOrder,
    required this.onStatusUpdate,
    this.isLoading = false,
  });

  @override
  State<OfOrderStatusUpdater> createState() => _OfOrderStatusUpdaterState();
}

class _OfOrderStatusUpdaterState extends State<OfOrderStatusUpdater> {
  OfOrderStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.ofOrder.status;
  }

  void _updateStatus() {
    if (_selectedStatus == null || _selectedStatus == widget.ofOrder.status) return;

    final params = UpdateOfOrderStatusParams(
      ofOrderId: widget.ofOrder.id,
      newStatus: _selectedStatus!,
    );

    widget.onStatusUpdate(params);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.updateOrderStatusTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.ofOrderNumber(widget.ofOrder.id),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.ofOrder.client} - ${widget.ofOrder.product}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.currentStatusLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          _buildStatusChip(context, widget.ofOrder.status),
          const SizedBox(height: 16),
          DropdownButtonFormField<OfOrderStatus>(
            value: _selectedStatus,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.newStatusLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: OfOrderStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Row(
                  children: [
                    _buildStatusChip(context, status, showText: true),
                    const SizedBox(width: 8),
                    Text(_getStatusText(context, status)),
                  ],
                ),
              );
            }).toList(),
            onChanged: widget.isLoading
                ? null
                : (value) => setState(() => _selectedStatus = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
        ElevatedButton(
          onPressed: widget.isLoading || _selectedStatus == widget.ofOrder.status
              ? null
              : _updateStatus,
          child: widget.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context)!.updateStatusButton),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, OfOrderStatus status, {bool showText = false}) {
    final color = _getStatusColor(context, status);
    final text = showText ? _getStatusText(context, status) : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: text != null
          ? Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
            )
          : Icon(
              Icons.circle,
              size: 12,
              color: color,
            ),
    );
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
}