import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethio_gitm/models/poemModel.dart';

class PoemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<PoemModel>> getPomes() {
    return _firestore.collection("Poems").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PoemModel.fromFirestore(doc)).toList());
  }

  Future<void> savePoemToFirestore(
    String date,
    String title,
    String content,
    String author,
    String id,
  ) async {
    try {
      String docId = '${author}_${title}';
      DocumentSnapshot docSnapshot =
          await _firestore.collection('Poems').doc(docId).get();

      if (docSnapshot.exists) {
        throw Exception(
            'A poem with the same title and auhtor already exists.');
      }

      await _firestore.collection('Poems').doc(docId).set({
        'id': docId,
        'date': date,
        'title': title,
        'content': content,
        'author': author,
      });

      print('Poem data saved successfully!');
    } catch (e) {
      print('Error saving Pome data: $e');
      throw Exception(e);
    }
  }

  Future<void> deletePoemFromFirestore(String docId) async {
    try {
      await _firestore.collection('Poems').doc(docId).delete();
      print('Poem deleted successfully!');
    } catch (e) {
      throw Exception('Error deleting poem: $e');
    }
  }

  Future<void> updatePoemInFirestore(
    String id,
    String date,
    String title,
    String content,
    String author,
  ) async {
    try {
      await _firestore.collection('Poems').doc(id).update({
        'date': date,
        'title': title,
        'content': content,
        'author': author,
        'id' : id
      });

      print('Poem data updated successfully!');
    } catch (e) {
      print('Error updating note data: $e');
      throw Exception(e);
    }
  }
}
