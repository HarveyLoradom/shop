
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/index.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();
  }
  String _token = "";
  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }
  Future<void> setToken(String token) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }
  String getToken()  {
    return _token;
  }
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();