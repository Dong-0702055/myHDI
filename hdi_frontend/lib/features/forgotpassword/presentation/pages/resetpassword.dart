import 'package:flutter/material.dart';
import 'succesresetpassword.dart';
class ResetPasswordSheet extends StatefulWidget {
  const ResetPasswordSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ResetPasswordSheet(),
    );
  }

  @override
  State<ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends State<ResetPasswordSheet> {
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscurePass = true;
  bool _isObscureConfirm = true;
  bool _canSubmit = false;

  void _validate() {
    setState(() {
      _canSubmit = _passController.text.isNotEmpty &&
          _confirmPassController.text.isNotEmpty &&
          _passController.text == _confirmPassController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text("Đặt lại mật khẩu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vui lòng thiết lập mật khẩu mới để đăng nhập vào ứng dụng MyHDI.",
                  style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 25),
                _buildPasswordField(
                  controller: _passController,
                  hint: "Tạo mật khẩu mới *",
                  isObscure: _isObscurePass,
                  onToggle: () => setState(() => _isObscurePass = !_isObscurePass),
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  controller: _confirmPassController,
                  hint: "Xác nhận mật khẩu mới *",
                  isObscure: _isObscureConfirm,
                  onToggle: () => setState(() => _isObscureConfirm = !_isObscureConfirm),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? () {
                      Navigator.pop(context);
                      SuccessDialog.show(context);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canSubmit ? const Color(0xFFBB8A0B) : Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      "Xác nhận",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _canSubmit ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      onChanged: (_) => _validate(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key_outlined, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
          onPressed: onToggle,
        ),
        labelText: hint,
        labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        floatingLabelStyle: const TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBB8A0B)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}