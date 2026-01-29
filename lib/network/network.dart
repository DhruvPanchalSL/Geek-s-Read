import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class Network {
  static const String _baseUrl =
      'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> searchBooks(String query) async {
    if (query.trim().isEmpty) return [];

    final url = Uri.parse('$_baseUrl?q=${Uri.encodeComponent(query)}');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load books');
    }

    final data = jsonDecode(response.body);

    if (data['items'] == null) {
      return [];
    }

    return (data['items'] as List)
        .map((item) => Book.fromApiJson(item))
        .toList();
  }
}
