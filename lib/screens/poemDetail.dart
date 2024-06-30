import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethio_gitm/services/poemService.dart';

class PoemDetail extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String date;
  final String author;

  PoemDetail({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  }) : super(key: key);

  final PoemService poemService = PoemService();

  void _deletePoem(BuildContext context) async {
    try {
      await poemService.deletePoemFromFirestore('${author}_${title}');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Poem deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete poem: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 100),
        title: Text(
          '',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deletePoem(context),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(0, 0, 0, 100),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
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
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(height: 26),
              Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
