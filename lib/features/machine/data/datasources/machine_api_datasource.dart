import 'package:dio/dio.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_alert.dart';
import 'package:carelog_mvp/features/machine/domain/entities/production_count.dart';

class MachineApiDatasource {
  final Dio _dio;

  MachineApiDatasource(this._dio);

  Future<MachineStatus> getStatus(String machineId) async {
    final response = await _dio.get('/machines/$machineId/status');
    return MachineStatus.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<MachineAlert>> getAlerts(String machineId) async {
    final response = await _dio.get('/machines/$machineId/alerts');
    final data = response.data as List<dynamic>;
    return data.map((e) => MachineAlert.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ProductionCount> getProductionCount(String machineId) async {
    final response = await _dio.get('/machines/$machineId/production');
    return ProductionCount.fromJson(response.data as Map<String, dynamic>);
  }
}
