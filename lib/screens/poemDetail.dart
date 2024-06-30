import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoemDetail extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String date;
  final String author;

  const PoemDetail({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 3, 3),
        title: Text(
          'Poem Detail',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 17, 3, 3),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 2),
            Text(
              'by $author',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 26),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
