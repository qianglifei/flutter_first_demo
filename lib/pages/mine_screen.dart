import 'package:flutter/material.dart';

class MineScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MineScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('MineScreen',style: TextStyle(color: Colors.blue,fontSize: 45.0)),
      ),
    );
  }

}