import 'package:appmobile/view/main_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Exemplo',
      theme: new ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      home: MainPage(),
    );
  }
}
