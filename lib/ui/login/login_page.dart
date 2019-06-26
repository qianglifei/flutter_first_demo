import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pageview_bottomnav/bean/user_model.dart';
import 'package:flutter_pageview_bottomnav/common/application.dart';
import 'package:flutter_pageview_bottomnav/common/user.dart';
import 'package:flutter_pageview_bottomnav/event/login_event.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_pageview_bottomnav/ui/login/theme.dart' as Theme;
import 'package:flutter/painting.dart';
import 'package:flutter_pageview_bottomnav/utils/bubble_indication_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key : key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}
  ///利用Row，Column沿水平方向或者垂直方向排列子布局
  ///利用Stack实现布局层叠，利用Positioned控件实现绝对定位
  ///利用Container实现装饰效果
  ///利用TextFormField实现文本输入，利用Form来管理这些TextFormField
  ///利用Key来获取widget的状态
  ///利用InheritedWidget可以把数据传递给子控件
  ///利用PageView和PageController实现页面滑动切换
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();


  String title = "登录";
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll){
             overScroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height:775.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.loginGradientStart,
                      Theme.Colors.loginGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp),
               ),
            child: Column(
//            关键属性
//
//            key: 该属性代表当前widget的唯一标识符(类似于Android中的id)，在程序运行过程中，如果想调用该widget的某个方法，那就需要设置该属性值，该属性不是必须值
//            mainAxisAlignment: 子元素在主轴的对齐方式，Column的主轴即为垂直方向
//            mainAxisSize: 主轴方向大小适配方式，只有两种取值方式：
//            MainAxisSize.max 主轴方向大小(在Column中指高度)与父容器大小相同(即Android中的match_parent)
//            MainAxisSize.min 主轴方向大小(在Column中指高度)由子元素决定(即Android中的wrap_content)
//            crossAxisAlignment: 子元素在交叉轴(水平方向)的对齐方式
//            children: 子元素列表
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                      flex: 1,
                      child: PageView(
                      controller: _pageController,
                      onPageChanged: (i){
                        if(i == 0){
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                            title = "登录";
                          });
                        }else if(i == 1){
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                            title = "注册";
                          });
                        }
                      },
                      children: <Widget>[
                          ///登录
                          new ConstrainedBox( // 创建一个约束盒子
                            constraints: const BoxConstraints.expand(), //约束条件，约束规则，将会让组件使用无限制（所有可用）的空间，除非另有指定：
                            child: _buildSignIn(context)
                          ),
                          ///注册
                          new ConstrainedBox(
                              constraints: const BoxConstraints.expand(),// 约束条件，让内部的空间无线使用
                              child: _buildSignUp(context),
                          )
                      ],
                  )
                )
              ],
            ),

          ),
      )
    ));
  }

  Widget _buildMenuBar(BuildContext context) {

    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),

      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController:_pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onSignInButtonPress,
                  child: Text(
                    "登录",
                    style: TextStyle(color: left,fontSize: 16.0),
                  )
              ),
            ),
            Expanded(
                child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: _onSignUpButtonPress,
                    child: Text(
                      "注册",
                      style: TextStyle(
                        color: right,
                        fontSize: 16.0
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }
  //切换到登录
  void _onSignInButtonPress() {
    //TODO：Curves： 曲线，弯曲状  Decelerate：使减速
    _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  //切换到注册
  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  Widget _buildSignIn(BuildContext context) {
    //登录
    Future<Null> _login() async {
      String username = loginEmailController.text;
      print(username);
      String password = loginPasswordController.text;
      if ((null != username && username.trim().length > 0) &&
          (null != password && password.trim().length > 0)) {
        CommonService().login((UserModel _userModel, Response response) {
          if (_userModel != null) {
            User().saveUserInfo(_userModel, response);
            Application.eventBus.fire(new LoginEvent());
            if (_userModel.errorCode == 0) {
              Fluttertoast.showToast(msg: "登录成功！");
              Navigator.of(context).pop();
            } else {
              Fluttertoast.showToast(msg: _userModel.errorMsg);
            }
          }
        }, username, password);
      } else {
        Fluttertoast.showToast(
          msg: "用户名或者密码不能为空",
        );
      }
    }
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible, //溢出，充满
            children: <Widget>[
              Card(
                elevation: 5.0,
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 150.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          //焦点控制，不设置 TextField默认创建一个自己的focusNode，
                          // 通常用于的情况是填写表单的时候，一个输入框填写完成，
                          // 直接控制焦点到下一个输入框，而不是通过点击下一个输入框获取焦点
                          focusNode: myFocusNodeEmailLogin,
                          //controller添加通知来获取TextField的值，这种使用场景不一定合适，
                          //更多的时候是在点击按钮的时候直接读取controller.text的值
                          //控制器，控制文本框中的文字
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                              size: 18.0,
                            ),
                            hintText: "用户名",
                            hintStyle: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          //模糊文本，文本是否隐藏，默认false ，true：密码框
                          obscureText: _obscureTextLogin,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.eye,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "密码",
                            hintStyle: TextStyle(fontSize: 17.0),
                            //后缀图标
                            suffixIcon: GestureDetector(
                              onTap:(){
                                _toggleLogin();
                              },
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 240.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    //阴影效果
                    BoxShadow(
                      //阴影默认颜色，不能与父容器同时设置color
                      color: Colors.cyan,
                      //延伸的阴影，向右下偏移的距离
                      offset: Offset(1.0, 6.0),
                      //延伸距离，会有模糊效果
                      blurRadius: 20.0,
                    ),
                    //阴影效果
                    BoxShadow(
                      //阴影默认颜色，不能与父容器同时设置color
                      color: Colors.deepOrange,
                      //延伸的阴影，向右下偏移的距离
                      offset: Offset(1.0, 6.0),
                      //延伸距离，会有模糊效果
                      blurRadius: 20.0,
                    ),
                    //阴影效果
                    BoxShadow(
                      //阴影默认颜色，不能与父容器同时设置color
                      color: Colors.black,
                      //延伸的阴影，向右下偏移的距离
                      offset: Offset(1.0, 6.0),
                      //延伸距离，会有模糊效果
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xFF5394FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    color: const Color(0xFF5394FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 60.0),
                      child: Text(
                        "登录",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _login();
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    Future<Null> _regist() async {
      String username = signupNameController.text;
      String password = signupPasswordController.text;
      String rePassword = signupConfirmPasswordController.text;

      if ((null != username && username.trim().length > 0) &&
          (null != password && password.trim().length > 0) &&
          (null != rePassword && rePassword.trim().length > 0)) {
        if (password != rePassword) {
          Fluttertoast.showToast(msg: "两次密码输入不一致！");
        } else {
          CommonService().register((UserModel _userModel) {
            if (_userModel != null) {
              if (_userModel.errorCode == 0) {
                Fluttertoast.showToast(msg: "注册成功！");
              } else {
                Fluttertoast.showToast(msg: _userModel.errorMsg);
              }
            }
          }, username, password);
        }
      } else {
        Fluttertoast.showToast(
          msg: "用户名或者密码不能为空",
        );
      }
    }

    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 210.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "用户名",
                            hintStyle: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "密码",
                            hintStyle: TextStyle(fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "确认密码",
                            hintStyle: TextStyle(fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xFF5394FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    color: const Color(0xFF5394FF),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 60.0),
                      child: Text(
                        "注册",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    onPressed: () {
                      _regist();
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //登录密码安全开关
  void _toggleLogin(){
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  //注册密码安全开关
  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }
  //注册确认密码安全开关
  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}



