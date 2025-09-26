import 'package:carelog_mvp/features/machine/domain/entities/machine_alert.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';

class ListMachineAlerts {
  final IMachineRepository repository;

  ListMachineAlerts(this.repository);

  Future<List<MachineAlert>> call(String machineId) async {
    return repository.getAlerts(machineId);
  }
}
