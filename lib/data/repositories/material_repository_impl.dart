import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/material.dart';
import '../../../domain/repositories/material_repository.dart';
import '../datasources/remote/firestore_datasource.dart';
import '../mappers/material_mapper.dart' as material_mapper;
import '../models/material_model.dart' as model;

/// Implementation of MaterialRepository using Firebase
@Injectable()
class MaterialRepositoryImpl implements MaterialRepository {
  final FirestoreDataSource _firestoreDataSource;

  MaterialRepositoryImpl(this._firestoreDataSource);

  static const String _collection = 'materials';

  @override
  Future<Either<Failure, List<Material>>> getAll() async {
    try {
      final docs = await _firestoreDataSource.getAllDocuments(_collection);
      final materials = docs.docs.map((doc) {
        final modelMaterial = model.Material.fromJson(doc.data());
        return material_mapper.MaterialMapper.toDomain(modelMaterial);
      }).toList();
      return Right(materials);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Material>> getById(String id) async {
    try {
      final doc = await _firestoreDataSource.getDocument(_collection, id);
      if (!doc.exists) {
        return const Left(ServerFailure());
      }
      final modelMaterial = model.Material.fromJson(doc.data()!);
      final material = material_mapper.MaterialMapper.toDomain(modelMaterial);
      return Right(material);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Material>> create(Material material) async {
    try {
      final modelMaterial = material_mapper.MaterialMapper.toModel(material);
      final docRef = await _firestoreDataSource.addDocument(
          _collection, modelMaterial.toJson());
      final createdMaterial = material.copyWith(reference: docRef.id);
      return Right(createdMaterial);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Material>> update(Material material) async {
    try {
      final modelMaterial = material_mapper.MaterialMapper.toModel(material);
      await _firestoreDataSource.updateDocument(
          _collection, material.id, modelMaterial.toJson());
      return Right(material);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) async {
    try {
      await _firestoreDataSource.deleteDocument(_collection, id);
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> exists(String id) async {
    try {
      final doc = await _firestoreDataSource.getDocument(_collection, id);
      return Right(doc.exists);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> count({Map<String, dynamic>? filters}) async {
    try {
      if (filters != null && filters.isNotEmpty) {
        // If filters are provided, use query to count
        final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
          _collection,
          (query) {
            Query<Map<String, dynamic>> q = query;
            filters.forEach((key, value) {
              q = q.where(key, isEqualTo: value);
            });
            return q;
          },
        );
        return Right(snapshot.docs.length);
      } else {
        // No filters, count all documents
        final snapshot =
            await _firestoreDataSource.getAllDocuments(_collection);
        return Right(snapshot.docs.length);
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Material>>> getPaginated({
    int limit = 20,
    String? startAfter,
    Map<String, dynamic>? filters,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> search(String query) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getByType(MaterialType type) async {
    try {
      final query = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('type', isEqualTo: type.name),
      );
      final materials = query.docs.map((doc) {
        final modelMaterial = model.Material.fromJson(doc.data());
        return material_mapper.MaterialMapper.toDomain(modelMaterial);
      }).toList();
      return Right(materials);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Material>>> getByCategory(
          String category) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getBySupplier(
          String supplierId) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getByStockStatus(
          StockStatus status) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getLowStock() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getOutOfStock() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getNeedingReorder() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getExpired() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getExpiringSoon() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Material>> updateStock(
    String materialId,
    double quantity,
    String type,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Material>> adjustStock(
    String materialId,
    double newStock,
    String reason,
    String userId, {
    Map<String, dynamic>? metadata,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Material>> stockIn(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Material>> stockOut(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Material>> updateInfo(
    String materialId, {
    String? name,
    String? description,
    MaterialType? type,
    UnitOfMeasure? unitOfMeasure,
    String? category,
    String? subCategory,
    String? supplierId,
    double? minimumStock,
    double? maximumStock,
    double? reorderPoint,
    double? unitPrice,
    String? currency,
    String? location,
    String? barcode,
    String? qrCode,
    DateTime? expiryDate,
    List<String>? compatibleMachines,
    List<String>? qualitySpecifications,
    String? updatedBy,
    Map<String, dynamic>? metadata,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<StockMovement>>> getStockMovements(
    String materialId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> getCompatibleWithMachine(
          String machineId) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, MaterialStats>> getStatistics() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> searchWithFilters({
    String? query,
    MaterialType? type,
    String? category,
    StockStatus? stockStatus,
    String? supplierId,
    bool? isActive,
    DateTime? expiryBefore,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Map<StockStatus, int>>> getCountByStatus() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, double>> getTotalInventoryValue() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Map<String, double>>>
      getInventoryValueByCategory() async => const Left(ServerFailure());

  @override
  Future<Either<Failure, List<StockAlert>>> getStockAlerts() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Material>>> bulkUpdateStock(
          List<StockUpdate> updates, String userId) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Supplier>> getSupplier(String supplierId) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Supplier>>> getAllSuppliers() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Supplier>> updateSupplier(
          String supplierId, Supplier supplier) async =>
      const Left(ServerFailure());
}
