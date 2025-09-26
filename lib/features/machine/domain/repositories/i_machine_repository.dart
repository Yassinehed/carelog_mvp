import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_alert.dart';
import 'package:carelog_mvp/features/machine/domain/entities/production_count.dart';

abstract class IMachineRepository {
  Future<MachineStatus> getStatus(String machineId);
  Future<List<MachineAlert>> getAlerts(String machineId);
  Future<ProductionCount> getProductionCount(String machineId);
}
