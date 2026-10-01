import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_hdi/features/auth/register/pages/register_otp.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/dialog_notice.dart';
import '../../../forgotpassword/presentation/pages/forgot_password.dart';
import '../../login/pages/login_custom.dart';
import '../../login/pages/login_user.dart';
import '../controllers/register_bloc.dart';
import '../controllers/register_event.dart';
import '../controllers/register_state.dart';
import '../widgets/text_field.dart';
import '../widgets/textfield_password.dart';
import 'clause.dart';

  class RegisterScreen extends StatefulWidget {
    const RegisterScreen({super.key});
    static void show(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => BlocProvider(
          create: (_) => RegisterBloc(),
          child: const RegisterScreen(),
        ),
      );
    }

    @override
    State<RegisterScreen> createState() => _RegisterScreenState();
  }

  class _RegisterScreenState extends State<RegisterScreen> {
    final _phoneController = TextEditingController();
    final _nameController = TextEditingController();
    final _passController = TextEditingController();
    final _confirmPassController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _isObscurePass = true;
    bool _isObscureConfirm = true;
    bool _canRegister = false;
    String? _verificationId;

    void _validate() {
      final phone = _phoneController.text.trim();
      final name = _nameController.text.trim();
      final pass = _passController.text;
      final confirmpass = _confirmPassController.text;
      setState(() {
        _canRegister = (phone.length == 10 || phone.length == 11) &&
            name.isNotEmpty &&
            pass.isNotEmpty&&  pass == confirmpass;
      });
    }
    @override
    void dispose() {
      _phoneController.dispose();
      _nameController.dispose();
      _passController.dispose();
      _confirmPassController.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            Utils.showLoading(context);
          }
          if (state is RegisterApiFailure) {
            Utils.hideLoading(context);
            DialogNotice2.show(
                context,
                title: state.error,
                text: "Vui lòng đăng nhập bằng số điện thoại đã đăng ký. Nếu quên mật khẩu, hãy ấn vào “Quên mật khẩu”. Xin cảm ơn”",
                image: "assets/image/user_exist.png",
                onpress1: () {
                  final rootContext = Navigator.of(context, rootNavigator: true).context;
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  ForgotPasswordSheet.show(rootContext);
                },
                onpress2: () =>{
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => const LoginCustom()), // Trang bạn muốn tới
                        (Route<dynamic> route) => false,
                  )
                },
                textbutton1: "Quên mật khẩu",
                textbutton2: "Đăng nhập"
            );
          }
          if (state is RegisterSuccess) {
            Utils.hideLoading(context);
            DialogNotice1.show(
              context,
              title: "Đăng ký tài khoản thành công",
              text: "Nhấn tiếp tục để tới trang chủ My HDI",
              image: "assets/image/reset_password.png",
              onpress: () =>{
                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => const LoginUser()), // Trang bạn muốn tới
                      (Route<dynamic> route) => false,
                )
              },
              textbutton: "Tiếp tục"
            );
          }
          if (state is RegisterOtpSent) {
            Utils.hideLoading(context);
            _verificationId = state.verificationId;
            Register_OTP.show(
              context, (otp) {
                context.read<RegisterBloc>().add(
                  VerifyRegisterOtpRequested(
                    verificationId: _verificationId!,
                    otp: otp,
                    fullName: _nameController.text.trim(),
                    phoneNumber: _phoneController.text.trim(),
                    password: _passController.text,
                  ),
                );
              },
                  () {
                context.read<RegisterBloc>().add(
                  SendRegisterOtpRequested(
                    fullName: _nameController.text.trim(),
                    phoneNumber: _phoneController.text.trim(),
                    password: _passController.text,
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {String? error;
          if (state is RegisterApiFailure) {
            error = state.error;
          }
          return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
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
                        const Text(
                          "Đăng ký tài khoản",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.text,
                          onChanged: (_) => _validate(),
                          validator: AppValidators.validatorPhone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.grey),
                            labelText: "Số điện thoại",
                            labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                            floatingLabelStyle: const TextStyle(color: Color(0xFFBB8A0B)),
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
                        const SizedBox(height: 15),
                        BuildTextField(
                          controller: _nameController,
                          validator: AppValidators.validatorFullName,
                          hint: "Họ tên",
                          icon: Icons.person_outline,
                        ),
                        BuildPasswordField(
                          controller: _passController,
                          validator: AppValidators.validatorPassword,
                          hint: "Mật khẩu",
                          isObscure: _isObscurePass,
                          onToggle: () {
                            setState(() => _isObscurePass = !_isObscurePass);
                            _validate();
                          },
                        ),
                        BuildPasswordField(
                          controller: _confirmPassController,
                          validator: (value) => AppValidators.validatorConfirm(
                            value,
                            _passController.text,
                          ),
                          hint: "Xác nhận mật khẩu",
                          isObscure: _isObscureConfirm,
                          onToggle: () {
                            setState(() => _isObscureConfirm = !_isObscureConfirm);
                            _validate();
                          },
                        ),
                        const SizedBox(height: 45),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(text: "Bằng việc nhấn nút ĐĂNG KÝ, bạn đã đồng ý với "),
                              TextSpan(
                                text: "Điều khoản điều kiện của Bảo hiểm HD",
                                style: const TextStyle(
                                  color: Color(0xFFBB8A0B),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Clause()),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _canRegister ? () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              context.read<RegisterBloc>().add(
                                SendRegisterOtpRequested(
                                  fullName: _nameController.text.trim(),
                                  phoneNumber: _phoneController.text.trim(),
                                  password: _passController.text,
                                ),
                              );
                            }: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _canRegister ? const Color(0xFFBB8A0B) : Colors.grey[300],
                              disabledBackgroundColor: Colors.grey[200], // Màu khi bị disable
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              "Nhận mã xác nhận",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _canRegister ? Colors.white : Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
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