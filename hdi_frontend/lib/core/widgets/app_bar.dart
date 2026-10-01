import 'package:flutter/material.dart';
import '../../app/theme/app_color.dart';
import '../../app/theme/app_theme.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? duongDan;

  const AppBarHome(
      this.text, {
        this.duongDan,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDark, child) {
        return AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark ? AppColor.appBarColorDark : AppColor.appBarColorLight,
                stops: const [0.0, 0.95],
              ),
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (duongDan != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => duongDan!,
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}