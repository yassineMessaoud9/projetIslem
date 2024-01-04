import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testtech/Service/bookService.dart';
import 'package:testtech/pages/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/book.dart';
import 'add_book_form.dart';

class Books extends StatefulWidget {
  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<Book> bookList = []; // Initialize as an empty list
  final BookService bookService = BookService();

  List<Book> filteredBookList = [];

  @override
  void initState() {
    super.initState();
    getAllBooks(); // Call getAllBooks when the widget is initialized
  }

  void watchBook(Book book) async {
    // Open the book's link
    await launch(book.link);

    // Update the clicked count
    final updateResult = await bookService.updateBookclick(
        book.id ?? '' // Assuming you have an 'id' property in your Book class
        );

    if (updateResult['success']) {
      // Successfully updated the clicked count
      print('Clicked count updated successfully');
    } else {
      // Handle the case where updating the clicked count was unsuccessful
      print('Failed to update clicked count: ${updateResult['error']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.area_chart),
            onPressed: () {
              Get.to(() => Charts());
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showAddBookBottomSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //... (unchanged code)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                filterBooks(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBookList.length,
              itemBuilder: (context, index) {
                final currentBook = filteredBookList[index];

                // Set color based on the 'clicked' attribute
                Color iconColor =
                    currentBook.clicked == 1 ? Colors.green : Colors.red;

                return ListTile(
                  leading: Icon(Icons.picture_as_pdf, color: iconColor),
                  title: Text(filteredBookList[index].title),
                  subtitle: Text(filteredBookList[index].description),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // Handle watch icon click
                      watchBook(filteredBookList[index]);
                    },
                  ),
                  // Add more details to the ListTile as needed
                  // For example, onTap, etc.
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterBooks(String query) {
    setState(() {
      filteredBookList = bookList
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showAddBookBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddBookForm();
      },
    ).then((value) {
      if (value != null && value is Book) {
        setState(() {
          bookList.add(value);
          filteredBookList = List.from(bookList);
        });
      }
    });
  }

  // Fetch books from the server using the getAllBooks method
  void getAllBooks() async {
    try {
      final result = await bookService.getAllBooks();
      if (result['success']) {
        setState(() {
          // Update the bookList and filteredBookList with the retrieved data
          bookList = List<Book>.from(
            (result['data'] as List).map((book) => Book.fromJson(book)),
          );
          filteredBookList = List.from(bookList);
        });
      } else {
        // Handle the case where fetching books was unsuccessful
        // You might want to show an error message to the user
        print(result['error']);
      }
    } catch (e) {
      // Handle other errors
      print(e);
    }
  }
}
