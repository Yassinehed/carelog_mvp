import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/signalement.dart';
import '../../domain/usecases/create_signalement.dart';
import '../providers/signalement_providers.dart';

class CreateSignalementPage extends ConsumerWidget {
  const CreateSignalementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signalementFormProvider);
    final formNotifier = ref.read(signalementFormProvider.notifier);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signalementCreateTitle),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo di signalement
              Text(
                l10n.signalementTypeLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<SignalementType>(
                value: formState.type,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: SignalementType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeLabel(context, type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    formNotifier.updateType(value);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return l10n.signalementTypeLabel;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Severità
              Text(
                l10n.signalementSeverityLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<SignalementSeverity>(
                value: formState.severity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: SignalementSeverity.values.map((severity) {
                  return DropdownMenuItem(
                    value: severity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: _getSeverityColor(severity),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(_getSeverityLabel(context, severity)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    formNotifier.updateSeverity(value);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return l10n.signalementSeverityLabel;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Descrizione
              Text(
                l10n.signalementDescriptionLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: formState.description,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: l10n.signalementDescriptionHint,
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 5,
                onChanged: formNotifier.updateDescription,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.signalementDescriptionRequired;
                  }
                  if (value.trim().length < 10) {
                    return l10n.signalementDescriptionMin;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Pulsante di creazione
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: formState.isSubmitting ? null : () => _createSignalement(context, ref, formState),
                  icon: formState.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: Text(formState.isSubmitting
                      ? l10n.signalementCreating
                      : l10n.signalementCreateButton),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (formState.error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade600),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          formState.error!,
                          style: TextStyle(color: Colors.red.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createSignalement(BuildContext context, WidgetRef ref, SignalementFormState formState) async {
    final formNotifier = ref.read(signalementFormProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    formNotifier.setSubmitting(true);
    formNotifier.setError(null);

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) {
        formNotifier.setError(l10n.signalementNotLoggedIn);
        return;
      }

      final createUseCase = ref.read(createSignalementUseCaseProvider);
      final params = CreateSignalementParams(
        id: const Uuid().v4(),
        type: formState.type!,
        severity: formState.severity!,
        createdBy: currentUser.email,
        description: formState.description.trim(),
      );

      final result = await createUseCase(params);

      result.fold(
        (failure) {
          formNotifier.setError(l10n.signalementUnexpectedError(failure.toString()));
        },
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.signalementCreatedSuccess),
              backgroundColor: Colors.green,
            ),
          );
          formNotifier.reset();
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      formNotifier.setError(l10n.signalementUnexpectedError(e.toString()));
    } finally {
      formNotifier.setSubmitting(false);
    }
  }

  String _getTypeLabel(BuildContext context, SignalementType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case SignalementType.qualityIssue:
        return l10n.signalementType_qualityIssue;
      case SignalementType.machineFailure:
        return l10n.signalementType_machineFailure;
      case SignalementType.materialIssue:
        return l10n.signalementType_materialIssue;
      case SignalementType.processIssue:
        return l10n.signalementType_processIssue;
      case SignalementType.other:
        return l10n.signalementType_other;
    }
  }

  String _getSeverityLabel(BuildContext context, SignalementSeverity severity) {
    final l10n = AppLocalizations.of(context)!;
    switch (severity) {
      case SignalementSeverity.low:
        return l10n.severity_low;
      case SignalementSeverity.medium:
        return l10n.severity_medium;
      case SignalementSeverity.high:
        return l10n.severity_high;
      case SignalementSeverity.critical:
        return l10n.severity_critical;
    }
  }

  Color _getSeverityColor(SignalementSeverity severity) {
    switch (severity) {
      case SignalementSeverity.low:
        return Colors.green;
      case SignalementSeverity.medium:
        return Colors.orange;
      case SignalementSeverity.high:
        return Colors.red;
      case SignalementSeverity.critical:
        return Colors.red.shade900;
    }
  }
}