import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/presentation/providers/auth_providers.dart';
import '../../../features/material/presentation/widgets/material_stats_widget.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context);

    // Fallback se le localizzazioni non sono disponibili
    if (l10n == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeDashboard),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () => Navigator.of(context).pushNamed('/admin'),
            tooltip: l10n.adminDashboardTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // TODO: Implement logout
              Navigator.of(context).pushReplacementNamed('/login');
            },
            tooltip: l10n.logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Text(
              l10n.homeWelcome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.homeWelcome}${currentUser != null ? ', ${currentUser.email}' : ''}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 32),

            // Quick Actions Grid
            Text(
              l10n.quickActionsTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildQuickActionCard(
                  context,
                  l10n.materialsLabel,
                  Icons.inventory,
                  Colors.blue,
                  () => Navigator.of(context).pushNamed('/materials'),
                ),
                _buildQuickActionCard(
                  context,
                  l10n.signalementsLabel,
                  Icons.report_problem,
                  Colors.orange,
                  () => Navigator.of(context).pushNamed('/signalements'),
                ),
                _buildQuickActionCard(
                  context,
                  l10n.ofOrdersLabel,
                  Icons.build,
                  Colors.green,
                  () => Navigator.of(context).pushNamed('/of_orders'),
                ),
                _buildQuickActionCard(
                  context,
                  l10n.adminDashboardShort,
                  Icons.admin_panel_settings,
                  Colors.purple,
                  () => Navigator.of(context).pushNamed('/admin'),
                ),
                    _buildQuickActionCard(
                      context,
                      'Superviseur',
                      Icons.dashboard_customize,
                      Colors.teal,
                      () => Navigator.of(context).pushNamed('/supervisor'),
                    ),
              ],
            ),

            const SizedBox(height: 32),

            // Material Statistics Widget
            Text(
              l10n.materialStatisticsTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const MaterialStatsWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
