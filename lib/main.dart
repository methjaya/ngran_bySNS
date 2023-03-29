import 'package:flutter/material.dart';
import 'package:ngram/pages/detail_page.dart';
import 'package:ngram/pages/nav_pages/main_page.dart';
import 'package:ngram/pages/nav_pages/main_page.dart';
//import 'package:ngram/pages/try.dart';
//import 'package:ngram/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App for NGRAM',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        fontFamily: 'San-francisco',

      ),
      
      home : MainPage()
      //home: DetailPage()
    );
  }
}
