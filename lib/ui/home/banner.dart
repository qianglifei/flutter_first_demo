import 'package:flutter/material.dart';
import 'package:flutter_pageview_bottomnav/bean/banner_model.dart';
import 'package:flutter_pageview_bottomnav/http/common_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
    return Swiper(
       itemBuilder: (BuildContext context,int index){
         if(_bannerList[index] == null || _bannerList[index].imagePath == null){
            return new Container(
              color: Colors.grey[100],
            );
         }else{
            return buildItemImageWidget(context,index);
         }
       },
      itemCount: _bannerList.length,
      autoplay: true,
      //默认指示器
      pagination: new SwiperPagination(),
    );
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

  Widget buildItemImageWidget(BuildContext context, int index) {
    //点击有水波纹效果
    return new InkWell(
      onTap: (){
        //
      },
      child: new Container(
        child: new Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

