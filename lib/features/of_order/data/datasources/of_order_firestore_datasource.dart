import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/of_order.dart';
import '../models/of_order_dto.dart';

/// Datasource for OfOrder operations in Firestore.
abstract class IOfOrderDatasource {
  /// Creates a new OfOrder.
  Future<OfOrder> createOfOrder(OfOrder ofOrder);

  /// Lists all OfOrders.
  Future<List<OfOrder>> listOfOrders();

  /// Updates the status of an OfOrder. Should append history atomically.
  Future<OfOrder> updateOfOrderStatus(String id, OfOrderStatus status, {String? updatedBy});

  /// Returns true if the quality checklist for the order is complete.
  Future<bool> isChecklistComplete(String id);
}

/// Firestore implementation of IOfOrderDatasource.
@Injectable()
class OfOrderFirestoreDatasource implements IOfOrderDatasource {
  final FirebaseFirestore _firestore;

  OfOrderFirestoreDatasource(this._firestore);

  static const String _collection = 'of_orders';

  @override
  Future<OfOrder> createOfOrder(OfOrder ofOrder) async {
    final dto = OfOrderMapper.toDto(ofOrder);
    final docRef =
        await _firestore.collection(_collection).add(dto.toFirestore());
    final doc = await docRef.get();
    return OfOrderMapper.fromDto(OfOrderDto.fromFirestore(doc));
  }

  @override
  Future<List<OfOrder>> listOfOrders() async {
    final querySnapshot = await _firestore.collection(_collection).get();
    return querySnapshot.docs
        .map((doc) => OfOrderMapper.fromDto(OfOrderDto.fromFirestore(doc)))
        .toList();
  }

  @override
  Future<OfOrder> updateOfOrderStatus(String id, OfOrderStatus status, {String? updatedBy}) async {
    final docRef = _firestore.collection(_collection).doc(id);

    await _firestore.runTransaction((txn) async {
      final snapshot = await txn.get(docRef);
      if (!snapshot.exists) {
        throw Exception('Order not found');
      }

      final data = snapshot.data();
      final currentStatus = data?['status'] as String? ?? '';

      final history = List.from(data?['statusUpdateHistory'] ?? []);
      history.add({
        'from': currentStatus,
        'to': OfOrderMapper.statusToString(status),
        'timestamp': FieldValue.serverTimestamp(),
        'updatedBy': updatedBy,
      });

      txn.update(docRef, {
        'status': OfOrderMapper.statusToString(status),
        'updatedAt': FieldValue.serverTimestamp(),
        'updatedBy': updatedBy,
        'statusUpdateHistory': history,
      });
    });

    final doc = await docRef.get();
    return OfOrderMapper.fromDto(OfOrderDto.fromFirestore(doc));
  }

  @override
  Future<bool> isChecklistComplete(String id) async {
    final checklistCol = _firestore.collection('$_collection/$id/quality_checklist');
    final snapshot = await checklistCol.where('checked', isEqualTo: false).limit(1).get();
    return snapshot.docs.isEmpty;
  }
}
