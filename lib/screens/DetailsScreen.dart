import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';
import '../utlis/book_details_arguments.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              book.imageLinks['thumbnail'] ?? '',
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(book.title, style: theme.headlineSmall),
                  Text(book.authors.join(', ')),
                  Text('Pages: ${book.pageCount}'),
                  Text('Language: ${book.language}'),
                  const SizedBox(height: 20),

                  // ---------- BUTTONS ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await DatabaseHelper.instance.insert(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Book Saved ✅')),
                          );
                        },
                        child: const Text('Save'),
                      ),

                      ElevatedButton.icon(
                        onPressed: () async {
                          final favBook = Book(
                            id: book.id,
                            title: book.title,
                            authors: book.authors,
                            publisher: book.publisher,
                            publishedDate: book.publishedDate,
                            description: book.description,
                            pageCount: book.pageCount,
                            language: book.language,
                            imageLinks: book.imageLinks,
                            previewLink: book.previewLink,
                            infoLink: book.infoLink,
                            isFavourite: true,
                          );

                          await DatabaseHelper.instance.insert(favBook);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Added to Favourites ❤️')),
                          );
                        },
                        icon: const Icon(Icons.favorite),
                        label: const Text('Favourite'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Text('Description', style: theme.titleLarge),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.amber
                      )
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(book.description
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
