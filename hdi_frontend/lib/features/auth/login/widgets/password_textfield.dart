import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty)
          { return "Vui lòng nhập mật khẩu"; }
          return null;
        },
      obscureText: _isObscure,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: "Mật khẩu",
        prefixIcon: const Icon(Icons.lock_outline),

        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),

        filled: true,

        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.black.withOpacity(0.3),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}