import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_alert.dart';
import 'package:carelog_mvp/features/machine/domain/entities/production_count.dart';
import 'package:carelog_mvp/features/machine/domain/usecases/get_machine_status.dart';
import 'package:carelog_mvp/features/machine/presentation/pages/machine_debug_page.dart';
import 'package:carelog_mvp/features/machine/presentation/providers/machine_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeMachineRepository implements IMachineRepository {
  bool called = false;

  @override
  Future<MachineStatus> getStatus(String machineId) async {
    called = true;
    return MachineStatus(id: machineId, status: 'ok', timestamp: DateTime.now());
  }

  @override
  Future<List<MachineAlert>> getAlerts(String machineId) async {
    return [];
  }

  @override
  Future<ProductionCount> getProductionCount(String machineId) async {
    return ProductionCount(id: machineId, count: 0, timestamp: DateTime.now());
  }
}

void main() {
  testWidgets('MachineDebugPage shows status after load', (tester) async {
    final fakeRepo = FakeMachineRepository();
    final fakeUsecase = GetMachineStatus(fakeRepo);

    await tester.pumpWidget(
      ProviderScope(overrides: [
        getMachineStatusUseCaseProvider.overrideWithValue(fakeUsecase),
        machineRepositoryProvider.overrideWithValue(fakeRepo),
      ], child: const MaterialApp(home: MachineDebugPage(machineId: 'm1'))),
    );

    expect(find.text('Load Status'), findsOneWidget);

    await tester.tap(find.text('Load Status'));
    await tester.pumpAndSettle();

    expect(fakeRepo.called, isTrue);
    expect(find.textContaining('Status: ok'), findsOneWidget);
  });
}
