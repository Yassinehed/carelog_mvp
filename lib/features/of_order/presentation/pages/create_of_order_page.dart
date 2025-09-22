import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/usecases/create_of_order.dart';
import '../providers/of_order_providers.dart';
import '../../../../core/widgets/read_only_wrapper.dart';
import '../../../../l10n/app_localizations.dart';

class CreateOfOrderPage extends ConsumerStatefulWidget {
  const CreateOfOrderPage({super.key});

  @override
  ConsumerState<CreateOfOrderPage> createState() => _CreateOfOrderPageState();
}

class _CreateOfOrderPageState extends ConsumerState<CreateOfOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _clientController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createOfOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final createUseCase = ref.read(createOfOrderUseCaseProvider);
      final params = CreateOfOrderParams(
        id: const Uuid().v4(),
        client: _clientController.text.trim(),
        product: _productController.text.trim(),
        quantity: int.parse(_quantityController.text.trim()),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );

      final result = await createUseCase(params);

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur: ${failure.toString()}')),
            );
          }
        },
        (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ordre de production créé avec succès!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop(); // Retour à la page précédente
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur inattendue: ${e.toString()}')),
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ofOrderCreateTitle),
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
              // Cliente
              Text(
                AppLocalizations.of(context)!.clientLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _clientController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.clientHint,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon: const Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.clientRequired;
                  }
                  if (value.trim().length < 2) {
                    return AppLocalizations.of(context)!.clientMinLength;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Prodotto
              Text(
                AppLocalizations.of(context)!.productLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _productController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.productHint,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon: const Icon(Icons.inventory),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.productRequired;
                  }
                  if (value.trim().length < 2) {
                    return AppLocalizations.of(context)!.productMinLength;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Quantità
              Text(
                AppLocalizations.of(context)!.quantityLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.quantityHint,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon: const Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.quantityRequired;
                  }
                  final quantity = int.tryParse(value.trim());
                  if (quantity == null || quantity <= 0) {
                    return AppLocalizations.of(context)!.quantityPositive;
                  }
                  if (quantity > 10000) {
                    return AppLocalizations.of(context)!.quantityMax;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Descrizione (opzionale)
              Text(
                AppLocalizations.of(context)!.descriptionOptionalLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.descriptionHint,
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 3,
                // Nessuna validazione per il campo opzionale
              ),

              const SizedBox(height: 32),

              // Pulsante di creazione
              SizedBox(
                width: double.infinity,
                child: ReadOnlyWrapper(
                  tooltipMessage: AppLocalizations.of(context)!.readOnlyTooltip,
                  child: ElevatedButton.icon(
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add_task),
                    onPressed: _isLoading ? null : _createOfOrder,
                    label: Text(_isLoading
                        ? AppLocalizations.of(context)!.ofOrderCreating
                        : AppLocalizations.of(context)!.ofOrderCreateButton),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Info aggiuntive
              Card(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
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
