import 'package:dio/dio.dart';
import 'package:flutter_pageview_bottomnav/bean/article_model.dart';
import 'package:flutter_pageview_bottomnav/bean/banner_model.dart';
import 'package:flutter_pageview_bottomnav/bean/systemtree_model.dart';
import 'package:flutter_pageview_bottomnav/bean/user_model.dart';
import 'package:flutter_pageview_bottomnav/bean/wx_article_content_model.dart';
import 'package:flutter_pageview_bottomnav/bean/wx_article_title_model.dart';
import 'dio_manager.dart';
import 'api.dart';
import 'package:flutter_pageview_bottomnav/common/user.dart';

class CommonService{
  Dio dio  = DioManager.singleton.dio;
  ///获取Banner数据
  void getBannerList(Function callBack){
    dio.get(Api.HOME_BANNER,options: _getOptions()).
    then((response){
      callBack(BannerModel(response.data));
    });
  }
  ///获取文章列表
  void getArticleList(Function callBack,Function errorCallBack, int _page){
    dio.get(Api.HOME_ARTICLE_LIST + "$_page/json" , options: _getOptions()).
    then((response){
      print(response.data.toString());
       callBack(ArticleBean(response.data));
    }).catchError((e){
      errorCallBack(e);
    });
  }
  ///登录
  void login(Function callback,String _username,String _password) async{
      FormData formData = new FormData.from({"username":_username,"password":_password});
      dio.post(Api.USER_LOGIN,data:formData,options:_getOptions()).
      then((response) {
        print("===" + response.data.toString());
        callback(UserModel(response.data), response);
      });
  }
  ///注册
  void register(Function callback, String _username,String _password) async{
      FormData formData = new FormData.from({
          "username":_username,
          "password":_password,
          "repassword":_password
      });
      dio.post(Api.USER_REGISTER,data:formData,options:null).
      then((response){
        print(response.toString());
        callback(UserModel(response.data));
      });
  }

  ///获取知识体系列表
  void getSystemTree(Function callBack,Function errorBack) async{
    dio.get(Api.SYSTEM_TREE,options: _getOptions()).
    then((response){
      callBack(SystemTreeModel(response.data));
    }).catchError((e){
      errorBack(e);
    });
  }
  ///获取公众号名称
  void getWxList(Function callBack,Function errorBack) async{
    dio.get(Api.WX_LIST,options: _getOptions()).
    then((response){
      callBack(WxArticleTitleModel(response.data));
    }).catchError((e){
      errorBack(e);
    });
  }
  ///获取公众号文章
  void getWxArticleList(Function callBack , int _id , int _page){
    dio.get(Api.WX_ARTICLE_LIST + "$_id/$_page/json",options: _getOptions()).
    then((response){
      callBack(WxArticleContentModel(response.data));
    });
  }
  Options _getOptions(){
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers:map);
  }
}