import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/of_order/domain/entities/of_order.dart';
import '../../../features/of_order/domain/repositories/i_of_order_repository.dart';
import '../../../features/signalement/domain/entities/signalement.dart';
import '../../../features/signalement/domain/repositories/i_signalement_repository.dart';
import '../../../injection.dart';

/// Statistiche per la dashboard principale
class DashboardStats {
  final int activeSignalements;
  final int pendingOrders;
  final double budgetRemaining;
  final int criticalAlerts;
  final bool isLoading;
  final String? error;

  const DashboardStats({
    this.activeSignalements = 0,
    this.pendingOrders = 0,
    this.budgetRemaining = 0.0,
    this.criticalAlerts = 0,
    this.isLoading = false,
    this.error,
  });

  DashboardStats copyWith({
    int? activeSignalements,
    int? pendingOrders,
    double? budgetRemaining,
    int? criticalAlerts,
    bool? isLoading,
    String? error,
  }) {
    return DashboardStats(
      activeSignalements: activeSignalements ?? this.activeSignalements,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      budgetRemaining: budgetRemaining ?? this.budgetRemaining,
      criticalAlerts: criticalAlerts ?? this.criticalAlerts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get hasError => error != null;
}

/// Provider per i repository
final signalementRepositoryProvider = Provider<ISignalementRepository>((ref) {
  return getIt<ISignalementRepository>();
});

final ofOrderRepositoryProvider = Provider<IOfOrderRepository>((ref) {
  return getIt<IOfOrderRepository>();
});

/// Provider per le statistiche della dashboard
final dashboardStatsProvider =
    StateNotifierProvider<DashboardStatsNotifier, DashboardStats>((ref) {
  final signalementRepo = ref.watch(signalementRepositoryProvider);
  final ofOrderRepo = ref.watch(ofOrderRepositoryProvider);
  return DashboardStatsNotifier(signalementRepo, ofOrderRepo);
});

/// Notifier per gestire le statistiche della dashboard
class DashboardStatsNotifier extends StateNotifier<DashboardStats> {
  final ISignalementRepository _signalementRepository;
  final IOfOrderRepository _ofOrderRepository;

  Timer? _refreshTimer;

  DashboardStatsNotifier(this._signalementRepository, this._ofOrderRepository)
      : super(const DashboardStats(isLoading: true)) {
    _loadStats();
    // Aggiorna le statistiche ogni 30 secondi
    _refreshTimer =
        Timer.periodic(const Duration(seconds: 30), (_) => _loadStats());
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadStats() async {
    if (state.isLoading) return; // Evita chiamate multiple simultanee

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Charge les signalements actifs (tous sauf resolved et closed)
      final signalementsResult = await _signalementRepository.getSignalements();
      final activeSignalements = signalementsResult.fold(
        (failure) => 0,
        (signalements) => signalements
            .where((s) =>
                s.status != SignalementStatus.resolved &&
                s.status != SignalementStatus.closed)
            .length,
      );

      // Carica ordini in attesa (tutti tranne completed e cancelled)
      final ordersResult = await _ofOrderRepository.getOfOrders();
      final pendingOrders = ordersResult.fold(
        (failure) => 0,
        (orders) => orders
            .where((o) =>
                o.status != OfOrderStatus.completed &&
                o.status != OfOrderStatus.cancelled)
            .length,
      );

      // Per ora budget hardcoded - in futuro verrà dal sistema di monitoraggio GCP
      const budgetRemaining = 2450.0;

      // Alert critici: per ora 0, in futuro basati su regole di business
      const criticalAlerts = 0;

      state = state.copyWith(
        activeSignalements: activeSignalements,
        pendingOrders: pendingOrders,
        budgetRemaining: budgetRemaining,
        criticalAlerts: criticalAlerts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors du chargement des statistiques: ${e.toString()}',
      );
    }
  }

  /// Forza l'aggiornamento delle statistiche
  Future<void> refresh() async {
    await _loadStats();
  }
}
