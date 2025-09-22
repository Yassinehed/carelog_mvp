import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/of_order/domain/entities/of_order.dart';
import 'package:carelog_mvp/features/of_order/domain/usecases/create_of_order.dart';
import 'package:carelog_mvp/features/of_order/domain/usecases/get_of_order_by_id.dart';
import 'package:carelog_mvp/features/of_order/domain/usecases/list_of_orders.dart';
import 'package:carelog_mvp/features/of_order/domain/usecases/update_of_order_status.dart';
import 'package:carelog_mvp/core/services/real_time_tracking_service.dart';
import 'package:carelog_mvp/injection.dart';

/// Provider per il caso d'uso GetOfOrdersUseCase
final getOfOrdersUseCaseProvider = Provider<GetOfOrdersUseCase>((ref) {
  // injection.config registers GetOfOrdersUseCaseImpl (concrete type).
  // Request the concrete implementation from GetIt and return it as the
  // abstract base type expected by consumers.
  return getIt<GetOfOrdersUseCase>();
});

/// Provider per il caso d'uso GetOfOrderByIdUseCase
final getOfOrderByIdUseCaseProvider = Provider<GetOfOrderByIdUseCase>((ref) {
  return getIt<GetOfOrderByIdUseCase>();
});

/// Provider per il caso d'uso CreateOfOrderUseCase
final createOfOrderUseCaseProvider = Provider<CreateOfOrderUseCase>((ref) {
  return getIt<CreateOfOrderUseCase>();
});

/// Provider per il caso d'uso UpdateOfOrderStatusUseCase
final updateOfOrderStatusUseCaseProvider =
    Provider<UpdateOfOrderStatusUseCase>((ref) {
  return getIt<UpdateOfOrderStatusUseCase>();
});

/// Stato per la lista degli ordini di produzione
class OfOrdersState {
  final List<OfOrder> orders;
  final bool isLoading;
  final String? error;

  const OfOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OfOrdersState copyWith({
    List<OfOrder>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OfOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notifier per gestire lo stato degli ordini di produzione
class OfOrdersNotifier extends StateNotifier<OfOrdersState> {
  final GetOfOrdersUseCase _getOfOrdersUseCase;
  final CreateOfOrderUseCase _createOfOrderUseCase;
  final UpdateOfOrderStatusUseCase _updateOfOrderStatusUseCase;

  OfOrdersNotifier(
    this._getOfOrdersUseCase,
    this._createOfOrderUseCase,
    this._updateOfOrderStatusUseCase,
  ) : super(const OfOrdersState());

  /// Carica tutti gli ordini di produzione
  Future<void> loadOfOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getOfOrdersUseCase();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: 'Errore nel caricamento degli ordini: ${failure.toString()}',
      ),
      (orders) => state = state.copyWith(
        orders: orders,
        isLoading: false,
        error: null,
      ),
    );
  }

  /// Crea un nuovo ordine di produzione
  Future<bool> createOfOrder(CreateOfOrderParams params) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _createOfOrderUseCase(params);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: 'Errore nella creazione dell\'ordine: ${failure.toString()}',
        );
        return false;
      },
      (_) {
        // Ricarica la lista dopo la creazione
        loadOfOrders();
        return true;
      },
    );
  }

  /// Aggiorna lo stato di un ordine di produzione
  Future<bool> updateOfOrderStatus(UpdateOfOrderStatusParams params) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _updateOfOrderStatusUseCase(params);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error:
              'Errore nell\'aggiornamento dello stato: ${failure.toString()}',
        );
        return false;
      },
      (_) {
        // Ricarica la lista dopo l'aggiornamento
        loadOfOrders();
        return true;
      },
    );
  }
}

/// Provider per il notifier degli ordini di produzione
final ofOrdersNotifierProvider =
    StateNotifierProvider<OfOrdersNotifier, OfOrdersState>((ref) {
  final getOfOrdersUseCase = ref.watch(getOfOrdersUseCaseProvider);
  final createOfOrderUseCase = ref.watch(createOfOrderUseCaseProvider);
  final updateOfOrderStatusUseCase =
      ref.watch(updateOfOrderStatusUseCaseProvider);

  return OfOrdersNotifier(
    getOfOrdersUseCase,
    createOfOrderUseCase,
    updateOfOrderStatusUseCase,
  );
});

/// Provider per recuperare un singolo ordine di produzione per ID
final ofOrderProvider = FutureProvider.family<OfOrder?, String>((ref, id) async {
  final getOfOrderByIdUseCase = ref.watch(getOfOrderByIdUseCaseProvider);
  final result = await getOfOrderByIdUseCase.call(id);
  
  return result.fold(
    (failure) => null, // In caso di errore, restituisce null
    (ofOrder) => ofOrder,
  );
});

/// Provider per il servizio di tracking in tempo reale
final realTimeTrackingServiceProvider = Provider<RealTimeTrackingService>((ref) {
  return getIt<RealTimeTrackingService>();
});
