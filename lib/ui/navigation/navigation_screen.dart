import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';

class NavigationScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return NavigationScreenState();
  }

}

class NavigationScreenState extends BaseWidgetState<NavigationScreen>{
  @override
  AppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return null;
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}