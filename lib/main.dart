// ignore_for_file: prefer_const_constructors

import 'package:contactlis/contactlist.dart';
import 'package:contactlis/sleash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Sleash(),
      routes: {
        Contactlist.path: (context) => Contactlist(),
        Sleash.path: (context) => Sleash(),
      },
    );
  }
}
