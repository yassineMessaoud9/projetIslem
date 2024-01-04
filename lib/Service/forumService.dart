import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testtech/Service/Api.dart';
import 'package:testtech/models/UserModel.dart';

class ForumService {
  Future<List<Map<String, dynamic>>> getForum() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}forum/getAll'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to get forum. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createForum(
      String title, String description, File imageFile, UserModel user) async {
    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConfig.baseUrl}book'),
    );

    // Add text fields
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['user'] = jsonEncode(user.toJson());

    // Add image file
    if (imageFile != null) {
      var image = await http.MultipartFile.fromPath('image', imageFile.path);
      request.files.add(image);
    }

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception(
          'Failed to create forum. Status code: ${response.statusCode}');
    }
  }
}
