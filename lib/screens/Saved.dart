import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';
import '../utlis/book_details_arguments.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  late Future<List<Book>> _savedBooks;

  @override
  void initState() {
    super.initState();
    _savedBooks = DatabaseHelper.instance.readAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Books')),
      body: FutureBuilder<List<Book>>(
        future: _savedBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved books'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final book = snapshot.data![index];
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/details',
                      arguments: BookDetailsArguments(itemBook:book));
                },
                child: ListTile(
                  leading: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    width: 50,
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
