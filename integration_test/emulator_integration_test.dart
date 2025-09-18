import 'dart:io';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carelog_mvp/main.dart';
import 'package:carelog_mvp/firebase_options.dart';

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

      FirebaseAuth.instance.useAuthEmulator('localhost', authPort);

      FirebaseFirestore.instance.settings = Settings(
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

      final email = 'integ.user+emulator@example.com';
      final password = 'testpassword';

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      } catch (_) {}

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      // Run the app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Expect the HomePage admin icon to be visible
      expect(find.byIcon(Icons.admin_panel_settings), findsWidgets);
    });
  });
}
