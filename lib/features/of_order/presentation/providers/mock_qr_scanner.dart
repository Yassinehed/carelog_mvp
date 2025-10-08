import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock QR scanner provider that returns a scanned OF id (for testing).
final mockQrScannerProvider = Provider.family<Future<String?>, String>((ref, placeholder) async {
  // In real app, integrate camera QR scanner. Here we return the placeholder after a short delay.
  await Future.delayed(const Duration(milliseconds: 200));
  return placeholder;
});
