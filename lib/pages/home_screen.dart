import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/article_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';

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
    return HomeScreenState();
  }

}

class HomeScreenState extends BaseWidgetState<HomeScreen> {
  List<Article> _data = new List();
  //listview控制器
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; // 是否显示"返回到顶部"按钮
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    //获取网络数据
    ///getData();
    _scrollController.addListener((){
       //滑到了底部，加载更多
       if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
          _getMore();
       }

       //当前位置是否超过屏幕高度
       if(_scrollController.offset < 200 && showToTopBtn){
         setState(() {
           showToTopBtn = false;
         });
       }else if(_scrollController.offset >= 200 && showToTopBtn){
         setState(() {
           showToTopBtn = true;
         });
       }
    });
  }

  //获取文章列表数据
  Future<Null> getData() async{
    _page = 0;
    CommonService.
  }


  @override
  AppBar getAppBar() {
    // TODO: implement getAppBar
    return AppBar(
      title: Text('不显示'),
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
  }

}