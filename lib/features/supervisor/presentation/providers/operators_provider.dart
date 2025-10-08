import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/operator_model.dart';

final operatorsProvider = StreamProvider<List<OperatorModel>>((ref) {
  final snap = FirebaseFirestore.instance.collection('operators').snapshots();
  return snap.map((s) => s.docs.map((d) => OperatorModel(id: d.id, name: d.data()['name'] as String? ?? d.id, skills: List<String>.from(d.data()['skills'] ?? []))).toList());
});

final operatorWorkloadProvider = FutureProvider.family<int, String>((ref, operatorId) async {
  final q = await FirebaseFirestore.instance.collection('of_orders').where('assignedOperator', isEqualTo: operatorId).get();
  return q.docs.length;
});
