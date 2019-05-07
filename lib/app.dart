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
    // TODO: 创建的时候需要俩个参数。1.child，2.和onWillPop
    //TODO: onWillPop ：表示当前页面将退出，值类型是一个函数 typedef Future<bool> WillPopCallBack();
    /**
     * WillPopScope(
        onWillPop: (){
        print('onWillPop');
        return Future.value(false);
        },
        child: Container(
        child: Text('haha'),
        ),
        ),
     */
    //false 表示 不退出，true 表示退出
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
          //侧滑功能
          //drawer: DrawerPage(),
          body: new IndexedStack(children: pages,index: _selectedIndex),
          //底部导航按钮包含图标及文本
          bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("首页")),
                BottomNavigationBarItem(icon: Icon(Icons.assignment),title: Text("体系")),
                BottomNavigationBarItem(icon: Icon(Icons.chat),title: Text("公众号")),
                BottomNavigationBarItem(icon: Icon(Icons.navigation),title: Text("导航")),
                BottomNavigationBarItem(icon: Icon(Icons.book),title: Text("项目")),
              ],
              //设置显示模式
              type: BottomNavigationBarType.fixed,
              //当前选中的索引
              currentIndex: _selectedIndex,
              //底部导航栏点击处理
              onTap: _onItemTapped,
          ),
        ),
        onWillPop: _onWillPop
    );
  }

  Future<bool> _onWillPop(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('确定要退出应用吗?'),
        actions: <Widget>[
          new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('再看一会')
          ),
          new FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text("退出")
          )
        ],
      ),
    ) ?? false;
  }
  //选择按下处理，设置当前索引，为index的值
  void _onItemTapped(int index) {
    setState(() {
        _selectedIndex = index;
        if(index == 4 || index == 2){
           elevation = 0;
        }else{
           elevation = 4;
        }
    });
  }
}