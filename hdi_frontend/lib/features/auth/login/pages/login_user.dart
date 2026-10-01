import 'package:flutter/material.dart';
import '../../../forgotpassword/presentation/pages/forgot_password.dart';
import '../../../home/presentation/pages/home_user.dart';
class LoginUser extends StatelessWidget{
  const LoginUser({super.key});
  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/bg_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
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
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.format_list_bulleted, color: Color(0xFFBB8A0B),size: 30,),
        onPressed: () {},
      ),
      actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 10),
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
class ContainerLogin extends StatelessWidget{
  const ContainerLogin({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(20),
     margin: EdgeInsets.only(top: 470),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
              "Chào mừng bạn Nguyễn Văn A\n"
                  "0373**0207",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: 40,),
          TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintText: "Mật khẩu",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.3),
                ),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                )
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const HomeUser(),
                      )
                    );
                  },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFBB8A0B),
                    minimumSize: Size(300, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                  child: Text("Đăng nhập",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
              ),
              TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(55, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Icon(Icons.face,
                size: 30,
                  color: Color(0xFFBB8A0B)
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: ()=> ForgotPasswordSheet.show(context), child: Text("Quên mật khẩu",style: TextStyle(fontSize: 18,color: Color(0xFFBB8A0B)))),
              TextButton(onPressed: (){}, child: Text("Đăng kí tài khoản",style: TextStyle(fontSize: 18,color: Color(0xFFBB8A0B))))
            ],
          )
        ],
      ),
   );
  }

}
