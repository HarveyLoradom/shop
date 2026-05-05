import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/api/login.dart';
import 'package:shop/pages/Cart/index.dart';
import 'package:shop/pages/Category/index.dart';
import 'package:shop/pages/Home/index.dart';
import 'package:shop/pages/Mine/index.dart';
import 'package:shop/stores/TokenManager.dart';
import 'package:shop/stores/UserController.dart';
import 'package:shop/viewmodels/user.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];

  int _currentIndex = 0;
  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  final UserController _userController = Get.put(UserController());
  initState() {
    super.initState();
    // 初始化用户信息
    _initUser();
  }

  _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      _userController.updateUserInfo(await getUserProfileApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }
}
