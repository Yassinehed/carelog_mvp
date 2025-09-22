import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/of_order/presentation/providers/of_order_providers.dart';
import '../../../features/of_order/domain/entities/of_order.dart';
import '../../../features/signalement/presentation/providers/signalement_providers.dart';
import '../../../features/signalement/domain/entities/signalement.dart';
import '../../../features/material/presentation/providers/material_providers.dart';
import '../../../domain/entities/material.dart';

/// Provider per le statistiche della dashboard
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  // Ottieni statistiche dagli ordini di produzione
  final ofOrdersAsync = ref.watch(ofOrdersNotifierProvider);
  final ofOrders = ofOrdersAsync.orders;

  // Calcola statistiche OfOrder
  final totalOfOrders = ofOrders.length;
  final activeOfOrders = ofOrders.where((order) =>
    order.status != OfOrderStatus.completed &&
    order.status != OfOrderStatus.cancelled
  ).length;
  final completedOfOrders = ofOrders.where((order) =>
    order.status == OfOrderStatus.completed
  ).length;

  // Ottieni statistiche dalle segnalazioni
  final signalementsAsync = ref.watch(signalementsProvider);
  final signalements = signalementsAsync.maybeWhen(
    data: (data) => data,
    orElse: () => <Signalement>[],
  );

  // Calcola statistiche Signalement
  final totalSignalements = signalements.length;
  final openSignalements = signalements.where((signalement) =>
    signalement.status != SignalementStatus.resolved &&
    signalement.status != SignalementStatus.closed
  ).length;
  final urgentSignalements = signalements.where((signalement) =>
    signalement.severity == SignalementSeverity.critical ||
    signalement.severity == SignalementSeverity.high
  ).length;

  // Ottieni statistiche dai materiali
  final materialsAsync = ref.watch(materialsProvider);
  final materials = materialsAsync.maybeWhen(
    data: (data) => data,
    orElse: () => <Material>[],
  );

  // Calcola statistiche Material
  final totalMaterials = materials.length;
  final lowStockMaterials = materials.where((material) =>
    material.currentStock <= material.minimumStock
  ).length;

  return DashboardStats(
    ofOrders: OfOrderStats(
      total: totalOfOrders,
      active: activeOfOrders,
      completed: completedOfOrders,
    ),
    signalements: SignalementStats(
      total: totalSignalements,
      open: openSignalements,
      urgent: urgentSignalements,
    ),
    materials: MaterialStats(
      total: totalMaterials,
      lowStock: lowStockMaterials,
    ),
  );
});

/// Classe per contenere tutte le statistiche della dashboard
class DashboardStats {
  final OfOrderStats ofOrders;
  final SignalementStats signalements;
  final MaterialStats materials;

  const DashboardStats({
    required this.ofOrders,
    required this.signalements,
    required this.materials,
  });
}

/// Statistiche per gli ordini di produzione
class OfOrderStats {
  final int total;
  final int active;
  final int completed;

  const OfOrderStats({
    required this.total,
    required this.active,
    required this.completed,
  });

  double get completionRate =>
    total > 0 ? (completed / total) * 100 : 0.0;
}

/// Statistiche per le segnalazioni
class SignalementStats {
  final int total;
  final int open;
  final int urgent;

  const SignalementStats({
    required this.total,
    required this.open,
    required this.urgent,
  });

  double get resolutionRate =>
    total > 0 ? ((total - open) / total) * 100 : 0.0;
}

/// Statistiche per i materiali
class MaterialStats {
  final int total;
  final int lowStock;

  const MaterialStats({
    required this.total,
    required this.lowStock,
  });

  double get stockHealthRate =>
    total > 0 ? ((total - lowStock) / total) * 100 : 0.0;
}