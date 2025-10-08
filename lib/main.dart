import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'injection.dart';
// Usecases are registered and injected via DI; concrete imports are not required here.
import 'core/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/reset_password_page.dart';
import 'features/material/presentation/pages/material_list_page.dart';
import 'features/material/presentation/pages/create_material_page.dart';
import 'features/signalement/presentation/pages/signalement_list_page.dart';
import 'features/signalement/presentation/pages/create_signalement_page.dart';
import 'features/of_order/presentation/pages/of_order_list_page.dart';
import 'features/of_order/presentation/pages/create_of_order_page.dart';
import 'features/admin/presentation/pages/admin_dashboard_page.dart';
import 'l10n/app_localizations.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

void main() {
  // Install Flutter error handler early
  FlutterError.onError = (FlutterErrorDetails details) {
    // ignore: avoid_print
    print('FlutterError.onError: ${details.exceptionAsString()}');
    // ignore: avoid_print
    print(details.stack);
    FlutterError.presentError(details);
  };

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase and fail fast if it doesn't initialize.
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('Firebase initialized successfully.');
    } catch (e, st) {
      // rethrow so runZonedGuarded captures and logs the stack
      debugPrint('Firebase.initializeApp() failed: $e');
      debugPrint(st.toString());
      rethrow;
    }

    // Configure DI (injectable) and surface any configuration errors.
    try {
      configureDependencies();
      debugPrint('Dependency injection configured.');
    } catch (e, st) {
      debugPrint('configureDependencies() failed: $e');
      debugPrint(st.toString());
      rethrow;
    }

    // DI registrations are handled by injectable-generated code (injection.config.dart).

    // Run the app now that Firebase is initialized and DI is configured
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    // ignore: avoid_print
    print('Uncaught error in runZonedGuarded: $error');
    // ignore: avoid_print
    print(stack);
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isAuthenticated = authState.isAuthenticated;
    final isAuthLoading = authState.isLoading;

    // Show a simple splash/loading screen while auth status is being determined
    if (isAuthLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    const primaryBlue = Color(0xFF0A66C2);
    const accentOrange = Color(0xFFFF8A00);
    const successGreen = Color(0xFF2ECC71);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: accentOrange,
          tertiary: successGreen,
        ),
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'Inter',
            ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      // The app default language should be French; English remains optional.
      locale: const Locale('fr'),
      home: isAuthenticated ? const HomePage() : const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/home': (context) => const HomePage(),
        '/materials': (context) => const MaterialListPage(),
        '/materials/create': (context) => const CreateMaterialPage(),
        '/signalements': (context) => const SignalementListPage(),
        '/signalements/create': (context) => const CreateSignalementPage(),
        '/of_orders': (context) => const OfOrderListPage(),
        '/of_orders/create': (context) => const CreateOfOrderPage(),
        '/admin': (context) => const AdminDashboardPage(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes like /materials/{id}
        if (settings.name?.startsWith('/materials/') == true) {
          final materialId = settings.name!.substring('/materials/'.length);
          if (materialId.isNotEmpty && materialId != 'create') {
            // TODO: Implement MaterialDetailPage
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                    title: Text(AppLocalizations.of(context)!
                        .materialDetailTitle(materialId))),
                body: Center(
                    child: Text(AppLocalizations.of(context)!
                        .materialDetailComingSoon)),
              ),
            );
          }
        }
        return null;
      },
    );
  }
}
