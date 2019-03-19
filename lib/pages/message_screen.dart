import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MessageScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('MessageScreen',style: TextStyle(color: Colors.blue,fontSize: 45.0)),
      ),
    );
  }

}