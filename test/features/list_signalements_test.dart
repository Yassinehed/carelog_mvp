import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/list_signalements.dart';
import 'package:carelog_mvp/features/signalement/domain/entities/signalement.dart';
import 'package:carelog_mvp/features/signalement/domain/repositories/i_signalement_repository.dart';

// Fake repository implementing only what's needed
class FakeSignalementRepository implements ISignalementRepository {
  final List<Signalement> _items;
  FakeSignalementRepository(this._items);

  @override
  Future<Either<SignalementFailure, Unit>> createSignalement(Signalement signalement) async {
    return right(unit);
  }

  @override
  Future<Either<SignalementFailure, List<Signalement>>> getSignalements() async {
    return right(_items);
  }

  @override
  Future<Either<SignalementFailure, Unit>> updateSignalementStatus(String signalementId, SignalementStatus newStatus) async {
    return right(unit);
  }

  @override
  Future<Either<SignalementFailure, Signalement>> getSignalementById(String id) async {
    final found = _items.firstWhere((e) => e.id == id, orElse: () => throw StateError('not found'));
    return right(found);
  }
}

void main() {
  group('ListSignalementsUseCase', () {
    test('returns empty list when repository empty', () async {
      final fakeRepo = FakeSignalementRepository([]);
      final usecase = ListSignalementsUseCase(fakeRepo);

      final result = await usecase();

      expect(result.isRight(), true);
      result.fold((l) => fail('Expected right'), (r) => expect(r.length, 0));
    });

    test('returns items when repository has them', () async {
      final item = Signalement(
        id: '1',
        type: SignalementType.other,
        severity: SignalementSeverity.low,
        createdBy: 'tester',
        createdAt: DateTime.now(),
        description: 'd',
        status: SignalementStatus.open,
      );
      final fakeRepo = FakeSignalementRepository([item]);
      final usecase = ListSignalementsUseCase(fakeRepo);

      final result = await usecase();

      expect(result.isRight(), true);
      result.fold((l) => fail('Expected right'), (r) => expect(r.first.id, '1'));
    });
  });
}
