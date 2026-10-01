  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:my_hdi/features/auth/presentation/controllers/auth_bloc.dart';
import 'package:my_hdi/features/auth/presentation/controllers/auth_state.dart';
  
  import '../../../../../core/widgets/text_button_app.dart';
  import '../../../forgotpassword/presentation/pages/forgot_password.dart';
import '../../../home/presentation/pages/home_user.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  
  import '../../presentation/controllers/auth_event.dart';
import '../../register/pages/register.dart';
  import '../widgets/password_textfield.dart';
  import '../widgets/phone_textfield.dart';
  
  
  class LoginCustom extends StatefulWidget {
    const LoginCustom({super.key});
  
    @override
    State<LoginCustom> createState() => _LoginCustomState();
  }
  
  class _LoginCustomState extends State<LoginCustom> {
    @override
    Widget build(BuildContext context) {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/bg_login.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            appBar: HomeAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ContainerLogin(),
                ],
              ),
            ),
          ),
        );
    }
  }
  
  class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
    const HomeAppBar({super.key});
  
    @override
    Widget build(BuildContext context) {
      return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.format_list_bulleted, color: Color(0xFFBB8A0B), size: 30),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10), // Đã sửa lỗi EdgeInsetsGeometry
            child: Image.asset(
              "assets/image/covn.png",
              height: 30,
              width: 50,
            ),
          )
        ],
      );
    }
  
    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  }
  
  class ContainerLogin extends StatefulWidget {
    const ContainerLogin({super.key});
  
    @override
    State<ContainerLogin> createState() => _ContainerLoginState();
  }
  class _ContainerLoginState extends State<ContainerLogin> {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
  
    final _formKey = GlobalKey<FormState>();
  
    @override
    void dispose(){
      phoneController.dispose();
      passwordController.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<AuthBloc,AuthState>(
        listener: (context,state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeUser(),
              ),
            );
          }
          if(state is AuthFailure) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text("Đăng nhập thất bại",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  state.error, style: const TextStyle(fontSize: 16,),),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Đóng",
                      style: TextStyle(color: Color(0xFFBB8A0B)),
                    ),
                  )
                ],
              );
            },
            );
          }
          },
          builder: (context,state){
          return  Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 450),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chào mừng bạn",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 15),
                  PhoneTextField(controller:phoneController),
                  const SizedBox(height: 15),
                  PasswordTextField(
                    controller: passwordController,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextButtonApp("Đăng nhập",(){
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          context.read<AuthBloc>().add(
                              LoginRequested(
                                phoneController.text,
                                passwordController.text,
                              )
                          );
                        }),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size(55, 55),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: const Icon(Icons.face,
                              size: 30,
                              color: Color(0xFFBB8A0B)
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => ForgotPasswordSheet.show(context),
                          child: const Text("Quên mật khẩu", style: TextStyle(fontSize: 18, color: Color(0xFFBB8A0B)))
                      ),
                      TextButton(
                          onPressed: () => RegisterScreen.show(context),
                          child: const Text("Đăng kí tài khoản", style: TextStyle(fontSize: 18, color: Color(0xFFBB8A0B)))
                      )
                    ],
                  )
                ],
              ),
            ),
          );
      }
      );
  
  
  
    }
  }