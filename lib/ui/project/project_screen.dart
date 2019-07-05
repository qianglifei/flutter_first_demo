import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/project_tree_model.dart';
import 'package:flutter_pageview_bottomnav/bean/projectlist_model.dart';
import 'package:flutter_pageview_bottomnav/common/application.dart';
import 'package:flutter_pageview_bottomnav/event/ChangeThemeEvent.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_pageview_bottomnav/utils/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    _tabController = new TabController(
        length: data.length,
        vsync: this
    );
    // TODO: implement getContentWidget
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: themeColor,
            height: 48,
            child: TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16),
                controller: _tabController,
                unselectedLabelStyle: TextStyle(fontSize: 14),
                //遍历集合中每一个元素，并做处理，返回一个新的Iterable
                tabs: data.map((ProjectTreeData item){
                    return Tab(text: item.name);
                }).toList(),
                isScrollable: true,
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: data.map((item){
                    return ProjectList(item.id);
                  }).toList()
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
    CommonService().getProjectTree((ProjectTreeModel _projectTreeModel){
        if(_projectTreeModel.errorCode == 0){
          //有数据
          if(_projectTreeModel.data.length > 0){
            showContent();
            //更新UI
            setState(() {
              data = _projectTreeModel.data;
            });
          }else{
            //数据为空
            showEmpty();
          }
        }else{
          Fluttertoast.showToast(msg: _projectTreeModel.errorMsg);
        }
    }, (DioError dioErr){
      //请求发生错误
      print(dioErr.response);
      showError();
    });
  }
}

class ProjectList extends StatefulWidget {
  final int id;
  ProjectList(this.id);

  @override
  _ProjectListState createState() {
    // TODO: implement createState
      return _ProjectListState();
  }
}

class _ProjectListState  extends State<ProjectList>{
  List<ProjectTreeListDatas> _datas = new List();
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  //是否显示“返回顶部按钮”
  bool showToTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();

    _scrollController.addListener((){
      //这个是固定写法，请勿更改！意思是监控底部的上拉动作；
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMore();
      }
    });

    _scrollController.addListener((){
      //当前位置是否超过屏幕的高度
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _renderRow,
              physics: new AlwaysScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context,int index){
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              itemCount: _datas.length + 1,
              controller: _scrollController,
          ),
          onRefresh: _getData
      ),
    );
  }

  Future<Null> _getData() async{
    _page = 1;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel _projectTreeListModel){
      setState(() {
        _datas = _projectTreeListModel.data.datas;
      });
    }, _page, _id);
  }

  Future<Null> _getMore() async{
    _page++;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel _projectTreeListModel){
      setState(() {
        _datas.addAll(_projectTreeListModel.data.datas);
      });
    }, _page, _id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //防止内存泄漏
    _scrollController.dispose();
  }

  Widget _renderRow(BuildContext context, int index) {
    if(index < _datas.length){
      return new InkWell(
        onTap: (){

        },
        child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  _datas[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3D445F)
                                  ),
                                  textAlign: TextAlign.left,
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  _datas[index].desc,
                                  style: TextStyle(fontSize: 12,color: Colors.grey),
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              _datas[index].author,
                              style: TextStyle(fontSize: 12,color: Colors.grey),
                            ),
                            Text(
                              _datas[index].niceDate,
                              style: TextStyle(fontSize: 12,color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Image.network(
                  _datas[index].envelopePic,
                  width: 80,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),

        ),

      );
    }
  }
}