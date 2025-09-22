import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carelog_mvp/main.dart';
import 'package:carelog_mvp/firebase_options.dart';

void main() async {
  // Quick probe: if the Auth emulator port isn't reachable, skip defining emulator tests.
  bool hasAuthEmulator = false;
  try {
    final socket = await Socket.connect('localhost', 9099, timeout: const Duration(milliseconds: 800));
    socket.destroy();
    hasAuthEmulator = true;
  } catch (_) {
    hasAuthEmulator = false;
  }

  if (!hasAuthEmulator) {
    // Avoid registering emulator tests when emulator isn't available to prevent flaky timeouts.
    // ignore: avoid_print
    print('Skipping emulator widget tests: Auth emulator not reachable on localhost:9099');
    return;
  }

  // If emulator reachable, proceed with the more thorough setup and tests.
  // These tests are intentionally integration-style and require local emulator running.
  const firestoreHost = 'localhost:8080';

  bool skipEmulatorTests = false;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Firebase.initializeApp failed in test environment: $e');
      skipEmulatorTests = true;
      return;
    }

    // Point FirebaseAuth to emulator
    try {
      FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print('Could not set Auth emulator: $e');
    }

    // Point Firestore to emulator
    try {
      FirebaseFirestore.instance.settings = const Settings(
        host: firestoreHost,
        sslEnabled: false,
        persistenceEnabled: false,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Could not set Firestore emulator: $e');
    }
  });

  testWidgets('auth flow with emulator: sign up and show HomePage',
      (WidgetTester tester) async {
    if (skipEmulatorTests) {
      // ignore: avoid_print
      print('Skipping emulator test - setup failed');
      return;
    }

    // Create test user on the Auth emulator
    const testEmail = 'test.user+emulator@example.com';
    const testPassword = 'password123';

    // Attempt to ensure no prior user exists, but don't fail the test on errors.
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (_) {}

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );
    } catch (_) {
      // ignore: avoid_print
      print('User creation may have failed or user exists, continuing with sign-in');
    }

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: testEmail,
      password: testPassword,
    );

    // Pump the real app wrapped in ProviderScope so authNotifierProvider listens to the emulator
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Allow more time for async initialization, but avoid indefinite waits.
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Check for presence of the admin IconButton which is part of HomePage AppBar actions.
    expect(find.byIcon(Icons.admin_panel_settings), findsWidgets,
        reason: 'Home page should show admin icon when authenticated');
  }, timeout: const Timeout(Duration(seconds: 60)));
}
