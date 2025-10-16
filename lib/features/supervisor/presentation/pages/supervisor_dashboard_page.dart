import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/active_orders_provider.dart';
import '../providers/operators_provider.dart';
import '../widgets/kpi_card.dart';
import '../widgets/enhanced_of_card.dart';
import '../../../../features/of_order/domain/entities/of_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../injection.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
// Localization keys were added to ARB; codegen needs to be run to generate getters.
import '../../../../domain/usecases/user/user_usecases.dart';
import '../../../../domain/entities/user.dart' as domain_user;

final _currentDomainUserProvider = FutureProvider.family<domain_user.User?, String?>((ref, userId) async {
  if (userId == null) return null;
  final getUserById = getIt<GetUserById>();
  final res = await getUserById(userId);
  return res.fold((_) => null, (u) => u);
});

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
    final authUser = ref.watch(currentUserProvider);
    final domainUserAsync = ref.watch(_currentDomainUserProvider(authUser?.id));

    final l10n = AppLocalizations.of(context)!;

    return domainUserAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.supervisorDashboardTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: Text(l10n.supervisorDashboardTitle)),
        body: Center(child: Text(l10n.accessDeniedSupervisor)),
      ),
      data: (domainUser) {
        if (domainUser == null || !(domainUser.isAdmin || domainUser.isControl)) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.supervisorDashboardTitle)),
            body: Center(child: Text(l10n.accessDeniedSupervisor)),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.supervisorDashboardTitle)),
          body: Column(
            children: [
              // KPI Header
              Container(
                height: 120,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    KPICard(icon: Icons.speed, label: l10n.kpi_production_label, value: '12/15', trend: '+8%', color: const Color(0xFF10B981)),
                    KPICard(icon: Icons.warning_amber, label: l10n.kpi_alerts_label, value: '3', trend: '-2', color: const Color(0xFFF59E0B)),
                    KPICard(icon: Icons.people, label: l10n.kpi_operators_label, value: '18/20', trend: '90%', color: const Color(0xFF3B82F6)),
                    KPICard(icon: Icons.timer, label: l10n.kpi_avg_time_label, value: '2.4h', trend: '-12%', color: const Color(0xFF8B5CF6)),
                  ]),
                ),
              ),

              // Smart filter bar with chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ...OfOrderStatus.values.map((s) {
                      final isSelected = _filters != null && _filters!['status'] == s.name;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(s.name),
                          selected: isSelected,
                          onSelected: (sel) => setState(() => _filters = sel ? {'status': s.name} : null),
                          backgroundColor: Colors.grey[100],
                          selectedColor: _statusColor(s).withOpacity(0.18),
                          checkmarkColor: _statusColor(s),
                        ),
                      );
                    }).toList(),
                    const SizedBox(width: 12),
                    SizedBox(width: 200, child: _zoneFilter()),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: () => setState(() => _filters = null), child: Text(l10n.filter_reset)),
                  ]),
                ),
              ),

              // Orders list
              Expanded(
                child: ordersAsync.when(
                  data: (orders) {
                    if (orders.isEmpty) return Center(child: Text(l10n.noActiveOf));
                    return ReorderableListView.builder(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: orders.length,
                      onReorder: (oldIndex, newIndex) async {
                        // optimistic reorder
                        final list = List.of(orders);
                        final item = list.removeAt(oldIndex);
                        list.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
                        setState(() {});
                        try {
                          await _persistPriorityOrder(list);
                          HapticFeedback.lightImpact();
                          // success feedback
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.prioritiesUpdated), backgroundColor: Colors.green));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${l10n.genericError(e.toString())}')));
                        }
                      },
                      itemBuilder: (context, index) {
                        final o = orders[index];
                        final statusColor = _statusColor(o.order.status);
                        final progress = _calculateProgress(o.order.status);
                        return Container(
                          key: ValueKey(o.docId),
                          child: EnhancedOFCard(order: o.order, priority: o.priority, assignedOperator: o.assignedOperator, zone: o.zone, docId: o.docId, statusColor: statusColor, progress: progress, onAssign: (id) => _openAssignDialog(o), onView: (id) {}),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('${l10n.errorLabel}: $e')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _statusColor(OfOrderStatus status) {
    switch (status) {
      case OfOrderStatus.materialReception:
        return const Color(0xFF10B981);
      case OfOrderStatus.materialPreparation:
        return const Color(0xFF3B82F6);
      case OfOrderStatus.productionCoupe:
      case OfOrderStatus.productionProd:
      case OfOrderStatus.productionTest:
        return const Color(0xFF8B5CF6);
      case OfOrderStatus.control:
        return const Color(0xFFF59E0B);
      case OfOrderStatus.shipment:
        return const Color(0xFF6B7280);
      case OfOrderStatus.completed:
        return const Color(0xFF6B7280);
      case OfOrderStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  double _calculateProgress(OfOrderStatus status) {
    // Simple mapping of status to progress value (0..1)
    switch (status) {
      case OfOrderStatus.materialReception:
        return 0.05;
      case OfOrderStatus.materialPreparation:
        return 0.25;
      case OfOrderStatus.productionCoupe:
        return 0.45;
      case OfOrderStatus.productionProd:
        return 0.65;
      case OfOrderStatus.productionTest:
        return 0.8;
      case OfOrderStatus.control:
        return 0.85;
      case OfOrderStatus.shipment:
        return 0.95;
      case OfOrderStatus.completed:
        return 1.0;
      case OfOrderStatus.cancelled:
        return 0.0;
    }
  }

  // ...status filter UI replaced by smart chip bar above

  Widget _zoneFilter() {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(labelText: l10n.zoneLabel),
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
    final l10n = AppLocalizations.of(context)!;
    final selected = await showDialog<String?>(context: context, builder: (ctx) {
      return Dialog(
        child: SizedBox(
          width: 400,
          height: 500,
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(8.0), child: Text(l10n.assignOperatorForZone(zone ?? l10n.zoneLabel))),
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
                          subtitle: workloadAsync.when(data: (w) => Text(l10n.workloadLabel(w)), loading: () => Text(l10n.assignDialogCalculating), error: (_,__) => Text(l10n.errorLabel)),
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
