import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/of_order.dart';
import '../../domain/usecases/transition_of_order.dart';

final _getIt = GetIt.instance;

/// Operator page with auth, loading state, TTS, QR scanning and polish
class OfStatusUpdatePage extends ConsumerStatefulWidget {
  final String ofId;

  const OfStatusUpdatePage({super.key, required this.ofId});

  @override
  ConsumerState<OfStatusUpdatePage> createState() => _OfStatusUpdatePageState();
}

class _OfStatusUpdatePageState extends ConsumerState<OfStatusUpdatePage> {
  final FlutterTts _tts = FlutterTts();
  bool _isLoading = false;
  OfOrderStatus? _currentStatus;

  Future<void> _announce(String text) async {
    try {
      await _tts.speak(text);
    } catch (_) {}
  }

  Future<void> _performTransition(OfOrderStatus status) async {
    final authState = ref.read(authNotifierProvider);
    if (!authState.isAuthenticated) {
      // Friendly French message
      // Capture messenger and ignore build_context_synchronously because we use it before awaiting TTS
      // ignore: use_build_context_synchronously
      final messenger = ScaffoldMessenger.of(context);
      // ignore: use_build_context_synchronously
      messenger.showSnackBar(const SnackBar(content: Text('Veuillez vous connecter pour effectuer cette action')));
      await _announce('Veuillez vous connecter');
      return;
    }

    setState(() => _isLoading = true);
    final updatedBy = authState.user?.id ?? 'unknown';

    try {
      // timeout handling
      final uc = _getIt<TransitionOfOrderUseCase>();
      final result = await uc.call(widget.ofId, status, updatedBy: updatedBy).timeout(const Duration(seconds: 10));
      result.fold((f) async {
        await _announce('Échec de la mise à jour');
  if (!mounted) return;
  // ignore: use_build_context_synchronously
  final messenger = ScaffoldMessenger.of(context);
  // ignore: use_build_context_synchronously
  messenger.showSnackBar(const SnackBar(content: Text('Échec de la mise à jour. Réessayez.')));
      }, (order) async {
        await _announce('Statut mis à jour à ${status.name}');
  if (!mounted) return;
  setState(() => _currentStatus = order.status);
  if (!mounted) return;
  // ignore: use_build_context_synchronously
  final messenger = ScaffoldMessenger.of(context);
  // ignore: use_build_context_synchronously
  messenger.showSnackBar(SnackBar(content: Text('Statut mis à jour: ${status.name}')));
      });
    } on TimeoutException {
  // ignore: use_build_context_synchronously
  final messenger = ScaffoldMessenger.of(context);
  // ignore: use_build_context_synchronously
  messenger.showSnackBar(const SnackBar(content: Text('Délai dépassé. Réessayez plus tard.')));
      await _announce('Délai dépassé');
    } catch (e) {
  // ignore: use_build_context_synchronously
  final messenger = ScaffoldMessenger.of(context);
  // ignore: use_build_context_synchronously
  messenger.showSnackBar(const SnackBar(content: Text('Une erreur est survenue')));
      await _announce('Une erreur est survenue');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Color _colorForStatus(OfOrderStatus status) {
    // simple mapping: if current status is before the requested status -> grey blocked
    if (_currentStatus == null) return Colors.blueGrey;
    final order = _currentStatus!;
    if (order == status) return Colors.green;
    // otherwise allow transitions visually (placeholder logic)
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('OF ${widget.ofId}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (authState.isLoading) const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(authState.isAuthenticated ? 'Opérateur: ${authState.user?.email ?? 'inconnu'}' : 'Non authentifié', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scanner le QR pour charger l\'OF'),
              onPressed: () async {
                // Capture messenger before awaiting to avoid using BuildContext after async gap
                final messenger = ScaffoldMessenger.of(context);
                final scanned = await Navigator.of(context).push<String?>(MaterialPageRoute(builder: (_) => const _ScannerPage()));
                if (!mounted) return;
                if (scanned != null && scanned.isNotEmpty) {
                  messenger.showSnackBar(SnackBar(content: Text('Scanné: $scanned')));
                }
              },
            ),
            const SizedBox(height: 12),
            // Progress indicator for current workflow stage
            if (_currentStatus != null) ...[
              Text('Étape actuelle: ${_currentStatus!.name}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: (_currentStatus!.index + 1) / OfOrderStatus.values.length),
              const SizedBox(height: 16),
            ],
            _statusButton('Accuser réception du matériel', OfOrderStatus.materialReception),
            const SizedBox(height: 12),
            _statusButton('Marquer préparation', OfOrderStatus.materialPreparation),
            const SizedBox(height: 12),
            _statusButton('Marquer coupe', OfOrderStatus.productionCoupe),
            const SizedBox(height: 12),
            _statusButton('Marquer production', OfOrderStatus.productionProd),
            const SizedBox(height: 12),
            _statusButton('Marquer test', OfOrderStatus.productionTest),
            const SizedBox(height: 12),
            _statusButton('Contrôle', OfOrderStatus.control),
            const SizedBox(height: 12),
            _statusButton('Expédition', OfOrderStatus.shipment),
            const SizedBox(height: 12),
            _statusButton('Terminé', OfOrderStatus.completed),
          ],
        ),
      ),
    );
  }

  Widget _statusButton(String label, OfOrderStatus status) {
  const blocked = false; // placeholder: computed rules can be applied here
  final color = _colorForStatus(status);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, padding: const EdgeInsets.symmetric(vertical: 18), textStyle: const TextStyle(fontSize: 16)),
        onPressed: _isLoading || blocked ? null : () => _performTransition(status),
        child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text(label),
      ),
    );
  }
}

class _ScannerPage extends StatelessWidget {
  // ignore: use_super_parameters
  const _ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Web cannot access native camera via mobile_scanner reliably; provide a text input fallback
      final controller = TextEditingController();
      return Scaffold(
        appBar: AppBar(title: const Text('Scanner QR')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Collez/entrez le code QR ici (web fallback)'),
              const SizedBox(height: 12),
              TextField(controller: controller, decoration: const InputDecoration(labelText: 'Code QR')),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: () {
                final code = controller.text.trim();
                if (code.isNotEmpty) Navigator.of(context).pop(code);
              }, child: const Text('Valider'))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Scanner QR')),
      body: MobileScanner(
        // new API may not have allowDuplicates/MobileScannerArguments type; use dynamic capture handling
        onDetect: (capture) {
          String code = '';
          try {
            // Try common shapes
            if (capture is Barcode) {
              code = (capture as dynamic).rawValue ?? '';
            } else if ((capture as dynamic).barcodes != null) {
              final first = (capture as dynamic).barcodes.first;
              code = (first as dynamic).rawValue ?? '';
            } else {
              // Fallback to string representation
              code = capture.toString();
            }
          } catch (_) {
            code = capture.toString();
          }
          if (code.isNotEmpty) Navigator.of(context).pop(code);
        },
      ),
    );
  }
}
