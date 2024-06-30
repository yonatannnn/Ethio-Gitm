import 'package:ethio_gitm/services/poemService.dart';
import 'package:ethio_gitm/services/poetService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddPoemForm extends StatefulWidget {
  @override
  _AddPoemFormState createState() => _AddPoemFormState();
}

class _AddPoemFormState extends State<AddPoemForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateController.text = currentDate;
  }

  PoemService poemService = PoemService();
  PoetService poetService = PoetService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 100),
        title: Text(
          'Add Poem',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(0, 0, 0, 100),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: dateController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: contentController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: authorController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Author',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an author.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      String author = authorController.text[0].toUpperCase() +
                          authorController.text.substring(1);
                      if (_formKey.currentState!.validate()) {
                        String date = dateController.text;
                        String title = titleController.text;
                        String content = contentController.text;

                        try {
                          await poemService.savePoemToFirestore(
                              date, title, content, author, '');

                          contentController.clear();
                          titleController.clear();
                          authorController.clear();
                          await poetService.savePoetToFirestore(author);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Poem saved successfully!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to save poem: $e')),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Save Poem',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
