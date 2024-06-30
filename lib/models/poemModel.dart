import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PoemModel {
  final String id;
  final String title;
  final String author;
  final String content;
  final DateTime date;

  PoemModel({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'date': date.toIso8601String(),
    };
  }

  factory PoemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PoemModel(
      id: data['id'],
      title: data['title'],
      author: data['author'],
      content: data['content'],
      date: DateTime.parse(data['date']),
    );
  }
}
