import 'package:flutter/material.dart';
import 'package:shop/api/home.dart';
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
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendItem _productList = SpecialRecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendItem _inVogueList = SpecialRecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendItem _oneStopList = SpecialRecommendItem(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendList = [];

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion(productList: _productList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueList, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopList, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  void _getInVogueList() async {
    _inVogueList = await getInVogueListApi();
    setState(() {});
  }

  void _getOneStopList() async {
    _oneStopList = await getOneStopListApi();
    setState(() {});
  }

  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }

  void _getBannerList() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  void _getProductList() async {
    _productList = await getProductListApi();
    setState(() {});
  }

  void _getCategoryList() async {
    _categoryList = await getCategoryListApi();
    setState(() {});
  }
}
