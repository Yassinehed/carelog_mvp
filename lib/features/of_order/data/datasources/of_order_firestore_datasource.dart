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

  /// Updates the status of an OfOrder.
  Future<OfOrder> updateOfOrderStatus(String id, OfOrderStatus status);
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
  Future<OfOrder> updateOfOrderStatus(String id, OfOrderStatus status) async {
    final docRef = _firestore.collection(_collection).doc(id);
    await docRef.update({
      'status': OfOrderMapper.statusToString(status),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    final doc = await docRef.get();
    return OfOrderMapper.fromDto(OfOrderDto.fromFirestore(doc));
  }
}
