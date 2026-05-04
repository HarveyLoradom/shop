import 'package:shop/constants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

Future<List<CategoryItem>> getCategoryListApi() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
} 

Future<SpecialRecommendItem> getProductListApi() async {
  return SpecialRecommendItem.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_LIST));
}

Future<SpecialRecommendItem> getInVogueListApi() async {
  return SpecialRecommendItem.formJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST));
}

Future<SpecialRecommendItem> getOneStopListApi() async {
  return SpecialRecommendItem.formJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST));
}

Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}