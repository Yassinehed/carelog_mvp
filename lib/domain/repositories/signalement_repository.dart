import 'package:dartz/dartz.dart';
import '../../domain/core/entities.dart';
import '../entities/signalement.dart';

/// Repository interface for Signalement domain operations
abstract class SignalementRepository extends BaseRepository<Signalement> {
  /// Get signalements by status
  Future<Either<Failure, List<Signalement>>> getByStatus(
      SignalementStatus status);

  /// Get signalements by priority
  Future<Either<Failure, List<Signalement>>> getByPriority(
      SignalementPriority priority);

  /// Get signalements assigned to a user
  Future<Either<Failure, List<Signalement>>> getAssignedTo(String userId);

  /// Get signalements created by a user
  Future<Either<Failure, List<Signalement>>> getCreatedBy(String userId);

  /// Get signalements by category
  Future<Either<Failure, List<Signalement>>> getByCategory(String category);

  /// Update signalement status
  Future<Either<Failure, Signalement>> updateStatus(
    String signalementId,
    SignalementStatus newStatus,
    String updatedBy,
  );

  /// Assign signalement to user
  Future<Either<Failure, Signalement>> assignTo(
    String signalementId,
    String assignedTo,
    String assignedBy,
  );

  /// Add comment to signalement
  Future<Either<Failure, Signalement>> addComment(
    String signalementId,
    String comment,
    String authorId,
  );

  /// Get signalements due today
  Future<Either<Failure, List<Signalement>>> getDueToday();

  /// Get overdue signalements
  Future<Either<Failure, List<Signalement>>> getOverdue();

  /// Get signalements by date range
  Future<Either<Failure, List<Signalement>>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get signalement statistics
  Future<Either<Failure, SignalementStats>> getStatistics();

  /// Search signalements with filters
  Future<Either<Failure, List<Signalement>>> searchWithFilters({
    String? query,
    SignalementStatus? status,
    SignalementPriority? priority,
    String? category,
    String? assignedTo,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get signalements count by status
  Future<Either<Failure, Map<SignalementStatus, int>>> getCountByStatus();

  /// Archive completed signalements older than specified days
  Future<Either<Failure, int>> archiveOldCompleted(int daysOld);
}

/// Statistics for signalements
class SignalementStats {
  final int total;
  final int open;
  final int inProgress;
  final int resolved;
  final int closed;
  final int overdue;
  final double averageResolutionTime; // in hours
  final Map<String, int> byCategory;
  final Map<String, int> byPriority;

  const SignalementStats({
    required this.total,
    required this.open,
    required this.inProgress,
    required this.resolved,
    required this.closed,
    required this.overdue,
    required this.averageResolutionTime,
    required this.byCategory,
    required this.byPriority,
  });
}
