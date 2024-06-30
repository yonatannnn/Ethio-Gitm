import 'package:cloud_firestore/cloud_firestore.dart';

class Poet {
  String name;
  Poet({required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Poet.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Poet(
      name: data['name'],
    );
  }
}
