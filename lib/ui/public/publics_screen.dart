import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/wx_article_content_model.dart';
import 'package:flutter_pageview_bottomnav/bean/wx_article_title_model.dart';
import 'package:flutter_pageview_bottomnav/common/application.dart';
import 'package:flutter_pageview_bottomnav/event/ChangeThemeEvent.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_pageview_bottomnav/utils/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return PublicScreenState();
  }
}

class PublicScreenState extends BaseWidgetState<PublicScreen>  with TickerProviderStateMixin{
  TabController _tabController;
  Color themeColor = ThemeUtils.currentColorTheme;
  List<WxArticleTitleData> _datas = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    //加载网络数据
    _getData();

    Application.eventBus.on<ChangeThemeEvent>().listen((event){
        setState(() {
          themeColor = event.color;
        });
    });
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
    _tabController = new TabController(
        length: _datas.length,
        //同步
        vsync: this
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: themeColor,
            height: 48,
            child: TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                controller: _tabController,
                tabs: _datas.map((WxArticleTitleData item){
                    return Tab(text: item.name);
                }).toList(),
              isScrollable: true,
            ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _datas.map((item){
                  return NewsList(item.id);
                }).toList(),
              )
          )
        ],
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
    CommonService().getWxList((WxArticleTitleModel _articleTileModel){
      if(_articleTileModel.errorCode == 0){
        //成功
        if(_articleTileModel.data.length > 0){
          //有数据
          showContent();
          setState(() {
            _datas = _articleTileModel.data;
          });
        }else{
          //数据为空
          showEmpty();
        }
      }else{
        Fluttertoast.showToast(msg: _articleTileModel.errorMsg);
      }
    }, (DioError error){
      //发生错误
      print(error.response);
      showError();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}

class NewsList extends StatefulWidget{
  final int id;
  NewsList(this.id);

  @override
  _NewsListState createState() {
    // TODO: implement createState
    return _NewsListState();
  }

}

class _NewsListState  extends State<NewsList>{
  List<WxArticleContentDatas> _datas = new List();
  ScrollController _scrollController = new ScrollController();
  int _page = 1;
  //是否显示返回到顶部的按钮
  bool showToTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();

    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMore();
      }
    });

    _scrollController.addListener((){
      //当前位置是否超过屏幕高度
      if(_scrollController.offset < 200 && showToTopBtn){
         setState(() {
           showToTopBtn = false;
         });
      }else if(_scrollController.offset >= 200 && showToTopBtn == false){
        setState(() {
          setState(() {
            showToTopBtn = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _renderRow,
              separatorBuilder: (BuildContext context,int index){
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              itemCount: _datas.length
          ),
          onRefresh: _getData,
      ),
    );
  }

  Future<Null> _getMore() async{
    _page = 1;
    int _id = widget.id;
    CommonService().getWxArticleList((WxArticleContentModel _wxArticleContentModel){
      setState(() {
        _datas = _wxArticleContentModel.data.datas;
      });
    }, _id,_page);
  }

  Future<Null> _getData() async{
    _page++;
    int _id = widget.id;
    CommonService().getWxArticleList((WxArticleContentModel _wxArticleContentModel){
      setState(() {
        _datas.addAll(_wxArticleContentModel.data.datas);
      });
    }, _id, _page);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Widget _renderRow(BuildContext context, int index) {
    if(index < _datas.length){
       return new InkWell(
         onTap: (){

         },
         child: Column(
           children: <Widget>[
             Container(
               color: Colors.cyan,
               padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
               child: Row(
                 children: <Widget>[
                   Text(
                     _datas[index].author,
                     style: TextStyle(fontSize: 12),
                     textAlign: TextAlign.left,
                   ),
                   Expanded(
                       child: Text(
                         _datas[index].niceDate,
                         style: TextStyle(fontSize: 12),
                         textAlign: TextAlign.right,
                       )
                   )
                 ],
               ),
             ),
             Container(
               color: Colors.orange,
               padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
               child: Row(
                 children: <Widget>[
                   Expanded(
                       child: Text(
                         _datas[index].title,
                         maxLines: 2,
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                           color: const Color(0xFF3D4E5F)
                         ),
                         textAlign: TextAlign.left,
                       )
                   )
                 ],
               ),
             ),
             Container(
               color: Colors.red,
               padding: EdgeInsets.all(16),
               child: Row(
                 children: <Widget>[
                   Expanded(
                       child: Text(
                         _datas[index].superChapterName,
                         style: TextStyle(fontSize: 12),
                         textAlign: TextAlign.left,
                       )
                   ),
                   Text(
                     "qwewqe",
                     textAlign: TextAlign.start,
                     style: TextStyle(fontSize: 12),
                   )
                 ],
               ),
             )
           ],
         ),
       );
    }
    return null;
  }
}