import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/signalement_providers.dart';
import '../../../../l10n/app_localizations.dart';

class SignalementListPage extends ConsumerWidget {
  const SignalementListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signalementsAsync = ref.watch(signalementsProvider);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signalementListTitle),
      ),
      body: signalementsAsync.when(
        data: (signalements) => ListView.builder(
          itemCount: signalements.length,
          itemBuilder: (context, index) {
            final signalement = signalements[index];
            return ListTile(
              title: Text(signalement.description),
              subtitle:
                  Text('${l10n.systemStatusLabel}: ${signalement.status.name}'),
              trailing: Text(signalement.severity.name.toUpperCase()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text(l10n.genericError(error.toString()))),
      ),
    );
  }
}
