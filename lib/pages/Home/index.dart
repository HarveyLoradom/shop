import 'package:flutter/material.dart';
import 'package:shop/components/Home/HmCategory.dart';
import 'package:shop/components/Home/HmHot.dart';
import 'package:shop/components/Home/HmMoreList.dart';
import 'package:shop/components/Home/HmSlider.dart';
import 'package:shop/components/Home/HmSuggestion.dart';
import 'package:shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<BannerItem> _bannerList=[
    BannerItem(id: "1", imgUrl: "https://picsum.photos/id/1047/1000/400"),
    BannerItem(id: "2", imgUrl: "https://picsum.photos/id/1076/1000/400"),
    BannerItem(id: "3", imgUrl: "https://picsum.photos/id/1081/1000/400"),
  ];

  List<Widget> _getScrollChildren(){
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList,)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: 
        Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children:[
            Expanded(child:Hmhot()),
            SizedBox(width:10),
            Expanded(child:Hmhot()),
            ]
        ),
      ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren(),);
  }


}