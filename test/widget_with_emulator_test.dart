import 'dart:io';

import 'package:carelog_mvp/firebase_options.dart';
import 'package:carelog_mvp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // These host/port values assume the emulator runs on localhost with default ports.
  const firestoreHost = 'localhost:8080';

  bool skipEmulatorTests = false;

  setUpAll(() async {
    // Ensure the test binding is initialized for plugin channels
    TestWidgetsFlutterBinding.ensureInitialized();

    // Probe the emulator port before attempting to initialize Firebase to avoid
    // platform channel errors when emulator/plugins are unavailable.
    bool authReachable = false;
    try {
      final socket = await Socket.connect('localhost', 9099,
          timeout: const Duration(seconds: 1));
      socket.destroy();
      authReachable = true;
    } catch (_) {
      authReachable = false;
    }

    if (!authReachable) {
      // Mark tests to skip if emulator not running locally. This prevents
      // platform channel initialization errors during normal unit test runs.
      skipEmulatorTests = true;
      return;
    }

    // Initialize Firebase app for tests
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      // If initialization fails, skip emulator tests to avoid failing unit test runs
      // when native plugin support isn't available in this environment.
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
    // Skip test early if emulator ports are not open to avoid long timeouts
    bool authOpen = false;
    try {
      final socket = await Socket.connect('localhost', 9099,
          timeout: const Duration(seconds: 1));
      socket.destroy();
      authOpen = true;
    } catch (_) {}

    if (skipEmulatorTests || !authOpen) {
      // Skip the test gracefully when emulator isn't running or initialization failed.
      // ignore: avoid_print
      print(
          'Skipping emulator test - Firebase emulator not available in CI/CD environment');
      return;
    }

    // Create test user on the Auth emulator
    const testEmail = 'test.user+emulator@example.com';
    const testPassword = 'password123';

    // Clean up any existing user first
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );
      // If we get here, user exists, so delete it
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (_) {
      // User doesn't exist or other error - that's fine
    }

    // Create user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );
    } catch (e) {
      // If user already exists, try to sign in instead
      // ignore: avoid_print
      print('User creation failed, trying sign in: $e');
    }

    // Sign in the user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: testEmail,
      password: testPassword,
    );

    // Pump the real app wrapped in ProviderScope so authNotifierProvider listens to the emulator
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Give the app a bit more time to run async initialization (auth stream subscription, DI setup)
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // At this point, if the app recognizes the auth state, it should show HomePage.
    // Check for presence of the admin IconButton which is part of HomePage AppBar actions.
    expect(find.byIcon(Icons.admin_panel_settings), findsWidgets,
        reason: 'Home page should show admin icon when authenticated');
  }, timeout: const Timeout(Duration(seconds: 30)));
}
