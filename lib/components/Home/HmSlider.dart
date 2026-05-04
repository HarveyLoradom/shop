import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key,required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {

  Widget _getSlider(){
    final double screenWidth=MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index){
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
          );
    }), 
      options: CarouselOptions(
        height: 300,
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 1,
        autoPlay: true
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getSlider()
      ],
    );
  }
}