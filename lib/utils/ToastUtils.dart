import 'package:flutter/material.dart';

class ToastUtils {
  static bool showLoading = false;
  static void showToast(BuildContext context,String msg){
    if(showLoading){
      return;
    }
    showLoading = true;
    Future.delayed(Duration(seconds: 3),(){
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功",textAlign: TextAlign.center,),
      ),
    );
  }
}