import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/active_orders_provider.dart';
import '../providers/operators_provider.dart';
import '../../../../features/of_order/domain/entities/of_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupervisorDashboardPage extends ConsumerStatefulWidget {
  const SupervisorDashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SupervisorDashboardPage> createState() => _SupervisorDashboardPageState();
}

class _SupervisorDashboardPageState extends ConsumerState<SupervisorDashboardPage> {
  Map<String, dynamic>? _filters;

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(activeOrdersProvider(_filters));

    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de bord superviseur')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: _statusFilter()),
              const SizedBox(width: 8),
              Expanded(child: _zoneFilter()),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () => setState(() => _filters = null), child: const Text('Réinitialiser')),
            ]),
          ),
          Expanded(
            child: ordersAsync.when(
              data: (orders) {
                if (orders.isEmpty) return const Center(child: Text('Aucune OF active'));
                // Show ReorderableListView for priorities
                return ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) async {
                    // optimistic reorder
                    final list = List.of(orders);
                    final item = list.removeAt(oldIndex);
                    list.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
                    setState(() {});
                    try {
                      await _persistPriorityOrder(list);
                    } catch (e) {
                      // rollback by forcing a refresh (the stream will provide original)
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de la mise à jour des priorités')));
                    }
                  },
                  itemCount: orders.length,
                  buildDefaultDragHandles: true,
                  itemBuilder: (context, index) {
                    final o = orders[index];
                    return ListTile(
                      key: ValueKey(o.docId),
                      title: Text('${o.order.client} - ${o.order.product}'),
                      subtitle: Text('Priorité: ${o.priority} • Opérateur: ${o.assignedOperator ?? '—'}'),
                      trailing: IconButton(icon: const Icon(Icons.person_add), onPressed: () => _openAssignDialog(o)),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Erreur: $e')),
            ),
          )
        ],
      ),
    );
  }

  Widget _statusFilter() {
    final items = <DropdownMenuItem<String?>>[DropdownMenuItem(value: null, child: Text('Tous'))];
    items.addAll(OfOrderStatus.values.map((e) => DropdownMenuItem<String?>(value: e.name, child: Text(e.name))));
    return DropdownButtonFormField<String?>(
      items: items,
      onChanged: (v) => setState(() => _filters = (v == null) ? null : {'status': v}),
      hint: const Text('Filtrer par statut'),
    );
  }

  Widget _zoneFilter() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Zone'),
      onFieldSubmitted: (v) => setState(() => _filters = (v.isEmpty) ? null : {'zone': v}),
    );
  }

  Future<void> _persistPriorityOrder(List list) async {
    final batch = FirebaseFirestore.instance.batch();
    for (var i = 0; i < list.length; i++) {
      final item = list[i];
      final ref = FirebaseFirestore.instance.collection('of_orders').doc(item.docId);
      batch.update(ref, {'priority': i, 'priorityUpdatedAt': FieldValue.serverTimestamp()});
    }
    await batch.commit();
  }

  Future<void> _openAssignDialog(dynamic orderWithMeta) async {
    final zone = orderWithMeta.zone as String?;
    final selected = await showDialog<String?>(context: context, builder: (ctx) {
      return Dialog(
        child: SizedBox(
          width: 400,
          height: 500,
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(8.0), child: Text('Attribuer un opérateur pour zone: ${zone ?? 'Toutes'}')),
              Expanded(child: Consumer(builder: (c, ref, _) {
                final opsAsync = ref.watch(operatorsProvider);
                return opsAsync.when(
                  data: (ops) {
                    final filtered = zone == null ? ops : ops.where((o) => o.skills.contains(zone)).toList();
                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final op = filtered[i];
                        final workloadAsync = ref.watch(operatorWorkloadProvider(op.id));
                        return ListTile(
                          title: Text(op.name),
                          subtitle: workloadAsync.when(data: (w) => Text('Charge: $w'), loading: () => const Text('Calcul...'), error: (_,__) => const Text('Erreur')),
                          onTap: () => Navigator.pop(ctx, op.id),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Erreur: $e')),
                );
              })),
            ],
          ),
        ),
      );
    });

    if (selected != null) {
      await FirebaseFirestore.instance.collection('of_orders').doc(orderWithMeta.docId).update({'assignedOperator': selected, 'assignedAt': FieldValue.serverTimestamp()});
      // TODO: Notification via FCM or functions
    }
  }
}
