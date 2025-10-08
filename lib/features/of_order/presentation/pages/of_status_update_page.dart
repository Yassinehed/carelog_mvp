import 'package:flutter/material.dart';
import '../../domain/entities/of_order.dart';

/// Simple operator page to update OF status with large buttons.
class OfStatusUpdatePage extends StatelessWidget {
  final String ofId;
  final void Function(OfOrderStatus) onStatusSelected;

  const OfStatusUpdatePage({Key? key, required this.ofId, required this.onStatusSelected}) : super(key: key);

  Widget _bigButton(BuildContext context, String label, OfOrderStatus status) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
        onPressed: () => onStatusSelected(status),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update OF $ofId')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _bigButton(context, 'Mark Material Reception', OfOrderStatus.materialReception),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Preparation', OfOrderStatus.materialPreparation),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Production Coupe', OfOrderStatus.productionCoupe),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Production', OfOrderStatus.productionProd),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Test', OfOrderStatus.productionTest),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Control', OfOrderStatus.control),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Shipment', OfOrderStatus.shipment),
            const SizedBox(height: 12),
            _bigButton(context, 'Mark Completed', OfOrderStatus.completed),
          ],
        ),
      ),
    );
  }
}
