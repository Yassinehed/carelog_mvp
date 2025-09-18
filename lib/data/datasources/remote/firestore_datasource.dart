import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

/// Base Firestore datasource providing common CRUD operations
@Injectable()
class FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSource(this._firestore);

  /// Get a document by ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
    String collection,
    String id,
  ) async {
    return await _firestore.collection(collection).doc(id).get();
  }

  /// Get all documents in a collection
  Future<QuerySnapshot<Map<String, dynamic>>> getAllDocuments(
    String collection,
  ) async {
    return await _firestore.collection(collection).get();
  }

  /// Get documents with query
  Future<QuerySnapshot<Map<String, dynamic>>> getDocumentsWithQuery(
    String collection,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)
        queryBuilder,
  ) async {
    final query = queryBuilder(_firestore.collection(collection));
    return await query.get();
  }

  /// Add a new document
  Future<DocumentReference<Map<String, dynamic>>> addDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    return await _firestore.collection(collection).add(data);
  }

  /// Set a document (create or overwrite)
  Future<void> setDocument(
    String collection,
    String id,
    Map<String, dynamic> data, {
    SetOptions? options,
  }) async {
    await _firestore.collection(collection).doc(id).set(data, options);
  }

  /// Update a document
  Future<void> updateDocument(
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collection).doc(id).update(data);
  }

  /// Delete a document
  Future<void> deleteDocument(
    String collection,
    String id,
  ) async {
    await _firestore.collection(collection).doc(id).delete();
  }

  /// Check if document exists
  Future<bool> documentExists(
    String collection,
    String id,
  ) async {
    final doc = await _firestore.collection(collection).doc(id).get();
    return doc.exists;
  }

  /// Get documents with pagination
  Future<QuerySnapshot<Map<String, dynamic>>> getDocumentsPaginated(
    String collection, {
    DocumentSnapshot? startAfter,
    int limit = 20,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)?
        queryBuilder,
  }) async {
    Query<Map<String, dynamic>> query = _firestore.collection(collection);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return await query.limit(limit).get();
  }

  /// Listen to document changes
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToDocument(
    String collection,
    String id,
  ) {
    return _firestore.collection(collection).doc(id).snapshots();
  }

  /// Listen to collection changes
  Stream<QuerySnapshot<Map<String, dynamic>>> listenToCollection(
    String collection, {
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)?
        queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(collection);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    return query.snapshots();
  }

  /// Batch operations
  Future<void> executeBatch(
    void Function(WriteBatch batch) batchOperations,
  ) async {
    final batch = _firestore.batch();
    batchOperations(batch);
    await batch.commit();
  }

  /// Transaction operations
  Future<T> executeTransaction<T>(
    Future<T> Function(Transaction transaction) transactionHandler,
  ) async {
    return await _firestore.runTransaction(transactionHandler);
  }

  /// Get collection reference
  CollectionReference<Map<String, dynamic>> getCollection(String collection) {
    return _firestore.collection(collection);
  }

  /// Get document reference
  DocumentReference<Map<String, dynamic>> getDocumentRef(
    String collection,
    String id,
  ) {
    return _firestore.collection(collection).doc(id);
  }
}
