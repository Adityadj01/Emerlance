// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:emerlance/login.dart';
import 'package:dcdg/dcdg.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emerlance',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans', 
            fontSize: 45.0,
            color: Colors.orange,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.orange),
      ),
      home: const LoginScreen(),
    );
  }
}