import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/of_order.dart';
import '../providers/of_order_providers.dart';
import 'of_order_detail_page.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class OfOrderListPage extends ConsumerWidget {
  const OfOrderListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ofOrdersState = ref.watch(ofOrdersNotifierProvider);

    // Carica gli ordini quando la pagina viene aperta
    ref.listen(ofOrdersNotifierProvider, (previous, next) {
      if (previous?.orders.isEmpty == true && next.orders.isNotEmpty) {
        // Gli ordini sono stati caricati
      }
    });

    // Carica gli ordini all'avvio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ofOrdersState.orders.isEmpty && !ofOrdersState.isLoading) {
        ref.read(ofOrdersNotifierProvider.notifier).loadOfOrders();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ofOrdersState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ofOrdersState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        ofOrdersState.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(ofOrdersNotifierProvider.notifier)
                              .loadOfOrders();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ofOrdersState.orders.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No orders found',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref
                            .read(ofOrdersNotifierProvider.notifier)
                            .loadOfOrders();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: ofOrdersState.orders.length,
                        itemBuilder: (context, index) {
                          final ofOrder = ofOrdersState.orders[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OfOrderDetailPage(
                                      ofOrderId: ofOrder.id,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Order #${ofOrder.id}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        _buildStatusChip(context, ofOrder.status),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Client: ${ofOrder.client}',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Product: ${ofOrder.product}',
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Quantity: ${ofOrder.quantity}',
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    if (ofOrder.description != null) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Description: ${ofOrder.description}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontStyle: FontStyle.italic,
                                            ),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Text(
                                      'Created: ${DateFormat('dd/MM/yyyy HH:mm').format(ofOrder.createdAt)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                    if (ofOrder.updatedAt != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        'Updated: ${DateFormat('dd/MM/yyyy HH:mm').format(ofOrder.updatedAt!)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }

  Widget _buildStatusChip(BuildContext context, OfOrderStatus status) {
    final l10n = AppLocalizations.of(context)!;
    Color color = Colors.grey;
    String label = l10n.ofOrderStatus_unknown;

    switch (status) {
      case OfOrderStatus.materialReception:
        color = Colors.blue;
        label = l10n.ofOrderStatus_materialReception;
        break;
      case OfOrderStatus.materialPreparation:
        color = Colors.orange;
        label = l10n.ofOrderStatus_materialPreparation;
        break;
      case OfOrderStatus.productionCoupe:
        color = Colors.purple;
        label = l10n.ofOrderStatus_productionCoupe;
        break;
      case OfOrderStatus.productionProd:
        color = Colors.indigo;
        label = l10n.ofOrderStatus_productionProd;
        break;
      case OfOrderStatus.productionTest:
        color = Colors.teal;
        label = l10n.ofOrderStatus_productionTest;
        break;
      case OfOrderStatus.control:
        color = Colors.amber;
        label = l10n.ofOrderStatus_control;
        break;
      case OfOrderStatus.shipment:
        color = Colors.cyan;
        label = l10n.ofOrderStatus_shipment;
        break;
      case OfOrderStatus.completed:
        color = Colors.green;
        label = l10n.ofOrderStatus_completed;
        break;
      case OfOrderStatus.cancelled:
        color = Colors.red;
        label = l10n.ofOrderStatus_cancelled;
        break;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
