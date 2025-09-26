import 'package:freezed_annotation/freezed_annotation.dart';

part 'machine_alert.freezed.dart';
part 'machine_alert.g.dart';

@freezed
class MachineAlert with _$MachineAlert {
  const factory MachineAlert({
    required String id,
    required String code,
    required String message,
    DateTime? timestamp,
  }) = _MachineAlert;

  factory MachineAlert.fromJson(Map<String, dynamic> json) => _$MachineAlertFromJson(json);
}
