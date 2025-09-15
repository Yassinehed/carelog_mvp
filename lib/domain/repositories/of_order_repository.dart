import 'package:dartz/dartz.dart';
import '../../domain/core/entities.dart';
import '../entities/of_order.dart';

/// Repository interface for OfOrder domain operations
abstract class OfOrderRepository extends BaseRepository<OfOrder> {
  /// Get orders by status
  Future<Either<Failure, List<OfOrder>>> getByStatus(OfOrderStatus status);

  /// Get orders by priority
  Future<Either<Failure, List<OfOrder>>> getByPriority(
      OfOrderPriority priority);

  /// Get orders assigned to a supervisor
  Future<Either<Failure, List<OfOrder>>> getBySupervisor(String supervisorId);

  /// Get orders by production line
  Future<Either<Failure, List<OfOrder>>> getByProductionLine(
      String productionLine);

  /// Get orders by client
  Future<Either<Failure, List<OfOrder>>> getByClient(String clientName);

  /// Get orders by date range
  Future<Either<Failure, List<OfOrder>>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Update order status
  Future<Either<Failure, OfOrder>> updateStatus(
    String orderId,
    OfOrderStatus newStatus,
    String updatedBy,
  );

  /// Update production progress
  Future<Either<Failure, OfOrder>> updateProgress(
    String orderId, {
    int? progressPercentage,
    int? actualQuantity,
    int? goodQuantity,
    int? rejectedQuantity,
    double? actualCost,
    String? updatedBy,
  });

  /// Add production note
  Future<Either<Failure, OfOrder>> addProductionNote(
    String orderId,
    String note,
    String authorId,
  );

  /// Add quality check result
  Future<Either<Failure, OfOrder>> addQualityCheck(
    String orderId,
    String checkpoint,
    bool passed,
    String inspectorId,
    String? notes,
  );

  /// Get orders due today
  Future<Either<Failure, List<OfOrder>>> getDueToday();

  /// Get overdue orders
  Future<Either<Failure, List<OfOrder>>> getOverdue();

  /// Get orders with delivery overdue
  Future<Either<Failure, List<OfOrder>>> getDeliveryOverdue();

  /// Get orders in progress
  Future<Either<Failure, List<OfOrder>>> getInProgress();

  /// Get orders requiring materials
  Future<Either<Failure, List<OfOrder>>> getMaterialWaiting();

  /// Get orders in quality check
  Future<Either<Failure, List<OfOrder>>> getInQualityCheck();

  /// Get order statistics
  Future<Either<Failure, OfOrderStats>> getStatistics();

  /// Search orders with filters
  Future<Either<Failure, List<OfOrder>>> searchWithFilters({
    String? query,
    OfOrderStatus? status,
    OfOrderPriority? priority,
    String? clientName,
    String? productionLine,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get orders count by status
  Future<Either<Failure, Map<OfOrderStatus, int>>> getCountByStatus();

  /// Get material requirements for orders
  Future<Either<Failure, Map<String, double>>> getMaterialRequirements(
    List<String> orderIds,
  );

  /// Check material availability for order
  Future<Either<Failure, Map<String, bool>>> checkMaterialAvailability(
    String orderId,
  );

  /// Get production efficiency metrics
  Future<Either<Failure, ProductionMetrics>> getProductionMetrics({
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Statistics for manufacturing orders
class OfOrderStats {
  final int total;
  final int draft;
  final int planned;
  final int materialWaiting;
  final int inProgress;
  final int qualityCheck;
  final int completed;
  final int delivered;
  final int cancelled;
  final int overdue;
  final int deliveryOverdue;
  final double averageCompletionTime; // in days
  final double onTimeDeliveryRate; // percentage
  final double overallEfficiency; // percentage
  final Map<String, int> byClient;
  final Map<String, int> byPriority;

  const OfOrderStats({
    required this.total,
    required this.draft,
    required this.planned,
    required this.materialWaiting,
    required this.inProgress,
    required this.qualityCheck,
    required this.completed,
    required this.delivered,
    required this.cancelled,
    required this.overdue,
    required this.deliveryOverdue,
    required this.averageCompletionTime,
    required this.onTimeDeliveryRate,
    required this.overallEfficiency,
    required this.byClient,
    required this.byPriority,
  });
}

/// Production metrics
class ProductionMetrics {
  final double averageEfficiency;
  final double averageScrapRate;
  final int totalProduced;
  final int totalRejected;
  final Map<String, double> efficiencyByLine;
  final Map<String, double> scrapRateByLine;
  final DateTime periodStart;
  final DateTime periodEnd;

  const ProductionMetrics({
    required this.averageEfficiency,
    required this.averageScrapRate,
    required this.totalProduced,
    required this.totalRejected,
    required this.efficiencyByLine,
    required this.scrapRateByLine,
    required this.periodStart,
    required this.periodEnd,
  });
}
