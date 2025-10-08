import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/of_order.dart';
import '../../domain/usecases/transition_of_order.dart';

final _getIt = GetIt.instance;

/// Simple operator page to update OF status with large buttons.
class OfStatusUpdatePage extends StatelessWidget {
  final String ofId;
  final void Function(OfOrderStatus) onStatusSelected;

  const OfStatusUpdatePage({Key? key, required this.ofId, required this.onStatusSelected}) : super(key: key);

  // ...existing UI builder

  @override
  Widget build(BuildContext context) {
    final flutterTts = FlutterTts();
    Future<void> _announce(String text) async {
      try {
        await flutterTts.speak(text);
      } catch (_) {}
    }

    Future<void> _performTransition(OfOrderStatus status) async {
      // Use DI to get the usecase
      final uc = _getIt<TransitionOfOrderUseCase>();
      final res = await uc.call(ofId, status, updatedBy: 'operator_ui');
      res.fold((f) async {
        await _announce('Transition failed');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transition failed')));
      }, (order) async {
        await _announce('Status updated to ${status.name}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated to ${status.name}')));
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Update OF $ofId')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR to load OF'),
              onPressed: () async {
                final scanned = await Navigator.of(context).push<String?>(MaterialPageRoute(builder: (_) => const _ScannerPage()));
                if (scanned != null && scanned.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scanned: $scanned')));
                }
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.materialReception),
              child: const Text('Mark Material Reception'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.materialPreparation),
              child: const Text('Mark Preparation'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.productionCoupe),
              child: const Text('Mark Production Coupe'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.productionProd),
              child: const Text('Mark Production'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.productionTest),
              child: const Text('Mark Test'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.control),
              child: const Text('Mark Control'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.shipment),
              child: const Text('Mark Shipment'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => _performTransition(OfOrderStatus.completed),
              child: const Text('Mark Completed'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerPage extends StatelessWidget {
  const _ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (Barcode barcode, MobileScannerArguments? args) {
          final code = barcode.rawValue ?? '';
          if (code.isNotEmpty) Navigator.of(context).pop(code);
        },
      ),
    );
  }
}
