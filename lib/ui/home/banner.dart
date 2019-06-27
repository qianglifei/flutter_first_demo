import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/bean/banner_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';

class BannerWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BannerWidgetState();
  }

}

class BannerWidgetState extends State<BannerWidget>{
  List<BannerData> _bannerList = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerList.add(null);
    _getBanner();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return ;
  }

  Future<Null> _getBanner() {
    CommonService().getBannerList((BannerModel _bannerModel){
      if(_bannerModel.data.length > 0){
        setState(() {
          _bannerList = _bannerModel.data;
        });
      }
    });
  }
}