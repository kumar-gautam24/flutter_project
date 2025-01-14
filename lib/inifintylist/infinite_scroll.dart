

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookRepo {
  static Future<List<Book>> getBooks(int quantity) async {
    // print("in repo");
    var response = await ApiService().fetchBooks(quantity);
    // print('Response: $response');
    // print('Response Type: ${response.runtimeType}');
    return response!.map((e) => Book.fromJson(e)).toList();
  }
} /


class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>?> fetchBooks(int quantity) async {
    try {
      // print("in api request");
      final response = await _dio.get(
        'https://fakerapi.it/api/v2/books',
        queryParameters: {'_quantity': quantity},
      );

      if (response.statusCode == 200) {
        //   print('Status: ${response.data['status']}');
        //   print('Code: ${response.data['code']}');
        //   print('Total: ${response.data['total']}');
        //   print('Data: ${response.data['data']}');
        return response.data['data'];
      } else {
        // print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // print(' in api Exception: $e');
    }
    return null;
  }
}
class Book {
  final int id;
  final String title;
  final String author;

  const Book({required this.id, required this.title, required this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
    );
  }
}

class ScrollScreen extends StatefulWidget {
  const ScrollScreen({super.key});

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Book> _books = [];
  int _quantity = 15;
 

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchBooks();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _quantity += 15;
      _fetchBooks();
    }
  }

  Future<void> _fetchBooks() async {
 
    List<Book> newBooks = await BookRepo.getBooks(_quantity);
    setState(() {
      _books.addAll(newBooks);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinity List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].author),
          );
        },
      ),
    );
  }
}
