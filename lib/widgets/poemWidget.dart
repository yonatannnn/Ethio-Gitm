import 'package:flutter/material.dart';
import '../screens/poemDetail.dart';

class Poem extends StatelessWidget {
  final int rollNo;
  final String title;
  final String author;
  final String poem;
  final DateTime date;

  const Poem({
    required this.date,
    required this.rollNo,
    required this.title,
    required this.author,
    required this.poem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoemDetail(
              id: rollNo.toString(),
              title: title,
              content: poem,
              date: date.toIso8601String(),
              author: author,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Color.fromRGBO(64, 75, 96, .9),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                '$rollNo,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'by $author',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
