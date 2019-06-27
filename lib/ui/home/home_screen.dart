import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/article_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return HomeScreenState();
  }

}

class HomeScreenState extends BaseWidgetState<HomeScreen> {
  List<Article> _datas = new List();
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
    getData();
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
      body: RefreshIndicator(
          onRefresh: getData,
          //创建一个自定义子模型的ListView
          //创建一个自带分割的ListView,这个分割可以帮助我们实现分割线的效果，
          //它除了要传入itemBuilder之外，还需要传入一个SeparatorBuilder,
          //也就是分割线
          child: ListView.separated(
              itemBuilder: _renderRow,
              //分割线
              separatorBuilder: (BuildContext context,int index){
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              //包含轮播图和加载更多
              itemCount: _datas.length + 2,
          ),
      )
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
    showLoading();
    getData();
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

    }, _page);
  }


  Widget _renderRow(BuildContext context, int index) {
//    if(index == 0){
//        return Container(
//          height: 200,
//          color: Colors.green,
//          child: new BannerWidget(),
//        );
//    }
  }
}