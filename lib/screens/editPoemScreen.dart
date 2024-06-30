import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ethio_gitm/services/poemService.dart';

class EditPoemScreen extends StatefulWidget {
  final String id;
  final String initialTitle;
  final String initialContent;
  final String initialDate;
  final String initialAuthor;

  EditPoemScreen({
    Key? key,
    required this.id,
    required this.initialTitle,
    required this.initialContent,
    required this.initialDate,
    required this.initialAuthor,
  }) : super(key: key);

  @override
  _EditPoemScreenState createState() => _EditPoemScreenState();
}

class _EditPoemScreenState extends State<EditPoemScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.initialDate;
    dateController.text = currentDate;
    titleController.text = widget.initialTitle;
    contentController.text = widget.initialContent;
    authorController.text = widget.initialAuthor;
  }

  PoemService poemService = PoemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 100),
        title: Text(
          'Edit Poem',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(0, 0, 0, 100),
      body: Container(
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                      if (_formKey.currentState!.validate()) {
                        String date = dateController.text;
                        String title = titleController.text;
                        String content = contentController.text;
                        String author = authorController.text;

                        try {
                          await poemService.updatePoemInFirestore(
                            widget.id,
                            date,
                            title,
                            content,
                            author,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Poem updated successfully!')),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to update poem: $e')),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 110, 101, 101),
                      padding: EdgeInsets.symmetric(vertical: 14),
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
