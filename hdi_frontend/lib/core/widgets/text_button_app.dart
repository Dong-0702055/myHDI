import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/theme/app_color.dart';

class TextButtonApp extends StatelessWidget{
  final String text;
  final VoidCallback?  onPress;
  TextButtonApp(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: AppColor.appButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
            padding: EdgeInsets.all(15)
        ),
        onPressed: onPress,
        child: Text(text,style: TextStyle(fontSize: 16,color: Colors.white))
    );
  }
}
