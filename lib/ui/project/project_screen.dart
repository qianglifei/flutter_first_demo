import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/project_tree_model.dart';
import 'package:flutter_pageview_bottomnav/common/application.dart';
import 'package:flutter_pageview_bottomnav/event/ChangeThemeEvent.dart';
import 'package:flutter_pageview_bottomnav/utils/theme_util.dart';

class ProjectScreen extends BaseWidget{


  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return ProjectScreenState();
  }

}
///通过混入TickerProviderStateMin,实现tab动画切换效果
class ProjectScreenState extends BaseWidgetState<ProjectScreen>  with TickerProviderStateMixin{
  Color themeColor = ThemeUtils.currentColorTheme;
  List<ProjectTreeData> data = new List();
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    _getData();
    Application.eventBus.on<ChangeThemeEvent>().listen((event){
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //为防止内存泄漏
    _tabController.dispose();
  }

  @override
  AppBar getAppBar() {
    // TODO: implement getAppBar
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return null;
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
    showLoading();
    _getData();
  }


  Future<Null> _getData() async{

  }
}