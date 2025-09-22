import 'package:carelog_mvp/l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/widgets/live_stats_dashboard.dart';
import '../../../../core/providers/system_status_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  bool _isLoading = false;

  // Lista degli admin UIDs (in produzione dovrebbe venire da Firestore)
  final List<String> _adminUids = [
    // Aggiungi qui gli UID degli amministratori
    // 'admin-uid-1',
    // 'admin-uid-2',
  ];

  bool get _isAdmin {
    final currentUser = ref.watch(currentUserProvider);
    return currentUser != null && _adminUids.contains(currentUser.id);
  }

  Future<void> _toggleReadOnlyMode() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final functions = FirebaseFunctions.instance;
      final result = await functions.httpsCallable('resetReadOnlyMode').call();

      if (result.data['success']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.readOnlyUpdatedSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.forceError(e.toString())),
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

  Future<void> _simulateBudgetExceeded() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Simula superamento budget aggiornando Firestore direttamente
      await FirebaseFirestore.instance
          .collection('config')
          .doc('system_status')
          .set({
        'isReadOnly': true,
        'maintenanceMessage':
            'Budget mensile superato. Sistema in modalità manutenzione per proteggere i costi.',
        'lastUpdated': FieldValue.serverTimestamp(),
        'simulated': true, // Flag per indicare che è una simulazione
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.simulateActivatedMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.simulateError(e.toString())),
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

  Future<void> _resetSimulation() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Ripristina modalità normale rimuovendo il flag simulated
      await FirebaseFirestore.instance
          .collection('config')
          .doc('system_status')
          .update({
        'isReadOnly': false,
        'maintenanceMessage': null,
        'lastUpdated': FieldValue.serverTimestamp(),
        'simulated': FieldValue.delete(), // Rimuove il flag di simulazione
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.resetSimulationSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!
                .resetSimulationError(e.toString())),
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

  Future<void> _forceReadOnlyMode() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('config')
          .doc('system_status')
          .set({
        'isReadOnly': true,
        'maintenanceMessage':
            'Modalità manutenzione forzata dall\'amministratore.',
        'lastUpdated': FieldValue.serverTimestamp(),
        'forced': true,
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.forceMaintenanceSuccess),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.forceError(e.toString())),
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
    if (!_isAdmin) {
      final l10n = AppLocalizations.of(context)!;
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.accessDeniedTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.admin_panel_settings,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.accessDeniedMessage,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final systemStatus = ref.watch(systemStatusProvider);
    final isReadOnly = ref.watch(isReadOnlyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.adminDashboardTitle),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con stato sistema
            _buildSystemStatusCard(systemStatus, isReadOnly),

            const SizedBox(height: 24),

            // Statistiche live
            const LiveStatsDashboard(),

            const SizedBox(height: 24),

            // Controlli amministratore
            _buildAdminControls(),

            const SizedBox(height: 24),

            // Statistiche sistema
            _buildSystemStats(),

            const SizedBox(height: 24),

            // Testing tools
            _buildTestingTools(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatusCard(SystemStatus systemStatus, bool isReadOnly) {
    return Card(
      elevation: 4,
      color: isReadOnly ? Colors.red.shade50 : Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isReadOnly ? Icons.warning : Icons.check_circle,
                  color: isReadOnly ? Colors.red : Colors.green,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isReadOnly
                        ? AppLocalizations.of(context)!.systemStatusMaintenance
                        : AppLocalizations.of(context)!.systemStatusNormal,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isReadOnly ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (systemStatus.maintenanceMessage != null) ...[
              Text(
                AppLocalizations.of(context)!
                    .systemMessageLabel(systemStatus.maintenanceMessage ?? ''),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
            ],
            if (systemStatus.lastUpdated != null) ...[
              Text(
                AppLocalizations.of(context)!.lastUpdatedLabel(
                    systemStatus.lastUpdated!.toLocal().toString()),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdminControls() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.adminControlsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _toggleReadOnlyMode,
                    icon: const Icon(Icons.settings),
                    label: Text(
                        AppLocalizations.of(context)!.adminToggleButtonLabel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.adminNote,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStats() {
    final systemStatus = ref.watch(systemStatusProvider);
    final isSimulated =
        systemStatus.maintenanceMessage?.contains('Budget mensile superato') ??
            false;
    final isForced = systemStatus.maintenanceMessage
            ?.contains('forzata dall\'amministratore') ??
        false;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.systemStatsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatRow(
                AppLocalizations.of(context)!.systemStatusLabel,
                systemStatus.isReadOnly
                    ? AppLocalizations.of(context)!.systemStatusMaintenance
                    : AppLocalizations.of(context)!.systemStatusNormal,
                systemStatus.isReadOnly ? Colors.red : Colors.green),
            _buildStatRow(
                AppLocalizations.of(context)!.modeLabel,
                isSimulated
                    ? AppLocalizations.of(context)!.simulatedLabel
                    : isForced
                        ? AppLocalizations.of(context)!.forcedLabel
                        : AppLocalizations.of(context)!.normalLabel,
                isSimulated
                    ? Colors.orange
                    : isForced
                        ? Colors.red
                        : Colors.green),
            _buildStatRow(AppLocalizations.of(context)!.cloudFunctionsLabel,
                AppLocalizations.of(context)!.cloudFunctionsPending),
            _buildStatRow(AppLocalizations.of(context)!.budgetAlertLabel,
                AppLocalizations.of(context)!.budgetSimulationActive),
            _buildStatRow(AppLocalizations.of(context)!.securityRulesLabel,
                AppLocalizations.of(context)!.securityRulesActive),
            if (systemStatus.lastUpdated != null)
              _buildStatRow(
                AppLocalizations.of(context)!.lastUpdatedLabel(
                    '${systemStatus.lastUpdated!.toLocal().hour}:${systemStatus.lastUpdated!.toLocal().minute.toString().padLeft(2, '0')}'),
                '',
                Colors.grey,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestingTools() {
    final systemStatus = ref.watch(systemStatusProvider);
    final isSimulated =
        systemStatus.maintenanceMessage?.contains('Budget mensile superato') ??
            false;
    final isForced = systemStatus.maintenanceMessage
            ?.contains('forzata dall\'amministratore') ??
        false;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.science, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.testingHeader,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.testingInfo,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Stato attuale della simulazione
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: systemStatus.isReadOnly
                    ? Colors.red.shade50
                    : Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: systemStatus.isReadOnly
                      ? Colors.red.shade200
                      : Colors.green.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    systemStatus.isReadOnly
                        ? Icons.warning
                        : Icons.check_circle,
                    color: systemStatus.isReadOnly ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          systemStatus.isReadOnly
                              ? AppLocalizations.of(context)!.systemInSimulation
                              : AppLocalizations.of(context)!.systemNormal,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: systemStatus.isReadOnly
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        if (isSimulated) ...[
                          Text(
                            AppLocalizations.of(context)!.simulateButtonShort,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.red),
                          ),
                        ] else if (isForced) ...[
                          Text(
                            AppLocalizations.of(context)!.forcedLabel,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.orange),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Pulsanti di controllo
            Text(
              AppLocalizations.of(context)!.simulationControlsLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (_isLoading || systemStatus.isReadOnly)
                        ? null
                        : _simulateBudgetExceeded,
                    icon: const Icon(Icons.warning),
                    label:
                        Text(AppLocalizations.of(context)!.simulateButtonLabel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (_isLoading || !systemStatus.isReadOnly)
                        ? null
                        : _resetSimulation,
                    icon: const Icon(Icons.restore),
                    label:
                        Text(AppLocalizations.of(context)!.restoreButtonLabel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _forceReadOnlyMode,
              icon: const Icon(Icons.admin_panel_settings),
              label: Text(AppLocalizations.of(context)!.forceMaintenanceButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),

            const SizedBox(height: 16),

            // Informazioni aggiuntive
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 ${AppLocalizations.of(context)!.testingHeader}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.testingInstructions,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
