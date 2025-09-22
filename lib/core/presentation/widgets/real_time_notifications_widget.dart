import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/real_time_tracking_service.dart';

/// Widget for displaying real-time notifications
class RealTimeNotificationsWidget extends ConsumerStatefulWidget {
  const RealTimeNotificationsWidget({super.key});

  @override
  ConsumerState<RealTimeNotificationsWidget> createState() => _RealTimeNotificationsWidgetState();
}

class _RealTimeNotificationsWidgetState extends ConsumerState<RealTimeNotificationsWidget> {
  final List<NotificationItem> _notifications = [];
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _setupNotificationListeners();
  }

  void _setupNotificationListeners() {
    final trackingService = ref.read(realTimeTrackingServiceProvider);

    // Listen for OF Order updates
    trackingService.ofOrderUpdates.listen((order) {
      _addNotification(
        'Ordre ${order.ofNumber} mis à jour',
        'Statut: ${order.status.name}',
        Icons.assignment,
        Colors.blue,
      );
    });

    // Listen for Signalement updates
    trackingService.signalementUpdates.listen((signalement) {
      _addNotification(
        'Signalement ${signalement.id} mis à jour',
        'Statut: ${signalement.status.name}',
        Icons.warning,
        Colors.orange,
      );
    });

    // Listen for Material updates
    trackingService.materialUpdates.listen((material) {
      _addNotification(
        'Matériau ${material.name} mis à jour',
        'Stock: ${material.currentStock}',
        Icons.inventory,
        Colors.green,
      );
    });
  }

  void _addNotification(String title, String message, IconData icon, Color color) {
    setState(() {
      _notifications.insert(0, NotificationItem(
        title: title,
        message: message,
        icon: icon,
        color: color,
        timestamp: DateTime.now(),
      ));

      // Keep only last 10 notifications
      if (_notifications.length > 10) {
        _notifications.removeLast();
      }
    });

    // Auto-hide after 5 seconds if not expanded
    if (!_isExpanded) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && !_isExpanded) {
          setState(() {
            _notifications.clear();
          });
        }
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _notifications.clear();
      }
    });
  }

  void _dismissNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 80,
      right: 16,
      left: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: _isExpanded ? 400 : 120,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              InkWell(
                onTap: _toggleExpanded,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mises à jour en temps réel',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),

              // Notifications list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Dismissible(
                      key: Key('${notification.timestamp.millisecondsSinceEpoch}_$index'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _dismissNotification(index),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: notification.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                notification.icon,
                                color: notification.color,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    notification.message,
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodySmall?.color,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _formatTimestamp(notification.timestamp),
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Footer with clear all button
              if (_isExpanded && _notifications.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_notifications.length} notification(s)',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _notifications.clear();
                          });
                        },
                        child: const Text('Tout effacer'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} h';
    } else {
      return 'Il y a ${difference.inDays} j';
    }
  }
}

/// Data class for notification items
class NotificationItem {
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final DateTime timestamp;

  NotificationItem({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.timestamp,
  });
}