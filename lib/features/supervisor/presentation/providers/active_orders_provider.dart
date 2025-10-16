import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/of_order/domain/entities/of_order.dart';

/// A lightweight wrapper combining the OfOrder entity and Firestore metadata used by the supervisor UI.
class OrderWithMeta {
  final OfOrder order;
  final int priority;
  final String? assignedOperator;
  final String? zone;
  final String docId;

  OrderWithMeta({required this.order, required this.priority, this.assignedOperator, this.zone, required this.docId});
}

/// Streams active OF orders from Firestore with optional filters and returns OrderWithMeta for UI use.
final activeOrdersProvider = StreamProvider.family<List<OrderWithMeta>, Map<String, dynamic>?>((ref, filters) {
  final firestore = FirebaseFirestore.instance;
  Query<Map<String, dynamic>> query = firestore.collection('of_orders');

  if (filters != null) {
    final status = filters['status'] as String?;
    final zone = filters['zone'] as String?;
    final priority = filters['priority'] as int?;
    if (status != null && status.isNotEmpty) query = query.where('status', isEqualTo: status);
    if (zone != null && zone.isNotEmpty) query = query.where('zone', isEqualTo: zone);
    if (priority != null) query = query.where('priority', isEqualTo: priority);
  }

  query = query.orderBy('priority', descending: false).limit(500);

  return query.snapshots().map((snap) => snap.docs.map((d) {
        final data = d.data();
        final statusStr = data['status'] as String? ?? '';
        final status = _statusFromString(statusStr);
        final ofOrder = OfOrder(
          id: d.id,
          client: data['client'] as String? ?? '',
          product: data['product'] as String? ?? '',
          quantity: (data['quantity'] as num?)?.toInt() ?? 0,
          status: status,
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          description: data['description'] as String?,
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
        );

        return OrderWithMeta(
          order: ofOrder,
          priority: (data['priority'] as num?)?.toInt() ?? 0,
          assignedOperator: data['assignedOperator'] as String?,
          zone: data['zone'] as String?,
          docId: d.id,
        );
      }).toList());
});

OfOrderStatus _statusFromString(String s) {
  try {
    return OfOrderStatus.values.firstWhere((e) => e.name == s);
  } catch (_) {
    return OfOrderStatus.productionProd;
  }
}

