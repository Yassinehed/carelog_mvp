import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../providers/signalement_providers.dart';
import '../widgets/signalement_status_updater.dart';
import '../../../../l10n/app_localizations.dart';

class SignalementDetailPage extends ConsumerStatefulWidget {
  final String signalementId;

  const SignalementDetailPage({
    super.key,
    required this.signalementId,
  });

  @override
  ConsumerState<SignalementDetailPage> createState() => _SignalementDetailPageState();
}

class _SignalementDetailPageState extends ConsumerState<SignalementDetailPage> {
  late StreamSubscription _signalementUpdatesSubscription;
  bool _isLiveUpdate = false;

  @override
  void initState() {
    super.initState();
    _setupLiveUpdates();
  }

  @override
  void dispose() {
    _signalementUpdatesSubscription.cancel();
    super.dispose();
  }

  void _setupLiveUpdates() {
    final trackingService = ref.read(realTimeTrackingServiceProvider);
    
    trackingService.startSignalementTracking(widget.signalementId);
    
    _signalementUpdatesSubscription = trackingService.signalementUpdates
        .where((signalement) => signalement.id == widget.signalementId)
        .listen((updatedSignalement) {
          if (mounted) {
            setState(() {
              _isLiveUpdate = true;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Statut mis à jour en temps réel'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            
            ref.invalidate(signalementProvider(widget.signalementId));
            
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() => _isLiveUpdate = false);
              }
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final signalementAsync = ref.watch(signalementProvider(widget.signalementId));
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Détails du signalement'),
            if (_isLiveUpdate) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonctionnalité de modification à venir')),
              );
            },
            tooltip: 'Modifier',
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context, signalementAsync.value),
            tooltip: 'Générer PDF',
          ),
        ],
      ),
      body: signalementAsync.when(
        data: (signalement) {
          if (signalement == null) {
            return _buildNotFoundState(context, l10n);
          }
          return _buildDetailContent(context, ref, signalement, theme, l10n);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(l10n.genericError(error.toString())),
        ),
      ),
    );
  }

  Widget _buildNotFoundState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.report_problem_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Signalement non trouvé',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Le signalement demandé n\'existe pas ou a été supprimé.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(
    BuildContext context,
    WidgetRef ref,
    dynamic signalement,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(context, signalement, theme, l10n),
          const SizedBox(height: 16),
          _buildDescriptionCard(context, signalement, theme, l10n),
          const SizedBox(height: 16),
          _buildDetailsCard(context, signalement, theme, l10n),
          const SizedBox(height: 16),
          _buildActionsCard(context, ref, signalement, theme, l10n),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(
    BuildContext context,
    dynamic signalement,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    signalement.title ?? 'Signalement #',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusChip(context, signalement.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  'Créé par: ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  'Créé le: ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(
    BuildContext context,
    dynamic signalement,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Description',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              signalement.description ?? 'Aucune description disponible',
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    dynamic signalement,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Détails',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Type', _getTypeText(l10n, signalement.type), theme),
            const Divider(height: 24),
            _buildDetailRow('Sévérité', _getSeverityText(l10n, signalement.severity), theme),
            const Divider(height: 24),
            _buildDetailRow('Statut', _getStatusText(signalement.status), theme),
            if (signalement.location != null && signalement.location.isNotEmpty) ...[
              const Divider(height: 24),
              _buildDetailRow('Localisation', signalement.location, theme),
            ],
            if (signalement.updatedAt != null) ...[
              const Divider(height: 24),
              _buildDetailRow('Dernière mise à jour', _formatDate(signalement.updatedAt), theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(
    BuildContext context,
    WidgetRef ref,
    dynamic signalement,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Actions',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => SignalementStatusUpdater(
                          signalement: signalement,
                          onStatusUpdated: () {
                            ref.invalidate(signalementProvider(widget.signalementId));
                            ref.invalidate(signalementsProvider);
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.update),
                    label: const Text('Changer le statut'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, dynamic status) {
    final color = _getStatusColor(status);
    final text = _getStatusText(status);

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
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Color _getStatusColor(dynamic status) {
    switch (status) {
      case 'open':
        return Colors.red;
      case 'inProgress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(dynamic status) {
    switch (status) {
      case 'open':
        return 'Ouvert';
      case 'inProgress':
        return 'En cours';
      case 'resolved':
        return 'Résolu';
      case 'closed':
        return 'Fermé';
      default:
        return 'Inconnu';
    }
  }

  String _getTypeText(AppLocalizations l10n, dynamic type) {
    switch (type) {
      case 'qualityIssue':
        return l10n.signalementType_qualityIssue;
      case 'machineFailure':
        return l10n.signalementType_machineFailure;
      case 'materialIssue':
        return l10n.signalementType_materialIssue;
      case 'processIssue':
        return l10n.signalementType_processIssue;
      case 'other':
        return l10n.signalementType_other;
      default:
        return 'Type inconnu';
    }
  }

  String _getSeverityText(AppLocalizations l10n, dynamic severity) {
    switch (severity) {
      case 'low':
        return l10n.severity_low;
      case 'medium':
        return l10n.severity_medium;
      case 'high':
        return l10n.severity_high;
      case 'critical':
        return l10n.severity_critical;
      default:
        return 'Sévérité inconnue';
    }
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Date inconnue';

    try {
      final DateTime dateTime = date is DateTime ? date : DateTime.parse(date.toString());
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } catch (e) {
      return 'Date invalide';
    }
  }

  void _generatePdf(BuildContext context, dynamic signalement) async {
    if (signalement == null) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Génération PDF à venir')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur génération PDF: ')),
      );
    }
  }
}
