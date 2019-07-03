import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/navi_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_pageview_bottomnav/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavigationScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return NavigationScreenState();
  }

}

class NavigationScreenState extends BaseWidgetState<NavigationScreen>{
  List<NaviData> _naviTitles = new List();
  //listview 控制器
  ScrollController _scrollController = new ScrollController();
  //是否显示返回顶部按钮
  bool showToTopBtn = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    _getData();

    _scrollController.addListener((){
      // 当前位置是否超过屏幕的高度
      if(_scrollController.offset < 200 && showToTopBtn){
        setState(() {
          showToTopBtn = false;
        });
      }else if(_scrollController.offset >= 200 && showToTopBtn == false){
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  AppBar getAppBar() {
    // TODO: implement getAppBar
    return AppBar(
      title: Text('不显示'),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //为防止内存泄漏
    _scrollController.dispose();
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _getData,
          displacement: 15,
          child: _rightListView(context),
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
    showLoading();
    _getData();
  }

  Future<Null> _getData() async{
    CommonService().getNaviList((NaviModel _naviModel){
      if(_naviModel.errorCode == 0){
        //成功
        if(_naviModel.data.length > 0){
          //有数据
          showContent();
          setState(() {
            _naviTitles = _naviModel.data;
          });
        }else{
          //数据为空
          showEmpty();
        }
      }else{
        Fluttertoast.showToast(msg: _naviModel.errorMsg);
      }
    }, (DioError e){
        //发生错误
      print(e.response);
      showError();
    });
  }

  Widget _rightListView(BuildContext context) {
    return ListView.separated(
        itemBuilder: _renderContent,
        separatorBuilder: (BuildContext context,int index){
          return Container(
            height: 0.5,
            color: Colors.black26,
          );
        },
        itemCount: _naviTitles.length,
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
    );
  }

  Widget _renderContent(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
                _naviTitles[index].name,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3D4E5F),
                ),
                textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: buildChild(_naviTitles[index].articles),
          )
        ],
      )
    );
  }

  Widget buildChild(List<NaviArticle> articles) {
    //先建立一个数组，用于存放循环生成的widget
    List<Widget> tiles = [];
    //单独一个Widget
    Widget content;

    for(NaviArticle item in articles){
      tiles.add(new InkWell(
        child: new Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Utils.getChipBgColor(item.title),
            label: new Text(item.title)
        ),
        onTap: (){

        },
      ));
    }

    content = Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: tiles,
    );

    return content;
  }
}