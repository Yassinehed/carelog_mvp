import 'package:flutter/material.dart';
import '../../domain/entities/of_order.dart';

/// Widget per mostrare i passi del workflow di produzione
class OfOrderStepsWidget extends StatelessWidget {
  final OfOrder ofOrder;

  const OfOrderStepsWidget({
    super.key,
    required this.ofOrder,
  });

  @override
  Widget build(BuildContext context) {
    final steps = _getProductionSteps();
    final currentStepIndex = _getCurrentStepIndex(ofOrder.status);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.timeline,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Workflow di Produzione',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getProgressColor(currentStepIndex, steps.length).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${currentStepIndex + 1}/${steps.length}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getProgressColor(currentStepIndex, steps.length),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress bar
            LinearProgressIndicator(
              value: (currentStepIndex + 1) / steps.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(currentStepIndex, steps.length),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${((currentStepIndex + 1) / steps.length * 100).toStringAsFixed(1)}% completato',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),

            const SizedBox(height: 20),

            // Lista dei passi
            ...steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = index < currentStepIndex;
              final isCurrent = index == currentStepIndex;
              final isPending = index > currentStepIndex;

              return _buildStepItem(
                context,
                step: step,
                index: index,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
                isPending: isPending,
              );
            }),
          ],
        ),
      ),
    );
  }

  List<String> _getProductionSteps() {
    return [
      'Ricezione Materiali',
      'Preparazione Materiali',
      'Produzione Coupe',
      'Produzione',
      'Test Produzione',
      'Controllo Qualità',
      'Spedizione',
    ];
  }

  int _getCurrentStepIndex(OfOrderStatus status) {
    switch (status) {
      case OfOrderStatus.materialReception:
        return 0;
      case OfOrderStatus.materialPreparation:
        return 1;
      case OfOrderStatus.productionCoupe:
        return 2;
      case OfOrderStatus.productionProd:
        return 3;
      case OfOrderStatus.productionTest:
        return 4;
      case OfOrderStatus.control:
        return 5;
      case OfOrderStatus.shipment:
        return 6;
      case OfOrderStatus.completed:
        return 7; // Oltre l'ultimo passo
      case OfOrderStatus.cancelled:
        return -1; // Non applicabile
    }
  }

  Color _getProgressColor(int currentStepIndex, int totalSteps) {
    if (currentStepIndex < 0) return Colors.red; // Annullato
    if (currentStepIndex >= totalSteps) return Colors.green; // Completato

    final progress = (currentStepIndex + 1) / totalSteps;
    if (progress >= 0.8) return Colors.green;
    if (progress >= 0.5) return Colors.orange;
    return Colors.blue;
  }

  Widget _buildStepItem(
    BuildContext context, {
    required String step,
    required int index,
    required bool isCompleted,
    required bool isCurrent,
    required bool isPending,
  }) {
    Color iconColor;
    Color backgroundColor;
    IconData iconData;

    if (isCompleted) {
      iconColor = Colors.green;
      backgroundColor = Colors.green.withValues(alpha: 0.1);
      iconData = Icons.check_circle;
    } else if (isCurrent) {
      iconColor = Colors.blue;
      backgroundColor = Colors.blue.withValues(alpha: 0.1);
      iconData = Icons.radio_button_checked;
    } else {
      iconColor = Colors.grey;
      backgroundColor = Colors.grey.withValues(alpha: 0.1);
      iconData = Icons.radio_button_unchecked;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Icona dello step
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // Linea connettore (eccetto per l'ultimo elemento)
          if (index < _getProductionSteps().length - 1)
            Container(
              width: 2,
              height: 32,
              color: isCompleted ? Colors.green.withValues(alpha: 0.3) : Colors.grey[300],
            )
          else
            const SizedBox(width: 2, height: 32),

          const SizedBox(width: 12),

          // Testo dello step
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCompleted
                            ? Colors.green
                            : isCurrent
                                ? Colors.blue
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                if (isCurrent) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Passo attuale',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ],
            ),
          ),

          // Numero del passo
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted || isCurrent
                  ? iconColor.withValues(alpha: 0.1)
                  : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isCompleted || isCurrent ? iconColor : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}