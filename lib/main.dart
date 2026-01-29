import 'package:flutter/material.dart';
import 'package:reader_book/models/book.dart';
import 'package:reader_book/network/network.dart';
import 'package:reader_book/screens/DetailsScreen.dart';
import 'package:reader_book/screens/Fav.dart';
import 'package:reader_book/screens/Home.dart';
import 'package:reader_book/screens/Saved.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home':(context)=>Home(),
        '/saved':(context)=>Saved(),
        '/fav':(context)=>Fav(),
        '/details':(context)=>BookDetails(),


      },
      home: MyWidget(),
      
    ) ;
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _currentIndex=0;


  final List<Widget> _screens=[
   Home(),
    Fav(),
    Saved(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geek`s Read',),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body:_screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.amber,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label:'Favourates'),
        BottomNavigationBarItem(icon: Icon(Icons.save),label:'Saved'),
      ],
        selectedItemColor:Colors.white ,
        unselectedItemColor: Colors.white70,
        onTap: (value){
          print('Tapped: $value');
        setState(() {
          _currentIndex=value;
        });
        },

      ),
    );
  }
}
