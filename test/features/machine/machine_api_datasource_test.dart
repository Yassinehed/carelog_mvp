import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:carelog_mvp/features/machine/data/datasources/machine_api_datasource.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';

@GenerateMocks([Dio])
import 'machine_api_datasource_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late MachineApiDatasource datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = MachineApiDatasource(mockDio);
  });

  test('getStatus returns MachineStatus when Dio returns valid response', () async {
    final machineJson = {"id": "m1", "status": "running", "timestamp": DateTime.now().toIso8601String()};
    final response = Response(requestOptions: RequestOptions(path: '/'), data: machineJson, statusCode: 200);

    when(mockDio.get('/machines/m1/status')).thenAnswer((_) async => response);

    final result = await datasource.getStatus('m1');

    expect(result, isA<MachineStatus>());
    expect(result.id, 'm1');
  });
}
