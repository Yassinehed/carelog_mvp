import 'package:flutter/material.dart';
import '../../domain/entities/of_order.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget per filtrare e cercare ordini di produzione
class OfOrderFilters extends StatefulWidget {
  final Function(String?, OfOrderStatus?) onFiltersChanged;
  final String? initialSearchQuery;
  final OfOrderStatus? initialStatusFilter;

  const OfOrderFilters({
    super.key,
    required this.onFiltersChanged,
    this.initialSearchQuery,
    this.initialStatusFilter,
  });

  @override
  State<OfOrderFilters> createState() => _OfOrderFiltersState();
}

class _OfOrderFiltersState extends State<OfOrderFilters> {
  late TextEditingController _searchController;
  OfOrderStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialSearchQuery);
    _selectedStatus = widget.initialStatusFilter;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    widget.onFiltersChanged(query.isEmpty ? null : query, _selectedStatus);
  }

  void _onStatusChanged(OfOrderStatus? status) {
    setState(() => _selectedStatus = status);
    widget.onFiltersChanged(
      _searchController.text.isEmpty ? null : _searchController.text,
      status,
    );
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() => _selectedStatus = null);
    widget.onFiltersChanged(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.filtersLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (_searchController.text.isNotEmpty || _selectedStatus != null)
                  TextButton.icon(
                    onPressed: _clearFilters,
                    icon: const Icon(Icons.clear),
                    label: Text(AppLocalizations.of(context)!.clearFiltersLabel),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.searchOrdersLabel,
                hintText: AppLocalizations.of(context)!.searchOrdersHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<OfOrderStatus>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.filterByStatusLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(AppLocalizations.of(context)!.allStatusesLabel),
                ),
                ...OfOrderStatus.values.map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(_getStatusText(context, status)),
                    )),
              ],
              onChanged: _onStatusChanged,
            ),
            const SizedBox(height: 8),
            if (_selectedStatus != null)
              Chip(
                label: Text(_getStatusText(context, _selectedStatus!)),
                onDeleted: () => _onStatusChanged(null),
                backgroundColor: _getStatusColor(context, _selectedStatus!).withValues(alpha: 0.1),
                side: BorderSide(
                  color: _getStatusColor(context, _selectedStatus!).withValues(alpha: 0.3),
                ),
              ),
          ],
        ),
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