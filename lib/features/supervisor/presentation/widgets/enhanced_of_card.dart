import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../features/of_order/domain/entities/of_order.dart';

typedef OnAssign = void Function(String docId);
typedef OnView = void Function(String docId);

class EnhancedOFCard extends StatelessWidget {
  final OfOrder order;
  final int priority;
  final String? assignedOperator;
  final String? zone;
  final String docId;
  final Color statusColor;
  final double progress;
  final OnAssign onAssign;
  final OnView onView;

  const EnhancedOFCard({super.key, required this.order, required this.priority, this.assignedOperator, this.zone, required this.docId, required this.statusColor, required this.progress, required this.onAssign, required this.onView});

  Color _getPriorityColor(int p) {
    if (p <= 2) return Colors.redAccent;
    if (p <= 5) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onView(docId);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.08 * 255).toInt()), blurRadius: 16, offset: const Offset(0, 6))],
          border: Border.all(color: statusColor, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Semantics(
              container: true,
              label: '${order.client} — ${order.product}',
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: statusColor.withAlpha((0.08 * 255).toInt()), borderRadius: const BorderRadius.vertical(top: Radius.circular(9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(order.client, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      const SizedBox(height: 4),
                      Text(order.product, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                    ]),
                    Tooltip(
                      message: order.status.name,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(order.status.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  LinearProgressIndicator(value: progress.clamp(0.0, 1.0), backgroundColor: Colors.grey[200], valueColor: AlwaysStoppedAnimation(statusColor), minHeight: 6),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    _buildMetric(Icons.access_time, 'Temps restant', _formatTimeRemaining(order.updatedAt)),
                    _buildMetric(Icons.person, 'Opérateur', assignedOperator ?? 'Non assigné'),
                    _buildMetric(Icons.location_on, 'Zone', zone ?? '—', color: _zoneColor(zone)),
                  ])
                ],
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: const BorderRadius.vertical(bottom: Radius.circular(9))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Icon(Icons.drag_indicator, color: Colors.grey),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: _getPriorityColor(priority), borderRadius: BorderRadius.circular(12)),
                      child: Text('P$priority', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  Row(children: [
                    IconButton(icon: const Icon(Icons.person_add_alt_1, color: Colors.blue), onPressed: () => onAssign(docId)),
                    IconButton(icon: const Icon(Icons.info_outline, color: Colors.grey), onPressed: () => onView(docId)),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(IconData icon, String label, Object value, {Color? color}) {
    return Column(children: [
      Icon(icon, size: 20, color: color ?? Colors.grey[700]),
      const SizedBox(height: 6),
      Text(value is String ? value : value.toString(), style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A))),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
    ]);
  }

  Color _zoneColor(String? z) {
    if (z == 'Percage') return const Color(0xFF06B6D4);
    if (z == 'Coupe') return const Color(0xFFF97316);
    return const Color(0xFF8B5CF6);
  }

  String _formatTimeRemaining(DateTime? dt) {
    if (dt == null) return '??h';
    final diff = dt.difference(DateTime.now());
    if (diff.isNegative) return 'Retard';
    final hours = diff.inHours;
    final mins = diff.inMinutes % 60;
    return '${hours}h ${mins}m';
  }
}
