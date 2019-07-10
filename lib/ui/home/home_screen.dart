import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/article_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'banner.dart';

class HomeScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return HomeScreenState();
  }

}

class HomeScreenState extends BaseWidgetState<HomeScreen>{
  List<Article> _datas = new List();
  //listview控制器
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; // 是否显示"返回到顶部"按钮
  int _page = 0;
  //添加数据
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    //获取网络数据
    //_easyRefreshKey.currentState.callRefresh();
    _getData();
    _scrollController.addListener((){
       //滑到了底部，加载更多
//       if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
//          _getMore();
//       }

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
  Future<Null> _getData() async{
    _page = 0;
    CommonService().getArticleList((ArticleBean _articleBean){
        if(_articleBean.errorCode == 0){
          //成功
          if(_articleBean.data.datas.length > 0){
              //有数据
              showContent();
              setState(() {
                _datas.clear();
                _datas.addAll(_articleBean.data.datas);
              });
          }else{
            //数据为空
            showEmpty();
          }
        }else{
          Fluttertoast.showToast(msg: _articleBean.errorMsg);
        }
    },(DioError error){
        //发生错误
        print(error.response);
        setState(() {
          showError();
        });
    }, _page);
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
    return Scaffold(
        body: new EasyRefresh(
            key: _easyRefreshKey,
            child: ListView.separated(
              itemBuilder: _renderRow,
              //设置physics属性总是可滚动
              physics: new AlwaysScrollableScrollPhysics(),
              //分割线
              separatorBuilder: (BuildContext context,int index){
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              //包含轮播图和加载更多
              itemCount: _datas.length + 2,
              controller: _scrollController,
          ),
          onRefresh: () async{
              _getData();
          },
          loadMore: () async{
              _getMore();
          },
        ),
//      body: RefreshIndicator(
//          onRefresh: getData,
//          displacement: 15,
//          //创建一个自定义子模型的ListView
//          //创建一个自带分割的ListView,这个分割可以帮助我们实现分割线的效果，
//          //它除了要传入itemBuilder之外，还需要传入一个SeparatorBuilder,
//          //也就是分割线
//          child: ListView.separated(
//              itemBuilder: _renderRow,
//              //设置physics属性总是可滚动
//              physics: new AlwaysScrollableScrollPhysics(),
//              //分割线
//              separatorBuilder: (BuildContext context,int index){
//                return Container(
//                  height: 0.5,
//                  color: Colors.black26,
//                );
//              },
//              //包含轮播图和加载更多
//              itemCount: _datas.length + 2,
//              controller: _scrollController,
//          ),
//      ),
//      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
//          onPressed: (){
//            _scrollController.animateTo(.0, duration: Duration(milliseconds: 20), curve: Curves.ease);
//          },
//          child: Icon(Icons.arrow_upward),
//      ),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
    showLoading();
    _getData();
  }
  //加载更多的数据
  Future<Null> _getMore() async{
    _page++;
    CommonService().getArticleList((ArticleBean _articleBean){
        if(_articleBean.errorCode == 0){
          //成功
          if(_articleBean.data.datas.length > 0){
             //有数据
            showContent();
            setState(() {
              _datas.addAll(_articleBean.data.datas);
            });
          }else{
            //数据为空
            Fluttertoast.showToast(msg: "没有更多数据了");
          }
        }else{
          Fluttertoast.showToast(msg: _articleBean.errorMsg);
        }
    }, (DioError error){
      //发生错误
      print(error.response);
      setState(() {
        showError();
      });
    }, _page);
  }


  Widget _renderRow(BuildContext context, int index) {
    if(index == 0){
        return Container(
          height: 200,
          color: Colors.green,
          child: new BannerWidget(),
        );
    }
    if(index < _datas.length - 1){
      return new InkWell(
         onTap: (){
             
         },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Text(_datas[index - 1].author,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.left,
                  ),
                  Expanded(
                      child: Text(
                        _datas[index - 1].niceDate,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.right,
                      )
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  ///这是个用来让子项具有伸缩能力的Widget，父类是Flexible，
                  ///俩个组件的构造函数是区别不大，灵活系数flex 1，一样，fit参数不一样
                  ///Expanded 默认是占满分配空间，而Flexible则默认不需要
                  Expanded(
                    child:Text(
                      _datas[index - 1].title,
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
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        _datas[index - 1].superChapterName,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.left,
                      )
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

  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

}