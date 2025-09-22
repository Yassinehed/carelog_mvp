import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/list_signalements.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/create_signalement.dart';
import 'package:carelog_mvp/features/signalement/domain/usecases/update_signalement_status.dart';
import 'package:carelog_mvp/features/signalement/domain/entities/signalement.dart';
import 'package:carelog_mvp/features/signalement/presentation/widgets/signalement_filters.dart';
import 'package:carelog_mvp/core/services/real_time_tracking_service.dart';
import 'package:carelog_mvp/injection.dart';

// Use case providers
final listSignalementsUseCaseProvider =
    Provider<ListSignalementsUseCase>((ref) {
  return getIt<ListSignalementsUseCase>();
});

final createSignalementUseCaseProvider =
    Provider<CreateSignalementUseCase>((ref) {
  return getIt<CreateSignalementUseCase>();
});

final updateSignalementStatusUseCaseProvider =
    Provider<UpdateSignalementStatusUseCase>((ref) {
  return getIt<UpdateSignalementStatusUseCase>();
});

// Signalements list provider
final signalementsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(listSignalementsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load signalements'),
    (signalements) => signalements,
  );
});

// Filter parameters provider
final signalementFiltersProvider = StateNotifierProvider<SignalementFiltersNotifier, SignalementFilterData?>((ref) {
  return SignalementFiltersNotifier();
});

class SignalementFiltersNotifier extends StateNotifier<SignalementFilterData?> {
  SignalementFiltersNotifier() : super(null);

  void setFilters(SignalementFilterData? filters) {
    state = filters;
  }

  void clearFilters() {
    state = null;
  }

  void setType(SignalementType? type) {
    state = SignalementFilterData(
      type: type,
      severity: state?.severity,
      status: state?.status,
    );
  }

  void setSeverity(SignalementSeverity? severity) {
    state = SignalementFilterData(
      type: state?.type,
      severity: severity,
      status: state?.status,
    );
  }

  void setStatus(SignalementStatus? status) {
    state = SignalementFilterData(
      type: state?.type,
      severity: state?.severity,
      status: status,
    );
  }
}

// Filtered signalements provider
final filteredSignalementsProvider = Provider<List<Signalement>>((ref) {
  final signalementsAsync = ref.watch(signalementsProvider);
  final filters = ref.watch(signalementFiltersProvider);

  return signalementsAsync.maybeWhen(
    data: (signalements) {
      if (filters == null) return signalements;
      return signalements.where(filters.matches).toList();
    },
    orElse: () => [],
  );
});

// Single signalement provider
final signalementProvider = FutureProvider.family<Signalement?, String>((ref, signalementId) async {
  final signalementsAsync = ref.watch(signalementsProvider);
  return signalementsAsync.maybeWhen(
    data: (signalements) {
      return signalements.where((s) => s.id == signalementId).firstOrNull;
    },
    orElse: () => null,
  );
});

// Form state providers
final signalementFormProvider = StateNotifierProvider<SignalementFormNotifier, SignalementFormState>((ref) {
  return SignalementFormNotifier();
});

class SignalementFormNotifier extends StateNotifier<SignalementFormState> {
  SignalementFormNotifier() : super(SignalementFormState());

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateType(SignalementType type) {
    state = state.copyWith(type: type);
  }

  void updateSeverity(SignalementSeverity severity) {
    state = state.copyWith(severity: severity);
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  void setSubmitting(bool submitting) {
    state = state.copyWith(isSubmitting: submitting);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void reset() {
    state = SignalementFormState();
  }

  bool get isValid {
    return state.title.isNotEmpty &&
           state.description.isNotEmpty &&
           state.type != null &&
           state.severity != null;
  }
}

class SignalementFormState {
  final String title;
  final String description;
  final SignalementType? type;
  final SignalementSeverity? severity;
  final String location;
  final bool isSubmitting;
  final String? error;

  SignalementFormState({
    this.title = '',
    this.description = '',
    this.type,
    this.severity,
    this.location = '',
    this.isSubmitting = false,
    this.error,
  });

  SignalementFormState copyWith({
    String? title,
    String? description,
    SignalementType? type,
    SignalementSeverity? severity,
    String? location,
    bool? isSubmitting,
    String? error,
  }) {
    return SignalementFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      location: location ?? this.location,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }
}

// Status update provider
final updateSignalementStatusProvider = FutureProvider.family<void, UpdateSignalementStatusParams>((ref, params) async {
  final useCase = ref.watch(updateSignalementStatusUseCaseProvider);
  final result = await useCase(params);

  return result.fold(
    (failure) => throw Exception('Failed to update signalement status'),
    (_) => null,
  );
});

/// Provider per il servizio di tracking in tempo reale
final realTimeTrackingServiceProvider = Provider<RealTimeTrackingService>((ref) {
  return getIt<RealTimeTrackingService>();
});
