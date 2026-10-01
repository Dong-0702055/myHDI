import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showLoading(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator())
    );
  }
  static void hideLoading(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
  static void showSnackBarError(BuildContext context, String message){
    ScaffoldMessenger.of(
        context
    ).showSnackBar(SnackBar(content: Text(message,style: TextStyle(color: Colors.red))));
  }
}