import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/base/base_widget.dart';
import 'package:flutter_pageview_bottomnav/bean/systemtree_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_pageview_bottomnav/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KnowledgeScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return KnowledgeScreenState();
  }

}

class KnowledgeScreenState extends BaseWidgetState<KnowledgeScreen>{
  List<SystemTreeData> _datas = new List();
  //listview控制器
  ScrollController _scrollController = ScrollController();
  //是否显示“返回到顶部”按钮
  bool showToTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAppBarVisible(false);
    //获取网络数据
    _getData();

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
          onRefresh: _getData,
          child: ListView.separated(
              itemBuilder: _renderRow,
              //总是可以滚动
              physics: new AlwaysScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context,int index){
                return Container(
                  height: .5,
                  color: Colors.black26,
                );
              },
              itemCount: _datas.length,
              controller: _scrollController,
          ),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: (){
            //返回到顶部时执行动画
            _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
          }
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
     CommonService().getSystemTree((SystemTreeModel _systemTreeModel){
       if(_systemTreeModel.errorCode == 0){
         //成功
         if(_systemTreeModel.data.length > 0){
           //有数据
           showContent();
           setState(() {
             _datas.clear();
             _datas.addAll(_systemTreeModel.data);
           });
         }else{
           //数据为空
           showEmpty();
         }
       }else{
         Fluttertoast.showToast(msg: _systemTreeModel.errorMsg);
       }
     }, (DioError error){
       //发生错误
       print(error.response);
       showError();
     });
  }

  Widget _renderRow(BuildContext context, int index) {
    if(index < _datas.length){
       return InkWell(
         onTap: (){
              Fluttertoast.showToast(msg: index.toString());
         },
         child: Container(
           color: Colors.white,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Expanded(
                   child: Container(
                     padding: EdgeInsets.all(16),
                     color: Colors.white,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           alignment: Alignment.centerLeft,
                           padding: EdgeInsets.only(bottom: 8),
                           child: Text(
                             _datas[index].name,
                             style: TextStyle(
                               fontSize: 16,
                               color: Color(0xFF3D4E5F),
                               fontWeight: FontWeight.bold
                             ),
                             textAlign: TextAlign.left,
                           ),
                         ),
                         Container(
                           alignment: Alignment.centerLeft,
                           child: buildChildren(_datas[index].children),
                         ),
                       ],
                     )
                   )
               ),
               Icon(Icons.chevron_right)
             ],
           ),
         ),
       );
    }
    return null;
  }

  Widget buildChildren(List<SystemTreeChild> children) {
    //先建一个数组用于存放循环生成的widget
    List<Widget> tiles = [];
    //单独一个Widget组件，用于返回需要生成的内容widget
    Widget content;
    for(var item in children){
      tiles.add(
          //chip 组件一般用于标签
          new Chip(
          label: new Text(item.name),
          //设置为MaterialTapTargetSize.shrinkWrap时，clip距顶部距离为0；设置为MaterialTapTargetSize.padded时距顶部有一个距离
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Utils.getChipBgColor(item.name),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}