import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CategoryScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('CategoryScreen',style: TextStyle(color: Colors.blue,fontSize: 45.0)),
      ),
    );
  }

}