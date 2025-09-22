import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../providers/material_providers.dart';
import '../../../../l10n/app_localizations.dart';

class MaterialDetailPage extends ConsumerStatefulWidget {
  final String materialId;

  const MaterialDetailPage({
    super.key,
    required this.materialId,
  });

  @override
  ConsumerState<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends ConsumerState<MaterialDetailPage> {
  late StreamSubscription _materialUpdatesSubscription;
  bool _isLiveUpdate = false;

  @override
  void initState() {
    super.initState();
    _setupLiveUpdates();
  }

  @override
  void dispose() {
    _materialUpdatesSubscription.cancel();
    super.dispose();
  }

  void _setupLiveUpdates() {
    final trackingService = ref.read(realTimeTrackingServiceProvider);
    
    // Avvia il tracking per questo materiale specifico
    trackingService.startMaterialTracking(widget.materialId);
    
    // Ascolta gli aggiornamenti per questo materiale specifico
    _materialUpdatesSubscription = trackingService.materialUpdates
        .where((material) => material.reference == widget.materialId) // Filtra solo questo materiale
        .listen((updatedMaterial) {
          if (mounted) {
            setState(() {
              _isLiveUpdate = true;
            });
            
            // Mostra una notifica di aggiornamento live
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Matériau mis à jour en temps réel'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            
            // Invalida il provider per ricaricare i dati
            ref.invalidate(materialProvider(widget.materialId));
            
            // Resetta il flag dopo un breve delay
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() => _isLiveUpdate = false);
              }
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final materialAsync = ref.watch(materialProvider(widget.materialId));
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(l10n.materialDetailTitle),
            if (_isLiveUpdate) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.materialEditComingSoon)),
              );
            },
            tooltip: l10n.editLabel,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context, materialAsync.value),
            tooltip: 'Générer PDF',
          ),
        ],
      ),
      body: materialAsync.when(
        data: (material) {
          if (material == null) {
            return _buildNotFoundState(context, l10n);
          }
          return _buildDetailContent(context, ref, material, theme, l10n);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(l10n.genericError(error.toString())),
        ),
      ),
    );
  }

  Widget _buildNotFoundState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.materialNotFound,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.materialNotFoundDescription,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: Text(l10n.backLabel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(
    BuildContext context,
    WidgetRef ref,
    dynamic material,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          _buildHeaderCard(context, material, theme, l10n),

          const SizedBox(height: 16),

          // Stock Information Card
          _buildStockCard(context, material, theme, l10n),

          const SizedBox(height: 16),

          // Details Card
          _buildDetailsCard(context, material, theme, l10n),

          const SizedBox(height: 16),

          // Actions Card
          _buildActionsCard(context, ref, material, theme, l10n),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(
    BuildContext context,
    dynamic material,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    material.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStockStatusColor(material).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _getStockStatusColor(material),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStockStatusText(material, l10n),
                    style: TextStyle(
                      color: _getStockStatusColor(material),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.referencePrefix(material.reference),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.typeLabelUpper(material.type.name.toUpperCase()),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockCard(
    BuildContext context,
    dynamic material,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final stockPercentage = material.maximumStock > 0
        ? (material.currentStock / material.maximumStock * 100).round()
        : 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stock Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStockMetric(
                    context,
                    'Current Stock',
                    '${material.currentStock} ${material.unitOfMeasure.name}',
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStockMetric(
                    context,
                    'Minimum Stock',
                    '${material.minimumStock} ${material.unitOfMeasure.name}',
                    theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStockMetric(
                    context,
                    'Maximum Stock',
                    '${material.maximumStock} ${material.unitOfMeasure.name}',
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStockMetric(
                    context,
                    'Stock Level',
                    '$stockPercentage%',
                    theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: stockPercentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getStockStatusColor(material)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockMetric(
    BuildContext context,
    String label,
    String value,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    dynamic material,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Category', material.category.name, theme),
            const SizedBox(height: 12),
            _buildDetailRow('Unit of Measure', material.unitOfMeasure.name, theme),
            const SizedBox(height: 12),
            _buildDetailRow('Supplier', material.supplier?.name ?? 'Not specified', theme),
            if (material.description?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              _buildDetailRow(l10n.descriptionLabel, material.description, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCard(
    BuildContext context,
    WidgetRef ref,
    dynamic material,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement stock adjustment
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Stock adjustment coming soon')),
                      );
                    },
                    icon: const Icon(Icons.inventory),
                    label: const Text('Adjust Stock'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement reorder
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reorder functionality coming soon')),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Reorder'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStockStatusColor(dynamic material) {
    if (material.currentStock <= 0) return Colors.red;
    if (material.currentStock <= material.minimumStock) return Colors.orange;
    return Colors.green;
  }

  String _getStockStatusText(dynamic material, AppLocalizations l10n) {
    if (material.currentStock <= 0) return l10n.stockStatus_out;
    if (material.currentStock <= material.minimumStock) return l10n.stockStatus_low;
    return l10n.stockStatus_in;
  }

  void _generatePdf(BuildContext context, dynamic material) async {
    if (material == null) return;

    try {
      // TODO: Get PDF service from injection
      // final pdfService = getIt<PdfService>();
      // final pdfData = await pdfService.generateMaterialReportPdf([material]);
      // await pdfService.previewPdf(pdfData, 'Material_${material.reference}.pdf');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Génération PDF à venir')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur génération PDF: $e')),
      );
    }
  }
}