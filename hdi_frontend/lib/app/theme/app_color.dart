import 'dart:ui';
import 'package:flutter/cupertino.dart';

class AppColor {

  static const  Color appButtonColor =  Color(0xFFA87E23);
  static const Color iconColor =  Color(0xFF636363);
  // Chế độ màu sáng
  static const List<Color> appBarColorLight = [ Color(0xFF02FD17),Color(0xFF006C32)];
  static const  Color containerLight =  Color(0xFFFFFFFF);
  static const  Color textLight =  Color(0xFF000000);
  // static const  Color containerLight =  Color(0xFF15FF30);
  // static const  Color textLight =  Color(0xFFFB5A5A);
  // Chế độ màu tối
  static const List<Color> appBarColorDark = [ Color(0xFF1E1E1E),Color(0xFF1E1E1E)];
  static const  Color containerDark =  Color(0xFF1E1E1E);
  static const  Color textDark =  Color(0xFFFFFFFF);
  // static const  Color containerDark =  Color(0xFFFF0087);
  // static const  Color textDark =  Color(0xFF055E20);

  static final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);
}