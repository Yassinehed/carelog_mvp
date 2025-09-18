import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/domain/usecases/material/material_usecases.dart';
import 'package:carelog_mvp/injection.dart';

/// Provider for GetAllMaterials use case
final getAllMaterialsUseCaseProvider = Provider<GetAllMaterials>((ref) {
  return getIt<GetAllMaterials>();
});

/// Provider for GetMaterialById use case
final getMaterialByIdUseCaseProvider = Provider<GetMaterialById>((ref) {
  return getIt<GetMaterialById>();
});

/// Provider for CreateMaterial use case
final createMaterialUseCaseProvider = Provider<CreateMaterial>((ref) {
  return getIt<CreateMaterial>();
});

/// Provider for UpdateMaterial use case
final updateMaterialUseCaseProvider = Provider<UpdateMaterial>((ref) {
  return getIt<UpdateMaterial>();
});

/// Provider for DeleteMaterial use case
final deleteMaterialUseCaseProvider = Provider<DeleteMaterial>((ref) {
  return getIt<DeleteMaterial>();
});

/// Provider for GetMaterialsByType use case
final getMaterialsByTypeUseCaseProvider = Provider<GetMaterialsByType>((ref) {
  return getIt<GetMaterialsByType>();
});

/// Provider for GetMaterialsByCategory use case
final getMaterialsByCategoryUseCaseProvider =
    Provider<GetMaterialsByCategory>((ref) {
  return getIt<GetMaterialsByCategory>();
});

/// Provider for GetLowStockMaterials use case
final getLowStockMaterialsUseCaseProvider =
    Provider<GetLowStockMaterials>((ref) {
  return getIt<GetLowStockMaterials>();
});

/// Provider for GetOutOfStockMaterials use case
final getOutOfStockMaterialsUseCaseProvider =
    Provider<GetOutOfStockMaterials>((ref) {
  return getIt<GetOutOfStockMaterials>();
});

/// Provider for GetMaterialsNeedingReorder use case
final getMaterialsNeedingReorderUseCaseProvider =
    Provider<GetMaterialsNeedingReorder>((ref) {
  return getIt<GetMaterialsNeedingReorder>();
});

/// Provider for UpdateMaterialStock use case
final updateMaterialStockUseCaseProvider = Provider<UpdateMaterialStock>((ref) {
  return getIt<UpdateMaterialStock>();
});

/// Provider for StockInMaterial use case
final stockInMaterialUseCaseProvider = Provider<StockInMaterial>((ref) {
  return getIt<StockInMaterial>();
});

/// Provider for StockOutMaterial use case
final stockOutMaterialUseCaseProvider = Provider<StockOutMaterial>((ref) {
  return getIt<StockOutMaterial>();
});

/// Provider for GetMaterialStatistics use case
final getMaterialStatisticsUseCaseProvider =
    Provider<GetMaterialStatistics>((ref) {
  return getIt<GetMaterialStatistics>();
});

/// Provider for GetStockAlerts use case
final getStockAlertsUseCaseProvider = Provider<GetStockAlerts>((ref) {
  return getIt<GetStockAlerts>();
});
