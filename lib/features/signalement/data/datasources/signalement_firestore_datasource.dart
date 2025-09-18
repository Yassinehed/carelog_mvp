import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/signalement_dto.dart';

/// Firestore datasource for Signalement.
@Injectable()
class SignalementFirestoreDatasource {
  final FirebaseFirestore firestore;
  final String collectionPath = 'signalements';

  const SignalementFirestoreDatasource(this.firestore);

  Future<void> createSignalement(SignalementDto dto) async {
    await firestore
        .collection(collectionPath)
        .doc(dto.id)
        .set(dto.toFirestore());
  }

  Future<List<SignalementDto>> getSignalements() async {
    final snapshot = await firestore.collection(collectionPath).get();
    return snapshot.docs
        .map((doc) => SignalementDto.fromFirestore(doc))
        .toList();
  }

  Future<void> updateSignalementStatus(String id, String newStatus) async {
    await firestore
        .collection(collectionPath)
        .doc(id)
        .update({'status': newStatus});
  }

  Future<SignalementDto?> getSignalementById(String id) async {
    final doc = await firestore.collection(collectionPath).doc(id).get();
    if (doc.exists) {
      return SignalementDto.fromFirestore(doc);
    }
    return null;
  }
}
