import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';

class HomeScreen extends BaseWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('HomeScreen'),
            centerTitle: true,
        ),
        body: Center(
            child: Text('HomeScreen',style: TextStyle(color: Colors.blue,fontSize: 45.0)),
        ),
    );
  }

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return null;
  }

}