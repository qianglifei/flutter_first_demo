import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/message_screen.dart';
import 'pages/category_screen.dart';
import 'pages/mine_screen.dart';

class FirstPage extends StatefulWidget{
    _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>{
  final _BottomNavigationColor = Colors.lightBlue;

  List<Widget> list = List();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    list
        ..add(HomeScreen())
        ..add(MessageScreen())
        ..add(CategoryScreen())
        ..add(MineScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,color: _BottomNavigationColor),
                    title: Text('首页',style: TextStyle(color: _BottomNavigationColor))
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message,color: _BottomNavigationColor),
                    title: Text('信息',style: TextStyle(color: _BottomNavigationColor))
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                      color: _BottomNavigationColor,
                    ),
                    title: Text('分类',style: TextStyle(color: _BottomNavigationColor))
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.pregnant_woman,
                        color: _BottomNavigationColor,
                    ),
                    title: Text('我的',style: TextStyle(color: _BottomNavigationColor))
                ),
            ],
            currentIndex: _currentIndex,
            onTap: (int index){
                setState(() {
                    _currentIndex = index;
                });
            },
            type: BottomNavigationBarType.fixed,
        ),
    );
  }

}