// Minimal entry point for CareLog MVP
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/security/secure_storage.dart';
import 'core/security/app_check_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Attempt to initialize App Check (no-op if not configured)
  try {
    await AppCheckService.initialize();
  } catch (_) {
    // Initialization may fail in CI or without Firebase; continue anyway.
  }

  runApp(const CareLogApp());
}

class CareLogApp extends StatefulWidget {
  const CareLogApp({super.key});

  @override
  State<CareLogApp> createState() => _CareLogAppState();
}

class _CareLogAppState extends State<CareLogApp> {
  Locale _locale = const Locale('fr');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'fr' ? const Locale('en') : const Locale('fr');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareLog MVP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: HomePage(
        locale: _locale,
        onToggleLocale: _toggleLocale,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.locale, required this.onToggleLocale});

  final Locale locale;
  final VoidCallback onToggleLocale;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = SecureStorage();
  String _token = '';

  Future<void> _writeDemoToken() async {
    await _storage.write('demo_token', 'carelog-demo-token');
    final v = await _storage.read('demo_token');
    setState(() => _token = v ?? '');
  }

  Future<void> _deleteDemoToken() async {
    await _storage.delete('demo_token');
    setState(() => _token = '');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.homeDashboard),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: widget.locale.languageCode == 'fr' ? 'Anglais' : 'Français',
            icon: const Icon(Icons.language),
            onPressed: widget.onToggleLocale,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              loc.homeWelcome,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _writeDemoToken,
              child: const Text('Store demo token'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _deleteDemoToken,
              child: const Text('Delete demo token'),
            ),
            const SizedBox(height: 12),
            Text('Stored token: $_token'),
          ]),
        ),
      ),
    );
  }
}
