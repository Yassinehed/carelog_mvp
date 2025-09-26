import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/machine_providers.dart';

class MachineDebugPage extends ConsumerWidget {
  final String machineId;
  const MachineDebugPage({super.key, required this.machineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(machineStatusNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Machine Debug')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => ref.read(machineStatusNotifierProvider.notifier).load(machineId),
              child: const Text('Load Status'),
            ),
            const SizedBox(height: 12),
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error != null) Text('Error: ${state.error}'),
            if (state.status != null) ...[
              Text('ID: ${state.status!.id}'),
              Text('Status: ${state.status!.status}'),
              Text('Timestamp: ${state.status!.timestamp}'),
            ],
          ],
        ),
      ),
    );
  }
}
