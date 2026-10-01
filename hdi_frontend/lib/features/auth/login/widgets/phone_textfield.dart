import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget{
  final TextEditingController controller;

  const PhoneTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      validator: (value) {

        if (value == null || value.trim().isEmpty) {
          return "Vui lòng nhập số điện thoại";
        }

        return null;
      },
      decoration: InputDecoration(
          hintText: "Số điện thoại",
          prefixIcon: const Icon(Icons.phone),
          hintStyle: TextStyle(
              fontSize: 17, color: Colors.black.withOpacity(0.3)
          ),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
          )
      ),
    );
  }

}