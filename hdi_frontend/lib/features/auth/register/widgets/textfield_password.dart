import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final bool isObscure;
  final VoidCallback onToggle;
  final VoidCallback? onChanged;

  const BuildPasswordField({
    super.key,
    required this.controller,
    this.validator,
    required this.hint,
    required this.isObscure,
    required this.onToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isObscure,
        onChanged: (_) => onChanged?.call(),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
          labelText: hint,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFFBB8A0B),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFBB8A0B),
            ),
          ),
        ),
      ),
    );
  }
}