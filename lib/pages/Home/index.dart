import 'package:flutter/material.dart';
import 'package:shop/api/home.dart';
import 'package:shop/components/Home/HmCategory.dart';
import 'package:shop/components/Home/HmHot.dart';
import 'package:shop/components/Home/HmMoreList.dart';
import 'package:shop/components/Home/HmSlider.dart';
import 'package:shop/components/Home/HmSuggestion.dart';
import 'package:shop/utils/ToastUtils.dart';
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
      HmMoreList(recommendList: _recommendList),
    ];
  }

  @override
  void initState() {
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
      _paddingTop = 0;
      setState(() {});
    });
  }

  Future<void> _registerEvent() async {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        _getRecommendList();
      }
    });
  }

  Future<void> _getInVogueList() async {
    _inVogueList = await getInVogueListApi();
  }

  Future<void> _getOneStopList() async {
    _oneStopList = await getOneStopListApi();
  }

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
    }
    _page++;
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerListApi();
  }

  Future<void> _getProductList() async {
    _productList = await getProductListApi();
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListApi();
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    await _registerEvent();
    ToastUtils.showToast(context, "刷新成功");
  }

  double _paddingTop = 0;
  final ScrollController _controller = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
