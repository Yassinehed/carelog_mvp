import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/signalement.dart';

part 'signalement_dto.freezed.dart';
part 'signalement_dto.g.dart';

/// DTO for Signalement in Firestore.
@freezed
class SignalementDto with _$SignalementDto {
  const factory SignalementDto({
    required String id,
    required String type,
    required String severity,
    required String createdBy,
    required DateTime createdAt,
    required String description,
    required String status,
  }) = _SignalementDto;

  const SignalementDto._();

  factory SignalementDto.fromJson(Map<String, dynamic> json) =>
      _$SignalementDtoFromJson(json);

  factory SignalementDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SignalementDto.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toFirestore() => toJson()..remove('id');
}

/// Mapper between Signalement entity and DTO.
class SignalementMapper {
  static Signalement fromDto(SignalementDto dto) {
    return Signalement(
      id: dto.id,
      type: _stringToType(dto.type),
      severity: _stringToSeverity(dto.severity),
      createdBy: dto.createdBy,
      createdAt: dto.createdAt,
      description: dto.description,
      status: _stringToStatus(dto.status),
    );
  }

  static SignalementDto toDto(Signalement entity) {
    return SignalementDto(
      id: entity.id,
      type: _typeToString(entity.type),
      severity: _severityToString(entity.severity),
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      description: entity.description,
      status: statusToString(entity.status),
    );
  }

  static SignalementType _stringToType(String value) {
    switch (value) {
      case 'qualityIssue':
        return SignalementType.qualityIssue;
      case 'machineFailure':
        return SignalementType.machineFailure;
      case 'materialIssue':
        return SignalementType.materialIssue;
      case 'processIssue':
        return SignalementType.processIssue;
      case 'other':
        return SignalementType.other;
      default:
        throw ArgumentError('Invalid SignalementType: $value');
    }
  }

  static String _typeToString(SignalementType type) {
    switch (type) {
      case SignalementType.qualityIssue:
        return 'qualityIssue';
      case SignalementType.machineFailure:
        return 'machineFailure';
      case SignalementType.materialIssue:
        return 'materialIssue';
      case SignalementType.processIssue:
        return 'processIssue';
      case SignalementType.other:
        return 'other';
    }
  }

  static SignalementSeverity _stringToSeverity(String value) {
    switch (value) {
      case 'low':
        return SignalementSeverity.low;
      case 'medium':
        return SignalementSeverity.medium;
      case 'high':
        return SignalementSeverity.high;
      case 'critical':
        return SignalementSeverity.critical;
      default:
        throw ArgumentError('Invalid SignalementSeverity: $value');
    }
  }

  static String _severityToString(SignalementSeverity severity) {
    switch (severity) {
      case SignalementSeverity.low:
        return 'low';
      case SignalementSeverity.medium:
        return 'medium';
      case SignalementSeverity.high:
        return 'high';
      case SignalementSeverity.critical:
        return 'critical';
    }
  }

  static SignalementStatus _stringToStatus(String value) {
    switch (value) {
      case 'open':
        return SignalementStatus.open;
      case 'inProgress':
        return SignalementStatus.inProgress;
      case 'resolved':
        return SignalementStatus.resolved;
      case 'closed':
        return SignalementStatus.closed;
      default:
        throw ArgumentError('Invalid SignalementStatus: $value');
    }
  }

  static String statusToString(SignalementStatus status) {
    switch (status) {
      case SignalementStatus.open:
        return 'open';
      case SignalementStatus.inProgress:
        return 'inProgress';
      case SignalementStatus.resolved:
        return 'resolved';
      case SignalementStatus.closed:
        return 'closed';
    }
  }
}
