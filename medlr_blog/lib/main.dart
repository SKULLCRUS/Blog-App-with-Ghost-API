import 'package:flutter/material.dart';
import 'package:medlr_blog/screens/home_screen.dart';
import 'package:medlr_blog/screens/home_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen2(),
    );
  }
}
