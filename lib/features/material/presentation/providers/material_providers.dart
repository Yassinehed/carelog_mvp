import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carelog_mvp/features/material/domain/material_domain_providers.dart';

/// Provider for all materials list
final materialsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getAllMaterialsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load materials'),
    (materials) => materials,
  );
});

/// Provider for materials by type
final materialsByTypeProvider =
    FutureProvider.family<List<dynamic>, dynamic>((ref, type) async {
  final useCase = ref.watch(getMaterialsByTypeUseCaseProvider);
  final result = await useCase(type);
  return result.fold(
    (failure) => throw Exception('Failed to load materials by type'),
    (materials) => materials,
  );
});

/// Provider for materials by category
final materialsByCategoryProvider =
    FutureProvider.family<List<dynamic>, String>((ref, category) async {
  final useCase = ref.watch(getMaterialsByCategoryUseCaseProvider);
  final result = await useCase(category);
  return result.fold(
    (failure) => throw Exception('Failed to load materials by category'),
    (materials) => materials,
  );
});

/// Provider for low stock materials
final lowStockMaterialsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getLowStockMaterialsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load low stock materials'),
    (materials) => materials,
  );
});

/// Provider for out of stock materials
final outOfStockMaterialsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getOutOfStockMaterialsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load out of stock materials'),
    (materials) => materials,
  );
});

/// Provider for materials needing reorder
final materialsNeedingReorderProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getMaterialsNeedingReorderUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load materials needing reorder'),
    (materials) => materials,
  );
});

/// Provider for material statistics
final materialStatisticsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getMaterialStatisticsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load material statistics'),
    (stats) => stats,
  );
});

/// Provider for stock alerts
final stockAlertsProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getStockAlertsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception('Failed to load stock alerts'),
    (alerts) => alerts,
  );
});
