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
          UserAccountsDrawerHeader(
              accountName: InkWell(
                child: Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                onTap: (){
                  if(!isLogin){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (context){
                          //return new LoginPage();
                        }
                    ));
                  }
                },
              ),
              currentAccountPicture: InkWell(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/head.jpeg'),
                ),
                onTap: (){
                  if(!isLogin){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder:(context){
                          //return new LoginPage();
                        }
                    ));
                  }
                },
              ),
          ),
          ListTile(
            title: Text(
              '我的收藏',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.collections,size: 22.0,),
            onTap: (){
              if(isLogin){
                onCollectionClick();
              }else{
                onLoginClick();
              }
            },
          ),
          ListTile(
            title: Text(
                '常用网站',
                textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.web,size: 22.0),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    //return new CmmonWebsitePage();
                  }
              ));
            },
          ),
          ListTile(
            title: Text(
              '主题',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.settings,size: 22.0),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return SimpleDialog(
                      title: Text('设置主题'),
                      //children:
                    );
                  }
              );
            },
          ),
          ListTile(
            title: Text(
                '分享',
                textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.share,size: 22.0),
            onTap: (){
              //S
            },
          ),
          ListTile(
            title: Text('妹子图', textAlign: TextAlign.left),
            leading: Icon(Icons.directions_bus,size: 22.0),
            onTap: (){
              //TODO: 跳转到下一个页面
            },
          ),
          ListTile(
            title: Text('关于作者',textAlign: TextAlign.left),
            leading: Icon(Icons.info,size: 22.0),
            onTap: (){
              //TODO:跳转到下一个页面
            },
          )
        ],
      ),
    );
  }

  void onCollectionClick() {}

  void onLoginClick() {}

}