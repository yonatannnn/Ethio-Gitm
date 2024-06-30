import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ethio_gitm/models/PoetModel.dart';
import 'package:ethio_gitm/screens/addPoem.dart';
import 'package:ethio_gitm/services/poetService.dart';
import 'package:ethio_gitm/widgets/poemList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PoetService _poetService;
  String? selectedAuthor = 'All'; // Initialize selectedAuthor to 'All'
  List<String> authors = ['All'];
  late StreamController<List<Poet>> _poetsController;
  Stream<List<Poet>> get poetsStream => _poetsController.stream;

  @override
  void initState() {
    super.initState();
    _poetService = PoetService();
    _poetsController = StreamController<List<Poet>>();
    _loadPoets();
  }

  @override
  void dispose() {
    _poetsController.close();
    super.dispose();
  }

  void _loadPoets() {
    _poetService.getPoets().listen((List<Poet> poets) {
      _poetsController.add(poets);
      for (Poet p in poets) {
        authors.add(p.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 100),
        title: Text(
          'Poems',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(0, 0, 0, 100),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 5, 16, 0),
              width: double.infinity,
              child: Center(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Text(
                    'Select Author',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  dropdownColor: Colors.black,
                  value: selectedAuthor,
                  items: authors.map((String author) {
                    return DropdownMenuItem<String>(
                      value: author,
                      child: Center(
                        child: Text(
                          author,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAuthor = newValue;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: PoemList(
                  author: selectedAuthor),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPoemForm()),
          );
        },
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Icon(Icons.add),
      ),
    );
  }
}
