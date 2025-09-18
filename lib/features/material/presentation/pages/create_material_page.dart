import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/l10n/app_localizations.dart';

class CreateMaterialPage extends ConsumerStatefulWidget {
  const CreateMaterialPage({super.key});

  @override
  ConsumerState<CreateMaterialPage> createState() => _CreateMaterialPageState();
}

class _CreateMaterialPageState extends ConsumerState<CreateMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final _referenceController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _minimumStockController = TextEditingController();
  final _maximumStockController = TextEditingController();
  final _reorderPointController = TextEditingController();
  final _unitPriceController = TextEditingController();

  String _selectedType = 'consumable';
  String _selectedUnitOfMeasure = 'pieces';
  // String _selectedCategory = 'general';

  bool _isLoading = false;

  @override
  void dispose() {
    _referenceController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _minimumStockController.dispose();
    _maximumStockController.dispose();
    _reorderPointController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  Future<void> _createMaterial() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // final createUseCase = ref.read(createMaterialUseCaseProvider);

      // Create material object (simplified for now)
      // final material = {
      //   'reference': _referenceController.text,
      //   'name': _nameController.text,
      //   'description': _descriptionController.text,
      //   'type': _selectedType,
      //   'unitOfMeasure': _selectedUnitOfMeasure,
      //   'category': _selectedCategory,
      //   'minimumStock': double.tryParse(_minimumStockController.text) ?? 0,
      //   'maximumStock': double.tryParse(_maximumStockController.text) ?? 100,
      //   'reorderPoint': double.tryParse(_reorderPointController.text) ?? 10,
      //   'unitPrice': double.tryParse(_unitPriceController.text) ?? 0,
      //   'currentStock': 0,
      // };

      // TODO: Create proper Material entity and use the use case
      // final result = await createUseCase(material);

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.createMaterial_success)),
      );

      Navigator.of(context).pop();
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.createMaterial_error(e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createMaterialTitle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _referenceController,
              decoration: InputDecoration(
                labelText: l10n.referenceLabel,
                hintText: l10n.referenceHint,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.referenceHint;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.nameLabel,
                hintText: l10n.nameHint,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.nameHint;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.descriptionLabel,
                hintText: l10n.descriptionHint,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(labelText: l10n.typeLabel),
              items: [
                DropdownMenuItem(
                    value: 'consumable',
                    child: Text(AppLocalizations.of(context)!.type_consumable)),
                DropdownMenuItem(
                    value: 'durable',
                    child: Text(AppLocalizations.of(context)!.type_durable)),
                DropdownMenuItem(
                    value: 'service',
                    child: Text(AppLocalizations.of(context)!.type_service)),
              ],
              onChanged: (value) {
                setState(() => _selectedType = value!);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedUnitOfMeasure,
              decoration: InputDecoration(labelText: l10n.unitOfMeasureLabel),
              items: [
                DropdownMenuItem(
                    value: 'pieces',
                    child: Text(AppLocalizations.of(context)!.uom_pieces)),
                DropdownMenuItem(
                    value: 'kg',
                    child: Text(AppLocalizations.of(context)!.uom_kg)),
                DropdownMenuItem(
                    value: 'liters',
                    child: Text(AppLocalizations.of(context)!.uom_liters)),
                DropdownMenuItem(
                    value: 'meters',
                    child: Text(AppLocalizations.of(context)!.uom_meters)),
              ],
              onChanged: (value) {
                setState(() => _selectedUnitOfMeasure = value!);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _minimumStockController,
              decoration: InputDecoration(
                labelText: l10n.minimumStockLabel,
                hintText: l10n.minimumStockHint,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _maximumStockController,
              decoration: InputDecoration(
                labelText: l10n.maximumStockLabel,
                hintText: l10n.maximumStockHint,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reorderPointController,
              decoration: InputDecoration(
                labelText: l10n.reorderPointLabel,
                hintText: l10n.reorderPointHint,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _unitPriceController,
              decoration: InputDecoration(
                labelText: l10n.unitPriceLabel,
                hintText: l10n.unitPriceHint,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _createMaterial,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.createMaterialButton),
            ),
          ],
        ),
      ),
    );
  }
}
