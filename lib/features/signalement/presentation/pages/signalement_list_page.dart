import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/signalement_providers.dart';
import '../widgets/signalement_card.dart';
import '../widgets/signalement_status_updater.dart';
import '../widgets/signalement_filters.dart';
import 'create_signalement_page.dart';
import '../../../../l10n/app_localizations.dart';

class SignalementListPage extends ConsumerWidget {
  const SignalementListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signalementsAsync = ref.watch(signalementsProvider);
    final filteredSignalements = ref.watch(filteredSignalementsProvider);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signalementListTitle),
      ),
      body: Column(
        children: [
          SignalementFilters(
            onFiltersChanged: (filters) {
              ref.read(signalementFiltersProvider.notifier).setFilters(filters);
            },
            initialFilters: ref.watch(signalementFiltersProvider),
          ),
          Expanded(
            child: signalementsAsync.when(
              data: (signalements) {
                final displaySignalements = filteredSignalements.isNotEmpty ? filteredSignalements : signalements;
                final hasFilters = ref.watch(signalementFiltersProvider) != null;

                return displaySignalements.isEmpty
                    ? _buildEmptyState(context, l10n, hasFilters: hasFilters)
                    : ListView.builder(
                        itemCount: displaySignalements.length,
                        itemBuilder: (context, index) {
                          final signalement = displaySignalements[index];
                          return SignalementCard(
                            signalement: signalement,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/signalements/${signalement.id}',
                              );
                            },
                            onStatusUpdate: () {
                              showDialog(
                                context: context,
                                builder: (context) => SignalementStatusUpdater(
                                  signalement: signalement,
                                  onStatusUpdated: () {
                                    // Refresh the list after status update
                                    ref.invalidate(signalementsProvider);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text(l10n.genericError(error.toString()))),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateSignalementPage(),
            ),
          );
        },
        tooltip: l10n.signalementCreateTitle,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n, {required bool hasFilters}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.report_problem_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              hasFilters ? 'Aucun signalement ne correspond aux filtres' : 'Aucun signalement trouvé',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasFilters
                  ? 'Essayez de modifier vos filtres ou créez un nouveau signalement'
                  : 'Créez votre premier signalement en utilisant le bouton +',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
