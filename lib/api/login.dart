import 'package:shop/constants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/user.dart';

Future<UserInfo> loginApi(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.lOGIN, data: data),
  );
}

Future<UserInfo> getUserProfileApi() async {
  return UserInfo.fromJSON(
    await dioRequest.get(HttpConstants.USER_PROFILE),
  );
}
