import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';
import '../utlis/book_details_arguments.dart';

class Fav extends StatefulWidget {
  const Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  late Future<List<Book>> _favBooks;

  @override
  void initState() {
    super.initState();
    _favBooks = DatabaseHelper.instance.readFavouriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: FutureBuilder<List<Book>>(
        future: _favBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favourite books'));
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
                  leading: const Icon(Icons.favorite, color: Colors.red),
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
