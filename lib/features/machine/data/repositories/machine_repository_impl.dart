import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_alert.dart';
import 'package:carelog_mvp/features/machine/domain/entities/production_count.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';
import 'package:carelog_mvp/features/machine/data/datasources/machine_api_datasource.dart';

class MachineRepositoryImpl implements IMachineRepository {
  final MachineApiDatasource datasource;

  MachineRepositoryImpl(this.datasource);

  @override
  Future<MachineStatus> getStatus(String machineId) => datasource.getStatus(machineId);

  @override
  Future<List<MachineAlert>> getAlerts(String machineId) => datasource.getAlerts(machineId);

  @override
  Future<ProductionCount> getProductionCount(String machineId) => datasource.getProductionCount(machineId);
}
