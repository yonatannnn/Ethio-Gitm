import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethio_gitm/models/PoetModel.dart';

class PoetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Poet>> getPoets() {
    return _firestore.collection("Poets").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Poet.fromFirestore(doc)).toList());
  }

  Future<void> savePoetToFirestore(String name) async {
    name = name[0].toUpperCase() + name.substring(1);
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('Poets').doc(name).get();

      if (docSnapshot.exists) {
        throw Exception('A poet with the same name and auhtor already exists.');
      }

      await _firestore.collection('Poets').doc(name).set({'name': name});

      print('Poet data saved successfully!');
    } catch (e) {
      print('Error saving Poet data: $e');
      throw Exception(e);
    }
  }
}
