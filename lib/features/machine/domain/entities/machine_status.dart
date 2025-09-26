import 'package:freezed_annotation/freezed_annotation.dart';

part 'machine_status.freezed.dart';
part 'machine_status.g.dart';

@freezed
class MachineStatus with _$MachineStatus {
  const factory MachineStatus({
    required String id,
    required String status,
    DateTime? timestamp,
  }) = _MachineStatus;

  factory MachineStatus.fromJson(Map<String, dynamic> json) => _$MachineStatusFromJson(json);
}
