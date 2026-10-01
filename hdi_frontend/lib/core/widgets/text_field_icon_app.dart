import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldIcon extends StatelessWidget {
  final String hintText;
  final IconData icon;

  TextFieldIcon(this.hintText, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ]
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
              )

          ),
        ),
      ),
    );
  }

}
