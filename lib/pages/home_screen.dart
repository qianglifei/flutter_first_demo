import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('HomeScreen'),
            centerTitle: true,
        ),
        body: Center(
            child: Text('HomeScreen',style: TextStyle(color: Colors.blue,fontSize: 45.0)),
        ),
    );
  }

}