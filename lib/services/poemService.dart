import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethio_gitm/models/poemModel.dart';

class PoemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<PoemModel>> getPomes() {
    return _firestore.collection("Poems").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PoemModel.fromFirestore(doc)).toList());
  }
}
