import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
    _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Slide> list = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list..add(new Slide(
      title: 'FLutter',
      description: "Flutter是谷歌移动的开发框架，可以快速在ios和Android上构建高质量的原生用户界面，Flutter"
          "可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，flutter是完全免费的，开源的。",
      styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Raleway'
      ),
      marginDescription: EdgeInsets.only(left: 20.0,top: 20.0,bottom: 70.0,right: 20.0),
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight
    ))..add(new Slide(
        title: "Wanandroid",
        description:
        "这是一款使用Flutter写的WanAndroid客户端应用，在Android和IOS都完美运行,可以用来入门Flutter，简单明了，适合初学者,项目完全开源，如果本项目确实能够帮助到你学习Flutter，谢谢start，有问题请提交Issues,我会及时回复。",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'Raleway'),
        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFFACD),
        colorEnd: Color(0xffFF6347),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    )..add(new Slide(
        title: "Welcome",
        description:
        "赠人玫瑰，手有余香；\n分享技术，传递快乐。",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'Raleway'),
        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFA500),
        colorEnd: Color(0xff7FFFD4),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
    ));

  }

  void onDonePress(){
      _setHasSkip();
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => new FirstPage()
          ),
          (route) => route == null
      );
  }

  void onSkipPress(){
      _setHasSkip();
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => new FirstPage()
          ),
          (route) => route == null
      );
  }

  void _setHasSkip() async{
      SharedPreferences pres = await SharedPreferences.getInstance();
      await pres.setBool("hasSkip", true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroSlider(
        slides: list,
        onDonePress: onDonePress,
       // onSkipPress: onSkipPress,
        nameDoneBtn: "进入",
        nameNextBtn: "下一页",
        nameSkipBtn: "跳过",
    );
  }
}



