import 'package:flutter/material.dart';
import 'dio_manager.dart';
import 'api.dart';

class CommonService{
  void getArticleList(Function callBack,Function errorCallBack, int _page){
    DioManager.
    singleton.
    dio.
    get(Api.HOME_ARTICLE_LIST + "$_page/json" , options: _getOptions()).
    then((response){
     // callBack(BannerModel(response.data));
    });
  }

  Options _getOptions(){
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers:map);
  }
}