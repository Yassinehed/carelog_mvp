import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/machine/domain/repositories/i_machine_repository.dart';
import 'package:carelog_mvp/injection.dart';
import 'package:carelog_mvp/features/machine/domain/usecases/get_machine_status.dart';
import 'package:carelog_mvp/features/machine/domain/entities/machine_status.dart';

final machineRepositoryProvider = Provider<IMachineRepository>((ref) {
  // Resolve via GetIt through injection.dart
  final repo = getIt.get<IMachineRepository>();
  return repo;
});

final getMachineStatusUseCaseProvider = Provider<GetMachineStatus>((ref) {
  final repo = ref.read(machineRepositoryProvider);
  return GetMachineStatus(repo);
});

class MachineStatusState {
  final MachineStatus? status;
  final bool isLoading;
  final String? error;

  MachineStatusState({this.status, this.isLoading = false, this.error});

  MachineStatusState copyWith({MachineStatus? status, bool? isLoading, String? error}) {
    return MachineStatusState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MachineStatusNotifier extends StateNotifier<MachineStatusState> {
  final GetMachineStatus _getMachineStatus;

  MachineStatusNotifier(this._getMachineStatus) : super(MachineStatusState());

  Future<void> load(String machineId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final s = await _getMachineStatus(machineId);
      state = state.copyWith(status: s, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final machineStatusNotifierProvider = StateNotifierProvider<MachineStatusNotifier, MachineStatusState>((ref) {
  final usecase = ref.read(getMachineStatusUseCaseProvider);
  return MachineStatusNotifier(usecase);
});
