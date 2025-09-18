import 'package:freezed_annotation/freezed_annotation.dart';

part 'signalement.freezed.dart';

/// Signalement entity representing a report/issue in the system.
@freezed
class Signalement with _$Signalement {
  const factory Signalement({
    required String id,
    required SignalementType type,
    required SignalementSeverity severity,
    required String createdBy,
    required DateTime createdAt,
    required String description,
    required SignalementStatus status,
  }) = _Signalement;

  const Signalement._();
}

/// Type of signalement (e.g., quality issue, machine failure).
enum SignalementType {
  qualityIssue,
  machineFailure,
  materialIssue,
  processIssue,
  other,
}

/// Severity level of the signalement.
enum SignalementSeverity {
  low,
  medium,
  high,
  critical,
}

/// Status of the signalement.
enum SignalementStatus {
  open,
  inProgress,
  resolved,
  closed,
}
