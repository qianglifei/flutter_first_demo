import 'package:flutter/material.dart';


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
                Image.asset("images/loading.png",fit: BoxFit.cover)
            ],
        ),
    );
  }

  void _getHasSkip() async{

  }

}