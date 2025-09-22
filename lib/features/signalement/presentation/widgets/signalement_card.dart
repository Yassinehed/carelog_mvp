import 'package:flutter/material.dart';
import '../../domain/entities/signalement.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget per mostrare un singolo signalement in una card
class SignalementCard extends StatelessWidget {
  final Signalement signalement;
  final VoidCallback? onTap;
  final VoidCallback? onStatusUpdate;

  const SignalementCard({
    super.key,
    required this.signalement,
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
                      'Signalement #${signalement.id}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(context, signalement.status),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                Icons.category,
                _getTypeText(context, signalement.type),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.warning,
                _getSeverityText(context, signalement.severity),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.person,
                'Créé par: ${signalement.createdBy}',
              ),
              const SizedBox(height: 12),
              Text(
                signalement.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Créé: ${_formatDateTime(context, signalement.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  if (onStatusUpdate != null)
                    IconButton(
                      onPressed: onStatusUpdate,
                      icon: const Icon(Icons.edit),
                      tooltip: 'Mettre à jour le statut',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, SignalementStatus status) {
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

  String _getTypeText(BuildContext context, SignalementType type) {
    final l10n = AppLocalizations.of(context)!;
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

  String _getSeverityText(BuildContext context, SignalementSeverity severity) {
    switch (severity) {
      case SignalementSeverity.low:
        return AppLocalizations.of(context)!.severity_low;
      case SignalementSeverity.medium:
        return AppLocalizations.of(context)!.severity_medium;
      case SignalementSeverity.high:
        return AppLocalizations.of(context)!.severity_high;
      case SignalementSeverity.critical:
        return AppLocalizations.of(context)!.severity_critical;
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