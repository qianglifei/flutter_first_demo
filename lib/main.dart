import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/app.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_pageview_bottomnav/pages/loading.dart';
import 'package:flutter_pageview_bottomnav/utils/theme_util.dart';
import 'splash_screen.dart';

void main(){
    runApp(MyApp());
    if(Platform.isAndroid){
        //以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}

class MyApp extends StatelessWidget {
  Color themeColor = ThemeUtils.currentColorTheme;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: "Flutter Demo",
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: themeColor,
          brightness: Brightness.light
        ),
        color: Colors.pink,
        home: new LoadingPage(),
        /**
         * 路由分为静态路由，和动态路由，这里是静态路由，不能向下一个界面传递参数
         */
        routes: <String,WidgetBuilder>{
            "app" : (BuildContext context) => new App(),
            "splash" : (BuildContext context) => new SplashScreen()
        },
    );
  }
}