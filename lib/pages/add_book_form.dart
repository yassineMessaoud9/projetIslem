import 'package:flutter/material.dart';
import 'package:testtech/Service/bookService.dart';

import '../models/book.dart';

class AddBookForm extends StatefulWidget {
  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BookService _bookService = BookService();

  // Add book
  Future<void> _addBook() async {
    DateTime now = DateTime.now(); // 'late' keyword is not needed here
    try {
      // Create a Book without an _id
      final bookToAdd = Book(
          null,
          _nameController.text,
          _descriptionController.text,
          _linkController.text,
          now.toIso8601String(),
          0);

      // Assume _bookService.AddBook can handle a book without an _id
      final Map<String, dynamic> response =
          await _bookService.AddBook(bookToAdd);
      print(response);
      // You can return a value here if needed
    } catch (e) {
      print(e);
      // Handle the exception or return an error value if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Book Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Link'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addBook();
                if (validateAndSaveForm()) {
                  Navigator.pop(
                    context,
                    Book(
                        null,
                        _nameController.text,
                        _descriptionController.text,
                        _linkController.text,
                        DateTime.now().toString(),
                        0),
                  );
                }
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSaveForm() {
    // Add your validation logic here
    return true;
  }
}
