
import 'package:shop/constants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGuessListApi(Map<String, dynamic> params) async {
  return GoodsDetailItems.formJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST,params: params),
  );

}