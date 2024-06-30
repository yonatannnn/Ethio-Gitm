import 'package:ethio_gitm/models/poemModel.dart';
import 'package:ethio_gitm/services/poemService.dart';
import 'package:ethio_gitm/widgets/poemWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoemList extends StatelessWidget {
  PoemList({super.key});
  final PoemService poemService = PoemService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PoemModel>>(
      stream: poemService.getPomes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Poems Found.',
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        List<PoemModel> poems = snapshot.data!;
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: poems.length,
          itemBuilder: (BuildContext context, int index) {
            return Poem(
              rollNo: index + 1,
              title: poems[index].title,
              author: poems[index].author,
              poem: poems[index].content,
              date: poems[index].date,
            );
          },
        );
      },
    );
  }
}
