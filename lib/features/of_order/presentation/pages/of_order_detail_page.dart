import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../domain/entities/of_order.dart';
import '../providers/of_order_providers.dart';
import '../widgets/of_order_detail_card.dart';
import '../widgets/of_order_steps_widget.dart';
import '../widgets/of_order_materials_widget.dart';

class OfOrderDetailPage extends ConsumerStatefulWidget {
  final String ofOrderId;

  const OfOrderDetailPage({
    super.key,
    required this.ofOrderId,
  });

  @override
  ConsumerState<OfOrderDetailPage> createState() => _OfOrderDetailPageState();
}

class _OfOrderDetailPageState extends ConsumerState<OfOrderDetailPage> {
  late StreamSubscription _ofOrderUpdatesSubscription;
  bool _isLiveUpdate = false;

  @override
  void initState() {
    super.initState();
    _setupLiveUpdates();
  }

  @override
  void dispose() {
    _ofOrderUpdatesSubscription.cancel();
    super.dispose();
  }

  void _setupLiveUpdates() {
    final trackingService = ref.read(realTimeTrackingServiceProvider);
    
    // Avvia il tracking per questo ordine specifico
    trackingService.startOfOrderTracking(widget.ofOrderId);
    
    // Ascolta gli aggiornamenti per questo ordine specifico
    _ofOrderUpdatesSubscription = trackingService.ofOrderUpdates
        .where((order) => order.ofNumber == widget.ofOrderId) // Filtra solo questo ordine
        .listen((updatedOrder) {
          if (mounted) {
            setState(() {
              _isLiveUpdate = true;
            });
            
            // Mostra una notifica di aggiornamento live
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Statut mis à jour en temps réel'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            
            // Invalida il provider per ricaricare i dati
            ref.invalidate(ofOrderProvider(widget.ofOrderId));
            
            // Resetta il flag dopo un breve delay
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() => _isLiveUpdate = false);
              }
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final ofOrderAsync = ref.watch(ofOrderProvider(widget.ofOrderId));

    return ofOrderAsync.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Error loading order: $error'),
        ),
      ),
      data: (ofOrder) {
        if (ofOrder == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Order Not Found'),
            ),
            body: const Center(
              child: Text('Order not found'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text('Order Details'),
                if (_isLiveUpdate) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditDialog(context, ofOrder),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _showDeleteDialog(context, ref, ofOrder),
                tooltip: 'Delete',
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => _generatePdf(context, ofOrder),
                tooltip: 'Generate PDF',
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Invalidate the provider to refresh the data
              ref.invalidate(ofOrderProvider(widget.ofOrderId));
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informazioni principali dell'ordine
                  OfOrderDetailCard(ofOrder: ofOrder),

                  const SizedBox(height: 24),

                  // Workflow dei passi di produzione
                  OfOrderStepsWidget(ofOrder: ofOrder),

                  const SizedBox(height: 24),

                  // Materiali utilizzati
                  OfOrderMaterialsWidget(ofOrder: ofOrder),

                  const SizedBox(height: 24),

                  // Azioni rapide
                  _buildQuickActions(context, ref, ofOrder),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref, OfOrder ofOrder) {
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
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.arrow_forward,
                    label: 'Next Step',
                    color: Colors.blue,
                    onPressed: ofOrder.status != OfOrderStatus.completed &&
                            ofOrder.status != OfOrderStatus.cancelled
                        ? () => _advanceToNextStep(context, ref, ofOrder)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.check_circle,
                    label: 'Complete',
                    color: Colors.green,
                    onPressed: ofOrder.status != OfOrderStatus.completed &&
                            ofOrder.status != OfOrderStatus.cancelled
                        ? () => _completeOrder(context, ref, ofOrder)
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.cancel,
                    label: 'Cancel',
                    color: Colors.red,
                    onPressed: ofOrder.status != OfOrderStatus.completed &&
                            ofOrder.status != OfOrderStatus.cancelled
                        ? () => _cancelOrder(context, ref, ofOrder)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.picture_as_pdf,
                    label: 'PDF',
                    color: Colors.purple,
                    onPressed: () => _generatePdf(context, ofOrder),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? color : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, OfOrder ofOrder) {
    // TODO: Implement edit dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon')),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, OfOrder ofOrder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: Text(
          'Are you sure you want to delete order ${ofOrder.id}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feature coming soon')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _advanceToNextStep(BuildContext context, WidgetRef ref, OfOrder ofOrder) {
    // TODO: Implement advance to next step
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon')),
    );
  }

  void _completeOrder(BuildContext context, WidgetRef ref, OfOrder ofOrder) {
    // TODO: Implement complete order
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon')),
    );
  }

  void _cancelOrder(BuildContext context, WidgetRef ref, OfOrder ofOrder) {
    // TODO: Implement cancel order
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon')),
    );
  }

  void _generatePdf(BuildContext context, OfOrder ofOrder) async {
    try {
      // TODO: Get PDF service from injection
      // final pdfService = getIt<PdfService>();
      // final pdfData = await pdfService.generateOfOrderPdf(ofOrder);
      // await pdfService.previewPdf(pdfData, 'OF_${ofOrder.ofNumber}.pdf');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF generation coming soon')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }
}