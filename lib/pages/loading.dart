import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/app.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoadingPage extends StatefulWidget{
    _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //在加载页面停顿三秒
    new Future.delayed(Duration(seconds: 3),(){
        _getHasSkip();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Stack(
            children: <Widget>[
                Image.asset("images/loading.png",fit: BoxFit.cover,width: double.infinity,height: double.infinity)
            ],
        ),
    );
  }

  void _getHasSkip() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSkip = prefs.getBool("hasSkip");
    if(hasSkip==null||!hasSkip){
      Navigator.of(context).pushReplacementNamed("splash");
    }else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => App()),
              (route) => route == null);
    }
  }

}