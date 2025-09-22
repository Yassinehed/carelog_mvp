import 'package:flutter/material.dart';
import '../../domain/entities/signalement.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget riutilizzabile per il form di creazione/modifica signalement
class SignalementForm extends StatefulWidget {
  final Function(SignalementFormData) onSubmit;
  final bool isLoading;
  final SignalementFormData? initialData;

  const SignalementForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
    this.initialData,
  });

  @override
  State<SignalementForm> createState() => _SignalementFormState();
}

class _SignalementFormState extends State<SignalementForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  SignalementType _selectedType = SignalementType.qualityIssue;
  SignalementSeverity _selectedSeverity = SignalementSeverity.medium;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _descriptionController.text = widget.initialData!.description;
      _selectedType = widget.initialData!.type;
      _selectedSeverity = widget.initialData!.severity;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final formData = SignalementFormData(
      type: _selectedType,
      severity: _selectedSeverity,
      description: _descriptionController.text.trim(),
    );

    widget.onSubmit(formData);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTypeDropdown(l10n),
          const SizedBox(height: 16),
          _buildSeverityDropdown(l10n),
          const SizedBox(height: 16),
          _buildDescriptionField(l10n),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.signalementCreateButton),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<SignalementType>(
      value: _selectedType,
      decoration: InputDecoration(
        labelText: l10n.signalementTypeLabel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      items: SignalementType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(_getTypeText(l10n, type)),
        );
      }).toList(),
      onChanged: widget.isLoading
          ? null
          : (value) => setState(() => _selectedType = value!),
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner un type';
        }
        return null;
      },
    );
  }

  Widget _buildSeverityDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<SignalementSeverity>(
      value: _selectedSeverity,
      decoration: InputDecoration(
        labelText: l10n.signalementSeverityLabel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      items: SignalementSeverity.values.map((severity) {
        return DropdownMenuItem(
          value: severity,
          child: Text(_getSeverityText(l10n, severity)),
        );
      }).toList(),
      onChanged: widget.isLoading
          ? null
          : (value) => setState(() => _selectedSeverity = value!),
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner une sévérité';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField(AppLocalizations l10n) {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: l10n.signalementDescriptionLabel,
        hintText: l10n.signalementDescriptionHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.signalementDescriptionRequired;
        }
        if (value.trim().length < 10) {
          return l10n.signalementDescriptionMin;
        }
        return null;
      },
      enabled: !widget.isLoading,
    );
  }

  String _getTypeText(AppLocalizations l10n, SignalementType type) {
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

  String _getSeverityText(AppLocalizations l10n, SignalementSeverity severity) {
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
}

/// Classe per i dati del form
class SignalementFormData {
  final SignalementType type;
  final SignalementSeverity severity;
  final String description;

  const SignalementFormData({
    required this.type,
    required this.severity,
    required this.description,
  });
}