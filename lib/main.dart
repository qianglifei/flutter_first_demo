import 'package:flutter/material.dart';
import 'application_page_view.dart';
import 'first_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData.light(),
        color: Colors.pink,
        home: FirstPage(),
    );
  }

}