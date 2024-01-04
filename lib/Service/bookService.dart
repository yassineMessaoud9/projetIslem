import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testtech/Service/Api.dart';
import 'package:testtech/models/book.dart';

class BookService {
// Add book using baseUrl
  Future<Map<String, dynamic>> AddBook(Book book) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiConfig.baseUrl}book/addBook'), // Replace 'addBookEndpoint' with the actual endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(book
            .toJson()), // Assuming toJson() method is implemented in your Book class
      );

      if (response.statusCode == 201) {
        // Successful response
        //call to the get all books method and return the response
        getAllBooks();
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        // Unsuccessful response
        return {
          'success': false,
          'error': 'Failed to add book. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors and return an appropriate response
      print(e);
      return {'success': false, 'error': e.toString()};
    }
  }

  // Get all books
  Future<Map<String, dynamic>> getAllBooks() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}book/AllBooks'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Check for null before using jsonDecode
        final jsonData = jsonDecode(response.body);
        return {'success': true, 'data': jsonData ?? {}};
      } else {
        // Unsuccessful response
        return {
          'success': false,
          'error': 'Failed to get books. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors and return an appropriate response
      print(e);
      return {'success': false, 'error': e.toString()};
    }
  }

  //update attribute of book by id
  Future<Map<String, dynamic>> updateBookclick(String id) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}book/updateClickedBook/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Check for null before using jsonDecode
        getAllBooks();
        final jsonData = jsonDecode(response.body);
        return {'success': true, 'data': jsonData ?? {}};
      } else {
        // Unsuccessful response
        return {
          'success': false,
          'error': 'Failed to update book. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors and return an appropriate response
      print(e);
      return {'success': false, 'error': e.toString()};
    }
  }

  //fetchClickData()
  Future<Map<String, dynamic>> fetchClickData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}book/NumberofClickedNotClicked'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Check for null before using jsonDecode
        final jsonData = jsonDecode(response.body);
        return {'success': true, 'data': jsonData ?? {}};
      } else {
        // Unsuccessful response
        return {
          'success': false,
          'error': 'Failed to get books. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors and return an appropriate response
      print(e);
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getBookCreationStatistics() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}book/getBookCreationStatistics'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Check for null before using jsonDecode
        final jsonData = jsonDecode(response.body);
        return {'success': true, 'data': jsonData ?? {}};
      } else {
        // Unsuccessful response
        return {
          'success': false,
          'error': 'Failed to get books. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors and return an appropriate response
      print(e);
      return {'success': false, 'error': e.toString()};
    }
  }
}
