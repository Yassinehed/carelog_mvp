import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/list_signalements.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/create_signalement.dart';
import 'package:carelog_mvp/injection.dart';

final listSignalementsUseCaseProvider =
    Provider<ListSignalementsUseCase>((ref) {
  return getIt<ListSignalementsUseCase>();
});

final createSignalementUseCaseProvider =
    Provider<CreateSignalementUseCase>((ref) {
  return getIt<CreateSignalementUseCase>();
});

final signalementsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(listSignalementsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load signalements'),
    (signalements) => signalements,
  );
});
