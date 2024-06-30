import 'package:ethio_gitm/widgets/poemList.dart';
import 'package:ethio_gitm/widgets/poemWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 3, 3),
          title: Text(
            'Poems',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 17, 3, 3),
        body: PoemList());
  }
}
