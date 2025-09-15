import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/read_only_wrapper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/signalement.dart';
import '../../domain/usecases/create_signalement.dart';
import '../providers/signalement_providers.dart';

class CreateSignalementPage extends ConsumerStatefulWidget {
  const CreateSignalementPage({super.key});

  @override
  ConsumerState<CreateSignalementPage> createState() =>
      _CreateSignalementPageState();
}

class _CreateSignalementPageState extends ConsumerState<CreateSignalementPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  SignalementType _selectedType = SignalementType.qualityIssue;
  SignalementSeverity _selectedSeverity = SignalementSeverity.medium;

  bool _isLoading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createSignalement() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.signalementNotLoggedIn)),
          );
        }
        return;
      }

      final createUseCase = ref.read(createSignalementUseCaseProvider);
      final params = CreateSignalementParams(
        id: const Uuid().v4(),
        type: _selectedType,
        severity: _selectedSeverity,
        createdBy: currentUser.email,
        description: _descriptionController.text.trim(),
      );

      final result = await createUseCase(params);

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(AppLocalizations.of(context)!
                      .signalementUnexpectedError(failure.toString()))),
            );
          }
        },
        (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.signalementCreatedSuccess),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop(); // Torna alla pagina precedente
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .signalementUnexpectedError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getTypeLabel(SignalementType type) {
    switch (type) {
      case SignalementType.qualityIssue:
        return AppLocalizations.of(context)!.signalementType_qualityIssue;
      case SignalementType.machineFailure:
        return AppLocalizations.of(context)!.signalementType_machineFailure;
      case SignalementType.materialIssue:
        return AppLocalizations.of(context)!.signalementType_materialIssue;
      case SignalementType.processIssue:
        return AppLocalizations.of(context)!.signalementType_processIssue;
      case SignalementType.other:
        return AppLocalizations.of(context)!.signalementType_other;
    }
  }

  String _getSeverityLabel(SignalementSeverity severity) {
    switch (severity) {
      case SignalementSeverity.low:
        return AppLocalizations.of(context)!.severity_low;
      case SignalementSeverity.medium:
        return AppLocalizations.of(context)!.severity_medium;
      case SignalementSeverity.high:
        return AppLocalizations.of(context)!.severity_high;
      case SignalementSeverity.critical:
        return AppLocalizations.of(context)!.severity_critical;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signalementCreateTitle),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo di signalement
              Text(
                AppLocalizations.of(context)!.signalementTypeLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<SignalementType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: SignalementType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeLabel(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.signalementTypeLabel;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Severità
              Text(
                AppLocalizations.of(context)!.signalementSeverityLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<SignalementSeverity>(
                value: _selectedSeverity,
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
                        Text(_getSeverityLabel(severity)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedSeverity = value);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!
                        .signalementSeverityLabel;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Descrizione
              Text(
                AppLocalizations.of(context)!.signalementDescriptionLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText:
                      AppLocalizations.of(context)!.signalementDescriptionHint,
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!
                        .signalementDescriptionRequired;
                  }
                  if (value.trim().length < 10) {
                    return AppLocalizations.of(context)!
                        .signalementDescriptionMin;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Pulsante di creazione
              SizedBox(
                width: double.infinity,
                child: ReadOnlyWrapper(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _createSignalement,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(_isLoading
                        ? AppLocalizations.of(context)!.signalementCreating
                        : AppLocalizations.of(context)!
                            .signalementCreateButton),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  tooltipMessage: AppLocalizations.of(context)!.readOnlyTooltip,
                ),
              ),

              const SizedBox(height: 16),

              // Info aggiuntive
              Card(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.testingHeader,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.testingInfo,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
