import 'package:flutter_test/flutter_test.dart';
import 'package:carelog_mvp/features/signalement/data/models/signalement_dto.dart';
import 'package:carelog_mvp/features/signalement/domain/entities/signalement.dart';

void main() {
  group('SignalementMapper', () {
    final testDto = SignalementDto(
      id: '1',
      type: 'qualityIssue',
      severity: 'high',
      createdBy: 'user1',
      createdAt: DateTime(2023, 1, 1),
      description: 'Test description',
      status: 'open',
    );

    final testEntity = Signalement(
      id: '1',
      type: SignalementType.qualityIssue,
      severity: SignalementSeverity.high,
      createdBy: 'user1',
      createdAt: DateTime(2023, 1, 1),
      description: 'Test description',
      status: SignalementStatus.open,
    );

    test('fromDto should convert DTO to entity correctly', () {
      final result = SignalementMapper.fromDto(testDto);
      expect(result, equals(testEntity));
    });

    test('toDto should convert entity to DTO correctly', () {
      final result = SignalementMapper.toDto(testEntity);
      expect(result, equals(testDto));
    });

    test('statusToString should convert status correctly', () {
      expect(SignalementMapper.statusToString(SignalementStatus.open), 'open');
      expect(SignalementMapper.statusToString(SignalementStatus.inProgress),
          'inProgress');
      expect(SignalementMapper.statusToString(SignalementStatus.resolved),
          'resolved');
      expect(
          SignalementMapper.statusToString(SignalementStatus.closed), 'closed');
    });
  });
}
