import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/ui/home/home_screen.dart';
import 'package:flutter_pageview_bottomnav/ui/knowledge/knowledge_screen.dart';
import 'package:flutter_pageview_bottomnav/ui/navigation/navigation_screen.dart';
import 'package:flutter_pageview_bottomnav/ui/project/project_screen.dart';
import 'package:flutter_pageview_bottomnav/ui/public/publics_screen.dart';
import 'package:flutter_pageview_bottomnav/ui/search/search_screen.dart';
//应用页面使用有状态的Widget
class App extends StatefulWidget{
  App({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AppState();
  }
}
 //应用页面状态实现类
class AppState extends State<App>{
  //当前选中项的索引
  int _selectedIndex = 0;
  final appBarTitles = ['玩Android','体系','公众号','导航','项目'];
  int elevation = 4;

  var pages = <Widget>[
     HomeScreen(),
     KnowledgeScreen(),
     PublicScreen(),
     NavigationScreen(),
     ProjectScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: new Text(appBarTitles[_selectedIndex]),
            bottom: null,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    Navigator.of(context).
                    push(new MaterialPageRoute(
                        builder: (context){
                            return new SearchScreen();
                        })
                    );
                  }
              )
            ],
          ),
        ),
        onWillPop: null
    );
  }

}