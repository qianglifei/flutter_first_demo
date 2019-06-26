import 'package:dio/dio.dart';
import 'package:flutter_pageview_bottomnav/bean/user_model.dart';
import 'dio_manager.dart';
import 'api.dart';
import 'package:flutter_pageview_bottomnav/common/user.dart';

class CommonService{
  Dio dio  = DioManager.singleton.dio;
  void getArticleList(Function callBack,Function errorCallBack, int _page){
    dio.get(Api.HOME_ARTICLE_LIST + "$_page/json" , options: _getOptions()).
    then((response){
       //callBack(Artic)
    }).catchError((e){
      errorCallBack(e);
    });
  }
  ///登录
  void login(Function callback,String _username,String _password) async{
      FormData formData = new FormData.from({"username":_username,"password":_password});
      dio.post(Api.USER_LOGIN,data:formData,options:_getOptions()).
      then((response) {
        print(response.data.toString());
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

  Options _getOptions(){
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers:map);
  }
}