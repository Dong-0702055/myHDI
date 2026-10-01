import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final VoidCallback? onChanged;

  const BuildTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (_) => onChanged?.call(),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
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
    );
  }
}