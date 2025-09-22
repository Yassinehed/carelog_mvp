import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/create_of_order.dart';

/// Widget per il form di creazione di un ordine di produzione
class OfOrderForm extends StatefulWidget {
  final Function(CreateOfOrderParams) onSubmit;
  final bool isLoading;

  const OfOrderForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<OfOrderForm> createState() => _OfOrderFormState();
}

class _OfOrderFormState extends State<OfOrderForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _clientController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final params = CreateOfOrderParams(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      client: _clientController.text.trim(),
      product: _productController.text.trim(),
      quantity: int.parse(_quantityController.text.trim()),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    widget.onSubmit(params);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            controller: _clientController,
            label: AppLocalizations.of(context)!.clientLabel,
            hint: AppLocalizations.of(context)!.clientHint,
            icon: Icons.business,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.clientRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _productController,
            label: AppLocalizations.of(context)!.productLabel,
            hint: AppLocalizations.of(context)!.productHint,
            icon: Icons.inventory,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.productRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _quantityController,
            label: AppLocalizations.of(context)!.quantityLabel,
            hint: AppLocalizations.of(context)!.quantityHint,
            icon: Icons.numbers,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.quantityRequired;
              }
              final quantity = int.tryParse(value);
              if (quantity == null || quantity <= 0) {
                return AppLocalizations.of(context)!.quantityPositive;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _descriptionController,
            label: AppLocalizations.of(context)!.descriptionOptionalLabel,
            hint: AppLocalizations.of(context)!.descriptionHint,
            icon: Icons.description,
            maxLines: 3,
            validator: (value) => null, // Descrizione è opzionale
          ),
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
                : Text(AppLocalizations.of(context)!.ofOrderCreateButton),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      validator: validator,
      enabled: !widget.isLoading,
    );
  }
}