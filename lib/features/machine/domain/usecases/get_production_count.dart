import 'package:carelog_mvp/features/machine/domain/entities/production_count.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';

class GetProductionCount {
  final IMachineRepository repository;

  GetProductionCount(this.repository);

  Future<ProductionCount> call(String machineId) async {
    return repository.getProductionCount(machineId);
  }
}
