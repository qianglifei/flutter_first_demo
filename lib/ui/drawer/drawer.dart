import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DrawerPageState();
  }

}

class DrawerPageState extends State<DrawerPage>{
  bool isLogin = false;
  String username = "未登录";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
//          UserAccountsDrawerHeader(
//              accountName: InkWell(
//
//              ),
//              accountEmail: null
//          )
        ],
      ),
    );
  }

}