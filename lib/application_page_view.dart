import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget{
    _ApplicationPageState createState()=> _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('PageView Bottom Navigator'),
            centerTitle: true,
        ),
        body: new PageView.builder(
            controller: _pageController,
            onPageChanged: _pageChange,
            itemBuilder: (BuildContext context,int index){
              return index == 0? Text('我是第一页'):Text('我是第二页');
            },
            itemCount: 2,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),title: Text('首页')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message),title: Text('我的')
              )
          ],
          currentIndex: _currentPageIndex,
          onTap: onTap,
        ),
    );
  }


  void _pageChange(int index){
      setState(() {
          if(_currentPageIndex != index){
              _currentPageIndex = index;
          }
      });
  }

  void onTap(int index) {
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300) ,curve: Curves.ease);
  }
}