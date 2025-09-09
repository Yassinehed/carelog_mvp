/* Lightweight Firebase App Check initializer.
  This is a safe, optional initializer: it will try to initialize App Check
  only if firebase_app_check is available at runtime and Firebase is configured.
*/

import 'dart:async';

// We import conditionally to avoid hard requirement in environments without Firebase
// but in this workspace the package is present; still keep runtime guards.
import 'package:firebase_app_check/firebase_app_check.dart' as fac;

class AppCheckService {
  static Future<void> initialize() async {
    try {
      // For web you'll need to set reCAPTCHA site key in Firebase console
      // and call fac.FirebaseAppCheck.instance.activate(...)
      await fac.FirebaseAppCheck.instance.activate();
    } catch (e) {
      // Swallow errors: initialization may fail in CI or if not configured
      return Future<void>.value();
    }
  }
}
