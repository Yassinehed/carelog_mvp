import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final success =
          await ref.read(authNotifierProvider.notifier).resetPassword(
                _emailController.text.trim(),
              );

      if (success && mounted) {
        setState(() => _emailSent = true);
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(l10n.resetEmailSentMessage(_emailController.text.trim())),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.resetPasswordTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _emailSent ? _buildSuccessView() : _buildResetForm(l10n),
        ),
      ),
    );
  }

  Widget _buildResetForm(AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icona
          const Icon(
            Icons.lock_reset,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),

          // Titolo
          Text(
            l10n.resetPasswordTitle,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Descrizione
          Text(
            l10n.resetPasswordDescription,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),

          // Campo Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: l10n.enterEmail,
              prefixIcon: const Icon(Icons.email),
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.enterEmail;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return l10n.enterValidEmail;
              }
              return null;
            },
            enabled: !_isLoading,
          ),
          const SizedBox(height: 24),

          // Pulsante Reset Password
          ElevatedButton(
            onPressed: _isLoading ? null : _resetPassword,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.sendResetEmail,
                    style: const TextStyle(fontSize: 16)),
          ),

          const SizedBox(height: 16),

          // Pulsante Torna al Login
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.backToLogin),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icona di successo
        const Icon(
          Icons.check_circle,
          size: 80,
          color: Colors.green,
        ),
        const SizedBox(height: 16),

        // Titolo
        Text(
          AppLocalizations.of(context)!.resetEmailSentTitle,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Messaggio
        Text(
          AppLocalizations.of(context)!
              .resetEmailSentMessage(_emailController.text.trim()),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        Text(
          AppLocalizations.of(context)!.resetCheckSpam,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),

        // Pulsante Torna al Login
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.backToLogin,
              style: const TextStyle(fontSize: 16)),
        ),

        const SizedBox(height: 16),

        // Pulsante Riprova
        TextButton(
          onPressed: () {
            setState(() => _emailSent = false);
          },
          child: Text(AppLocalizations.of(context)!.sendAgain),
        ),
      ],
    );
  }
}
