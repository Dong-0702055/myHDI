import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../core/widgets/dialog_notice.dart';
import '../controllers/register_bloc.dart';
import '../controllers/register_state.dart';

class Register_OTP extends StatefulWidget {
  final Function(String otp) onSubmit;
  final String? errorMessage;
  final VoidCallback onResendOtp;

  const Register_OTP({
    super.key,
    required this.onSubmit,
    required this.onResendOtp,
    this.errorMessage,
  });

  static void show(
      BuildContext context,
      Function(String otp) onSubmit,
      VoidCallback onResendOtp,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<RegisterBloc>(),
        child: Register_OTP(
          onSubmit: onSubmit,
          onResendOtp: onResendOtp,
        ),
      ),
    );
  }

  @override
  State<Register_OTP> createState() => _Register_OTPState();
}

class _Register_OTPState extends State<Register_OTP> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  String get otp => controllers.map((e) => e.text).join();

  bool get isComplete => otp.length == 6;

  int _secondsRemaining = 60;
  Timer? _timer;
  bool _isExpired = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });
    _startTimer();
  }
  @override
  void dispose() {
    _timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          timer.cancel();
          setState(() {
            _isExpired = true;
            for (var c in controllers) {c.clear();}
          });
        }
      },
    );
  }
  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _submit() {
    if (!isComplete) return;
    if (_isSubmitting) return;
    setState(() {_isSubmitting = true;});
    // Dừng timer trong lúc verify OTP
    _timer?.cancel();
    widget.onSubmit(otp);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            setState(() {
              _isSubmitting = true;
            });
          }

          if (state is RegisterOtpFailure) {
            Utils.hideLoading(context);
            DialogNotice1.show(
              context,
              title: state.error,
              text: "",
              image: "assets/image/error.png",
              textbutton: "Đóng",
              onpress: (){
                Navigator.pop(context);
              },
            );
            setState(() {
              _isSubmitting = false;
            });
            if(!_isExpired){
              _startTimer();
            }
          }

          if (state is RegisterSuccess) {
            setState(() {
              _isSubmitting = false;
            });

            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/login");
          }
      },
      builder: (context, state) {
        String? error;
        if (state is RegisterOtpFailure) {
          error = state.error;
        }
        return Container(
          height: 400,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Nhập mã OTP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => SizedBox(
                      width: 45,
                      child: TextField(
                        enabled: !_isExpired && !_isSubmitting,
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (error != null)
                  Text(error, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                if (!_isExpired)
                  Text("OTP hết hạn sau $_secondsRemaining giây",
                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,),
                  )
                else
                  Column(
                    children: [const Text("Mã OTP đã hết hiệu lực",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,),
                      ),
                      TextButton(onPressed: () {widget.onResendOtp();},
                        child: const Text("Gửi lại OTP"),
                      )
                    ],
                  ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (isComplete && !_isExpired && !_isSubmitting) ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB8A0B),
                    ),
                    child: _isSubmitting ? const SizedBox(width: 22, height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ) : const Text("Xác nhận OTP"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}