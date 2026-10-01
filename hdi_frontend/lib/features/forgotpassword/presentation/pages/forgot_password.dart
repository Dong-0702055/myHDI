import 'package:flutter/material.dart';
import 'forgot_password_otp.dart';
import 'package:flutter/services.dart';
class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ForgotPasswordSheet(),
    );
  }

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isHasContent = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        _isHasContent = _phoneController.text.length==10||_phoneController.text.length==11;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text("Quên mật khẩu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vui lòng nhập số điện thoại chúng tôi sẽ gửi mã xác thực vào số điện thoại này.",
                  style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                        Icons.phone_android_outlined, color: Colors.grey),
                    labelText: "Số điện thoại",
                    labelStyle: const TextStyle(color: Colors.grey),
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xFFBB8A0B)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFBB8A0B)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isHasContent ? () {
                      Navigator.pop(context);
                      OtpVerificationSheet.show(context);
                      print("Gửi mã đến: ${_phoneController.text}");
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isHasContent ? const Color(0xFFBB8A0B) : Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                        "Gửi mã xác thực",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _isHasContent ? Colors.white : Colors.grey[500],
                        )
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
}