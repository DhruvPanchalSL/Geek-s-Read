import 'package:flutter/material.dart';
import 'package:reader_book/screens/DetailsScreen.dart';

import '../models/book.dart';
import '../network/network.dart';
import '../utlis/book_details_arguments.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Network network=Network();
  List<Book> _books=[];
  Future<void>_searchBooks(String query)async{

    try{
      List<Book> books =await network.searchBooks(query);
      print("Books: ${books.toString()}");
      setState(() {
        _books=books;
      });
    } catch (e, stackTrace) {
      print('Search error: $e');
      print(stackTrace);
    }

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a Book',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                onSubmitted:(query)=>_searchBooks(query),
              ),
            ),
            Expanded(child: GridView.builder(
                itemCount: _books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:0.6 ),
                itemBuilder: (context, index) {
                  Book book=_books[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/details',
                          arguments: BookDetailsArguments(itemBook:book));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.network(book.imageLinks['thumbnail']?? ''),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(book.title,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 25,
                                child: Text(book.authors.join(', & '),
                                  style: Theme.of(context).textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },))
            // Expanded(
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: ListView.builder(itemCount: _books.length,itemBuilder: (context, index) {
            //       Book book=_books[index];
            //       return ListTile(
            //         title:Text(book.title) ,
            //         subtitle: Text(book.authors.join(', & ')?? ''),
            //       );
            //     },),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}


