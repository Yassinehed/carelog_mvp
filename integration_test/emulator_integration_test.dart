import 'dart:io';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carelog_mvp/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/firebase_options.dart';
import 'package:carelog_mvp/injection.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Emulator-backed integration', () {
    // Ports used by the local emulator suite
    const authPort = 9099;
    const firestorePort = 8080;

    bool emulatorAvailable = false;

    setUpAll(() async {
      // Probe the auth emulator port
      try {
        final socket = await Socket.connect('localhost', authPort, timeout: const Duration(seconds: 1));
        socket.destroy();
        emulatorAvailable = true;
      } catch (_) {
        emulatorAvailable = false;
      }

      if (!emulatorAvailable) return;

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      // Configure dependency injection so GetIt registrations are available in the test.
      try {
        configureDependencies();
      } catch (_) {
        // If configureDependencies was already called elsewhere, ignore.
      }

      FirebaseAuth.instance.useAuthEmulator('localhost', authPort);

      FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:$firestorePort',
        sslEnabled: false,
        persistenceEnabled: false,
      );
    });

    testWidgets('sign up, sign in, and display HomePage', (tester) async {
      if (!emulatorAvailable) {
        // Skip test when emulator not available.
        return;
      }

      const email = 'integ.user+emulator@example.com';
      const password = 'testpassword';

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      } catch (_) {}

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  // Run the app wrapped with ProviderScope for Riverpod
  await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Expect the HomePage admin icon to be visible
      expect(find.byIcon(Icons.admin_panel_settings), findsWidgets);
    });
  });
}
