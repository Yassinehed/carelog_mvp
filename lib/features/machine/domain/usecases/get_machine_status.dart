import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';

class GetMachineStatus {
  final IMachineRepository repository;

  GetMachineStatus(this.repository);

  Future<MachineStatus> call(String machineId) async {
    return repository.getStatus(machineId);
  }
}
