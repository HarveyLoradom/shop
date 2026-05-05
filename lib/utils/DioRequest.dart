
import 'package:dio/dio.dart';
import 'package:shop/constants/index.dart';
import 'package:shop/stores/TokenManager.dart';

class Diorequest {
  final _dio = Dio();
  Diorequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }

  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handle) {
          // 每次请求都添加token
          if (tokenManager.getToken().isNotEmpty) {
            request.headers={
              "Authorization": "Bearer ${tokenManager.getToken()}",
            };
          }
          handle.next(request);
        },
        onResponse: (response, handle) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handle.next(response);
            return;
          }
          handle.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handle) {
          handle.reject(DioException(requestOptions: error.requestOptions, message: error.response?.data?["msg"]));
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        return data["result"];
      }
      throw DioException(requestOptions: res.requestOptions, message: data["msg"] ?? "加载数据失败");
    } catch (e) {
      rethrow;
    }
  }
}



final dioRequest = Diorequest();
