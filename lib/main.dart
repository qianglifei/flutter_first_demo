import 'package:flutter/material.dart';
import 'first_page.dart';
import 'dart:io';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: "Flutter Demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        color: Colors.pink,
        home: SplashScreen(),
//        routes: <String,WidgetBuilder>{
//            "app" : (BuildContext context) => new FirstPage(),
//            "splash" : (BuildContext context) => new SplashScreen()
//        },
    );
  }

}