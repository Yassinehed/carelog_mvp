import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stato del sistema per controllo costi e modalità manutenzione
class SystemStatus {
  final bool isReadOnly;
  final String? maintenanceMessage;
  final DateTime? lastUpdated;

  const SystemStatus({
    this.isReadOnly = false,
    this.maintenanceMessage,
    this.lastUpdated,
  });

  SystemStatus copyWith({
    bool? isReadOnly,
    String? maintenanceMessage,
    DateTime? lastUpdated,
  }) {
    return SystemStatus(
      isReadOnly: isReadOnly ?? this.isReadOnly,
      maintenanceMessage: maintenanceMessage ?? this.maintenanceMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  bool get isMaintenanceMode => isReadOnly;
}

/// Provider per lo stato del sistema
final systemStatusProvider =
    StateNotifierProvider<SystemStatusNotifier, SystemStatus>((ref) {
  return SystemStatusNotifier();
});

/// Notifier per gestire lo stato del sistema
class SystemStatusNotifier extends StateNotifier<SystemStatus> {
  StreamSubscription<DocumentSnapshot>? _subscription;

  SystemStatusNotifier() : super(const SystemStatus()) {
    _listenToSystemStatus();
  }

  void _listenToSystemStatus() {
    _subscription = FirebaseFirestore.instance
        .collection('config')
        .doc('system_status')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          state = SystemStatus(
            isReadOnly: data['isReadOnly'] ?? false,
            maintenanceMessage: data['maintenanceMessage'],
            lastUpdated: data['lastUpdated'] != null
                ? (data['lastUpdated'] as Timestamp).toDate()
                : null,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// Provider per controllare se il sistema è in modalità read-only
final isReadOnlyProvider = Provider<bool>((ref) {
  return ref.watch(systemStatusProvider).isReadOnly;
});

/// Provider per il messaggio di manutenzione
final maintenanceMessageProvider = Provider<String?>((ref) {
  return ref.watch(systemStatusProvider).maintenanceMessage;
});
