import 'package:flutter/material.dart';
import 'dart:async';
import 'resetpassword.dart';
import 'package:flutter/services.dart';
class OtpVerificationSheet extends StatefulWidget {
  const OtpVerificationSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const OtpVerificationSheet(),
    );
  }

  @override
  State<OtpVerificationSheet> createState() => _OtpVerificationSheetState();
}

class _OtpVerificationSheetState extends State<OtpVerificationSheet> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  bool _isOtpComplete = false;

  int _start = 30;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() { _start--; });
      }
    });
  }
  void _checkOtpStatus() {
    bool complete = true;
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        complete = false;
        break;
      }
    }
    setState(() {
      _isOtpComplete = complete;
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) { c.dispose(); }
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
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text("Nhập mã xác thực", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Mã xác thực đã được gửi đến Quý khách theo số điện thoại đăng ký",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => _buildOtpBox(index)),
                ),
                const SizedBox(height: 15),
                Text("00:${_start.toString().padLeft(2, '0')}s", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                if (_isOtpComplete)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Đóng sheet OTP
                        ResetPasswordSheet.show(context);
                        print("Xác nhận OTP thành công, mở trang đổi mật khẩu");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBB8A0B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Xác nhận & Đổi mật khẩu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Không nhận được mã? "),
                    GestureDetector(
                      onTap: _start == 0 ? () { setState(() { _start = 30; startTimer(); }); } : null,
                      child: Text(
                        "Gửi lại mã xác thực",
                        style: TextStyle(
                          color: _start == 0 ? const Color(0xFFBB8A0B) : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: _controllers[index],
        autofocus: index == 0,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFBB8A0B), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFBB8A0B), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
          _checkOtpStatus();
        },
      ),
    );
  }
}