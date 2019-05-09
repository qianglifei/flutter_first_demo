import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/ui/login/theme.dart' as Theme;
import 'package:flutter/painting.dart';
import 'package:flutter_pageview_bottomnav/utils/bubble_indication_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key : key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String title = "登录";
  PageController _pageController;
  Color left = Colors.black;
  Color right = Colors.white;

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(title),
//      ),
//      key: _scaffoldKey,
//      body: NotificationListener<OverscrollIndicatorNotification>(
//          onNotification: (overscoll){
//             overscoll.disallowGlow();
//          },
//          child: SingleChildScrollView(
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height >= 775.0
//                  ? MediaQuery.of(context).size.height:775.0,
//              decoration: new BoxDecoration(
//                gradient: new LinearGradient(
//                    colors: [
//                      Theme.Colors.loginGradientStart,
//                      Theme.Colors.loginGradientEnd
//                    ],
//                    begin: const FractionalOffset(0.0, 0.0),
//                    end: const FractionalOffset(1.0, 1.0),
//                    stops: [0.0,1.0],
//                    tileMode: TileMode.clamp),
//               ),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(top: 60),
//                  child: _buildMenuBar(context),
//                )
//              ],
//            ),
//          ),
//      )
//    )
//    }

  Widget _buildMenuBar(BuildContext context) {

    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0))
      ),
      child: CustomPaint(
        //painter: TabIndicationPainter(pageController:_pageController),
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
  //切换到登录
  void _onSignInButtonPress() {
    //TODO：Curves： 曲线，弯曲状  Decelerate：使减速
    _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  //切换到注册
  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

