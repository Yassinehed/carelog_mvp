import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/signalement.dart';
import '../../domain/usecases/update_signalement_status.dart';
import '../providers/signalement_providers.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget per aggiornare lo stato di un signalement
class SignalementStatusUpdater extends ConsumerStatefulWidget {
  final Signalement signalement;
  final VoidCallback? onStatusUpdated;

  const SignalementStatusUpdater({
    super.key,
    required this.signalement,
    this.onStatusUpdated,
  });

  @override
  ConsumerState<SignalementStatusUpdater> createState() =>
      _SignalementStatusUpdaterState();
}

class _SignalementStatusUpdaterState
    extends ConsumerState<SignalementStatusUpdater> {
  SignalementStatus? _selectedStatus;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.signalement.status;
  }

  Future<void> _updateStatus() async {
    if (_selectedStatus == null || _selectedStatus == widget.signalement.status) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final params = UpdateSignalementStatusParams(
        signalementId: widget.signalement.id,
        newStatus: _selectedStatus!,
      );

      // Utilizzo del provider per aggiornare lo stato
      await ref.read(updateSignalementStatusProvider(params).future);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Statut mis à jour avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onStatusUpdated?.call();
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la mise à jour: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: const Text('Mettre à jour le statut'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signalement #${widget.signalement.id}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.signalement.description,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Text(
            'Statut actuel',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          _buildStatusChip(context, widget.signalement.status),
          const SizedBox(height: 16),
          DropdownButtonFormField<SignalementStatus>(
            value: _selectedStatus,
            decoration: InputDecoration(
              labelText: 'Nouveau statut',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: SignalementStatus.values.map((status) {
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
            onChanged: _isLoading
                ? null
                : (value) => setState(() => _selectedStatus = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: _isLoading || _selectedStatus == widget.signalement.status
              ? null
              : _updateStatus,
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Mettre à jour'),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, SignalementStatus status,
      {bool showText = false}) {
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

  Color _getStatusColor(BuildContext context, SignalementStatus status) {
    switch (status) {
      case SignalementStatus.open:
        return Colors.red;
      case SignalementStatus.inProgress:
        return Colors.orange;
      case SignalementStatus.resolved:
        return Colors.green;
      case SignalementStatus.closed:
        return Colors.grey;
    }
  }

  String _getStatusText(BuildContext context, SignalementStatus status) {
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