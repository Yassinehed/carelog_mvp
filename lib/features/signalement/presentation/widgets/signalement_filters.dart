import 'package:flutter/material.dart';
import '../../domain/entities/signalement.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget per filtrare i signalement per tipo, severità e stato
class SignalementFilters extends StatefulWidget {
  final Function(SignalementFilterData?) onFiltersChanged;
  final SignalementFilterData? initialFilters;

  const SignalementFilters({
    super.key,
    required this.onFiltersChanged,
    this.initialFilters,
  });

  @override
  State<SignalementFilters> createState() => _SignalementFiltersState();
}

class _SignalementFiltersState extends State<SignalementFilters> {
  SignalementType? _selectedType;
  SignalementSeverity? _selectedSeverity;
  SignalementStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      _selectedType = widget.initialFilters!.type;
      _selectedSeverity = widget.initialFilters!.severity;
      _selectedStatus = widget.initialFilters!.status;
    }
  }

  void _onFilterChanged() {
    final hasFilters = _selectedType != null ||
        _selectedSeverity != null ||
        _selectedStatus != null;

    final filters = hasFilters
        ? SignalementFilterData(
            type: _selectedType,
            severity: _selectedSeverity,
            status: _selectedStatus,
          )
        : null;

    widget.onFiltersChanged(filters);
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedSeverity = null;
      _selectedStatus = null;
    });
    widget.onFiltersChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasActiveFilters = _selectedType != null ||
        _selectedSeverity != null ||
        _selectedStatus != null;

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
                  'Filtres',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (hasActiveFilters)
                  TextButton.icon(
                    onPressed: _clearFilters,
                    icon: const Icon(Icons.clear),
                    label: const Text('Effacer les filtres'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildFilterDropdown<SignalementType>(
                    label: l10n.signalementTypeLabel,
                    value: _selectedType,
                    items: SignalementType.values,
                    itemLabelBuilder: (type) => _getTypeText(l10n, type),
                    onChanged: (value) {
                      setState(() => _selectedType = value);
                      _onFilterChanged();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFilterDropdown<SignalementSeverity>(
                    label: l10n.signalementSeverityLabel,
                    value: _selectedSeverity,
                    items: SignalementSeverity.values,
                    itemLabelBuilder: (severity) => _getSeverityText(l10n, severity),
                    onChanged: (value) {
                      setState(() => _selectedSeverity = value);
                      _onFilterChanged();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildFilterDropdown<SignalementStatus>(
              label: 'Statut',
              value: _selectedStatus,
              items: SignalementStatus.values,
              itemLabelBuilder: (status) => _getStatusText(status),
              onChanged: (value) {
                setState(() => _selectedStatus = value);
                _onFilterChanged();
              },
            ),
            if (hasActiveFilters) ...[
              const SizedBox(height: 16),
              _buildActiveFiltersChips(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabelBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: [
        DropdownMenuItem<T>(
          value: null,
          child: Text(
            'Tous',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ...items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(itemLabelBuilder(item)),
          );
        }),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildActiveFiltersChips() {
    final chips = <Widget>[];

    if (_selectedType != null) {
      chips.add(_buildFilterChip(
        label: 'Type: ${_getTypeText(AppLocalizations.of(context)!, _selectedType!)}',
        onRemove: () {
          setState(() => _selectedType = null);
          _onFilterChanged();
        },
      ));
    }

    if (_selectedSeverity != null) {
      chips.add(_buildFilterChip(
        label: 'Sévérité: ${_getSeverityText(AppLocalizations.of(context)!, _selectedSeverity!)}',
        onRemove: () {
          setState(() => _selectedSeverity = null);
          _onFilterChanged();
        },
      ));
    }

    if (_selectedStatus != null) {
      chips.add(_buildFilterChip(
        label: 'Statut: ${_getStatusText(_selectedStatus!)}',
        onRemove: () {
          setState(() => _selectedStatus = null);
          _onFilterChanged();
        },
      ));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onRemove,
  }) {
    return Chip(
      label: Text(label),
      onDeleted: onRemove,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
      ),
    );
  }

  String _getTypeText(AppLocalizations l10n, SignalementType type) {
    switch (type) {
      case SignalementType.qualityIssue:
        return l10n.signalementType_qualityIssue;
      case SignalementType.machineFailure:
        return l10n.signalementType_machineFailure;
      case SignalementType.materialIssue:
        return l10n.signalementType_materialIssue;
      case SignalementType.processIssue:
        return l10n.signalementType_processIssue;
      case SignalementType.other:
        return l10n.signalementType_other;
    }
  }

  String _getSeverityText(AppLocalizations l10n, SignalementSeverity severity) {
    switch (severity) {
      case SignalementSeverity.low:
        return l10n.severity_low;
      case SignalementSeverity.medium:
        return l10n.severity_medium;
      case SignalementSeverity.high:
        return l10n.severity_high;
      case SignalementSeverity.critical:
        return l10n.severity_critical;
    }
  }

  String _getStatusText(SignalementStatus status) {
    switch (status) {
      case SignalementStatus.open:
        return 'Ouvert';
      case SignalementStatus.inProgress:
        return 'En cours';
      case SignalementStatus.resolved:
        return 'Résolu';
      case SignalementStatus.closed:
        return 'Fermé';
    }
  }
}

/// Classe per i dati dei filtri
class SignalementFilterData {
  final SignalementType? type;
  final SignalementSeverity? severity;
  final SignalementStatus? status;

  const SignalementFilterData({
    this.type,
    this.severity,
    this.status,
  });

  bool matches(Signalement signalement) {
    if (type != null && signalement.type != type) return false;
    if (severity != null && signalement.severity != severity) return false;
    if (status != null && signalement.status != status) return false;
    return true;
  }
}