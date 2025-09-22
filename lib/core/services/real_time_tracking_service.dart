import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/of_order_model.dart';
import '../../../data/models/signalement_model.dart';
import '../../../data/models/material_model.dart' as material_model;

/// Service for real-time tracking of CareLog entities
class RealTimeTrackingService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final Map<String, StreamSubscription> _subscriptions = {};

  // Stream controllers for live updates
  final StreamController<OfOrder> _ofOrderUpdates = StreamController<OfOrder>.broadcast();
  final StreamController<Signalement> _signalementUpdates = StreamController<Signalement>.broadcast();
  final StreamController<material_model.Material> _materialUpdates = StreamController<material_model.Material>.broadcast();
  final StreamController<Map<String, int>> _statsUpdates = StreamController<Map<String, int>>.broadcast();

  // Public streams
  Stream<OfOrder> get ofOrderUpdates => _ofOrderUpdates.stream;
  Stream<Signalement> get signalementUpdates => _signalementUpdates.stream;
  Stream<material_model.Material> get materialUpdates => _materialUpdates.stream;
  Stream<Map<String, int>> get statsUpdates => _statsUpdates.stream;

  /// Initialize real-time tracking
  Future<void> initialize() async {
    await _setupStatsTracking();
  }

  /// Start tracking OF Order updates
  void startOfOrderTracking(String orderId) {
    final subscriptionKey = 'of_order_$orderId';

    if (_subscriptions.containsKey(subscriptionKey)) {
      return; // Already tracking
    }

    final subscription = _database
        .ref('of_orders/$orderId')
        .onValue
        .listen((event) {
          if (event.snapshot.value != null) {
            try {
              final data = Map<String, dynamic>.from(event.snapshot.value as Map);
              final order = OfOrder.fromJson(data);
              _ofOrderUpdates.add(order);
            } catch (e) {
              debugPrint('Error parsing OF Order update: $e');
            }
          }
        });

    _subscriptions[subscriptionKey] = subscription;
  }

  /// Start tracking Signalement updates
  void startSignalementTracking(String signalementId) {
    final subscriptionKey = 'signalement_$signalementId';

    if (_subscriptions.containsKey(subscriptionKey)) {
      return; // Already tracking
    }

    final subscription = _database
        .ref('signalements/$signalementId')
        .onValue
        .listen((event) {
          if (event.snapshot.value != null) {
            try {
              final data = Map<String, dynamic>.from(event.snapshot.value as Map);
              final signalement = Signalement.fromJson(data);
              _signalementUpdates.add(signalement);
            } catch (e) {
              debugPrint('Error parsing Signalement update: $e');
            }
          }
        });

    _subscriptions[subscriptionKey] = subscription;
  }

  /// Start tracking Material updates
  void startMaterialTracking(String materialId) {
    final subscriptionKey = 'material_$materialId';

    if (_subscriptions.containsKey(subscriptionKey)) {
      return; // Already tracking
    }

    final subscription = _database
        .ref('materials/$materialId')
        .onValue
        .listen((event) {
          if (event.snapshot.value != null) {
            try {
              final data = Map<String, dynamic>.from(event.snapshot.value as Map);
              final material = material_model.Material.fromJson(data);
              _materialUpdates.add(material);
            } catch (e) {
              debugPrint('Error parsing Material update: $e');
            }
          }
        });

    _subscriptions[subscriptionKey] = subscription;
  }

  /// Stop tracking specific entity
  void stopTracking(String entityType, String entityId) {
    final subscriptionKey = '${entityType}_$entityId';
    final subscription = _subscriptions[subscriptionKey];

    if (subscription != null) {
      subscription.cancel();
      _subscriptions.remove(subscriptionKey);
    }
  }

  /// Update OF Order status in real-time
  Future<void> updateOfOrderStatus(String orderId, OfOrderStatus newStatus) async {
    try {
      await _database.ref('of_orders/$orderId').update({
        'status': newStatus.name,
        'updatedAt': ServerValue.timestamp,
      });
    } catch (e) {
      debugPrint('Error updating OF Order status: $e');
      rethrow;
    }
  }

  /// Update Signalement status in real-time
  Future<void> updateSignalementStatus(String signalementId, SignalementStatus newStatus) async {
    try {
      await _database.ref('signalements/$signalementId').update({
        'status': newStatus.name,
        'updatedAt': ServerValue.timestamp,
      });
    } catch (e) {
      debugPrint('Error updating Signalement status: $e');
      rethrow;
    }
  }

  /// Update Material stock in real-time
  Future<void> updateMaterialStock(String materialId, double newStock) async {
    try {
      await _database.ref('materials/$materialId').update({
        'currentStock': newStock,
        'updatedAt': ServerValue.timestamp,
      });
    } catch (e) {
      debugPrint('Error updating Material stock: $e');
      rethrow;
    }
  }

  /// Send real-time notification
  Future<void> sendNotification(String userId, String type, String message, Map<String, dynamic>? data) async {
    try {
      final notificationRef = _database.ref('notifications').push();
      await notificationRef.set({
        'userId': userId,
        'type': type,
        'message': message,
        'data': data ?? {},
        'read': false,
        'createdAt': ServerValue.timestamp,
      });
    } catch (e) {
      debugPrint('Error sending notification: $e');
      rethrow;
    }
  }

  /// Setup live statistics tracking
  Future<void> _setupStatsTracking() async {
    final statsRef = _database.ref('live_stats');

    final subscription = statsRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        try {
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          final stats = <String, int>{
            'of_orders': (data['of_orders'] as num?)?.toInt() ?? 0,
            'signalements': (data['signalements'] as num?)?.toInt() ?? 0,
            'materials': (data['materials'] as num?)?.toInt() ?? 0,
          };
          _statsUpdates.add(stats);
        } catch (e) {
          debugPrint('Error parsing stats update: $e');
        }
      }
    });

    _subscriptions['stats'] = subscription;
  }

  /// Update live statistics
  Future<void> updateLiveStats(String category, int count) async {
    try {
      await _database.ref('live_stats/$category').set(count);
    } catch (e) {
      debugPrint('Error updating live stats: $e');
      rethrow;
    }
  }

  /// Cleanup all subscriptions
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();

    _ofOrderUpdates.close();
    _signalementUpdates.close();
    _materialUpdates.close();
    _statsUpdates.close();
  }
}

/// Provider for RealTimeTrackingService
final realTimeTrackingServiceProvider = Provider<RealTimeTrackingService>((ref) {
  final service = RealTimeTrackingService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});
